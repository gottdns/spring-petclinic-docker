FROM eclipse-temurin:17-jdk-jammy as build
WORKDIR /app
COPY . .
RUN ./gradlew --build-cache --mount=type=cache,id=gradle-cache,target=/.gradle --write-verification-metadata sha256 build -x test

FROM ibm-semeru-runtimes:open-17-jre-jammy as final
COPY --link --from=build /app/target/spring-petclinic-*.jar /spring-petclinic.jar
CMD ["java", "-Djava.security.egd=file:/dev/./urandom -Dspring.profiles.active=mysql", "-jar", "/spring-petclinic.jar"]

FROM build as testhelper
RUN --mount=type=cache,id=gradle-cache,target=/.gradle cp -R /.gradle /root
RUN ./gradlew test --status --warning-mode all