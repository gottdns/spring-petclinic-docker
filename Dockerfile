FROM eclipse-temurin:17-jdk-jammy as build
WORKDIR /app
COPY . .
RUN ./gradlew build -x processTestAot

# FROM base as final
# RUN ./mvnw test

# FROM ibm-semeru-runtimes:open-17-jre-jammy as production
# COPY --from=base /app/target/spring-petclinic-*.jar /spring-petclinic.jar
# CMD ["java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "/spring-petclinic.jar"]

#export var für besseres logging