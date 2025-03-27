# Stage 1: Build ứng dụng với Gradle 8.13 và JDK 24
FROM gradle:8.13-jdk24 AS builder

WORKDIR /app

# Copy toàn bộ source code vào container
COPY . .

# Build ứng dụng Spring Boot với Gradle
RUN gradle clean bootJar --no-daemon

# Stage 2: Chạy ứng dụng với OpenJDK 24
FROM openjdk:24

WORKDIR /app

# Copy file JAR từ stage 1
COPY --from=builder /app/build/libs/testk8s.jar app.jar

# Mở cổng 9080
EXPOSE 9080

# Chạy ứng dụng Spring Boot
ENTRYPOINT ["java", "-jar", "app.jar"]
