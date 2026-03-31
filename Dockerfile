FROM openjdk:26-ea-17-jdk-slim as builder
RUN mkdir -p /app/source
COPY . /app/source
WORKDIR /app/source
RUN ./mvnw clean package


FROM builder
COPY --from=builder /app/source/target/*.jar /app/app.jar
EXPOSE 8081
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom", "-jar", "/app/app.jar"]
