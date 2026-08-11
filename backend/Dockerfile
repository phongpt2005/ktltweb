FROM eclipse-temurin:11-jre
WORKDIR /app
COPY target/*.jar app.jar
EXPOSE 8081
ENV JAVA_OPTS="-Xmx256m -Xms128m -XX:+UseSerialGC -XX:MaxMetaspaceSize=100m"
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]