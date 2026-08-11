# Stage 1: Build (Memory optimized for 512MB limit)
FROM maven:3.8.6-eclipse-temurin-11 AS build
WORKDIR /app
ENV MAVEN_OPTS="-Xmx256m -XX:+UseG1GC"
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests -B

# Stage 2: Run
FROM eclipse-temurin:11-jre
WORKDIR /app
ENV JAVA_OPTS="-Xmx256m -Xms128m"
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8081
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]