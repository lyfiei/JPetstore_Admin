# ==========================================
# 构建阶段：Maven 编译打包
# ==========================================
FROM maven:3.9-eclipse-temurin-21 AS build

WORKDIR /app

# 先复制 POM 文件，利用 Docker 缓存层下载依赖
COPY pom.xml .
COPY store-common/pom.xml store-common/
COPY store-model/pom.xml store-model/
COPY store-dao/pom.xml store-dao/
COPY store-service/pom.xml store-service/
COPY store-admin-web/pom.xml store-admin-web/

# 下载依赖（此层可被缓存，源码改动时不会重复下载）
RUN mvn dependency:go-offline -B -q

# 复制源码
COPY store-common/src store-common/src/
COPY store-model/src store-model/src/
COPY store-dao/src store-dao/src/
COPY store-service/src store-service/src/
COPY store-admin-web/src store-admin-web/src/

# 编译打包（跳过测试）
RUN mvn clean package -DskipTests -B -q

# ==========================================
# 运行阶段：JRE 运行环境
# ==========================================
FROM eclipse-temurin:21-jre-alpine

# 设置时区
RUN apk add --no-cache tzdata curl && \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone && \
    apk del tzdata

WORKDIR /app

# 从构建阶段复制 fat JAR
COPY --from=build /app/store-admin-web/target/*.jar app.jar

# 创建非 root 用户运行应用
RUN addgroup -g 1000 appgroup && \
    adduser -u 1000 -G appgroup -D appuser && \
    chown -R appuser:appgroup /app

USER appuser

EXPOSE 8080

# JVM 参数（可通过 JAVA_OPTS 环境变量覆盖）
ENV JAVA_OPTS="-Xms256m -Xmx512m -XX:+UseG1GC -XX:MaxGCPauseMillis=200"

ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]
