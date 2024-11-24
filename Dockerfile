# Sử dụng JDK 17 làm base image
FROM openjdk:17-jdk-slim

# Đặt thư mục làm việc trong container
WORKDIR /app

COPY target/fashion_shop-0.0.1-SNAPSHOT.jar app.jar

# Expose cổng 2308 để chạy ứng dụng
EXPOSE 2308

# Command để chạy ứng dụng
ENTRYPOINT ["java", "-jar", "app.jar"]
