# Spring PetClinic Sample Application [![Build Status](https://github.com/spring-projects/spring-petclinic/actions/workflows/maven-build.yml/badge.svg)](https://github.com/spring-projects/spring-petclinic/actions/workflows/maven-build.yml)

[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/spring-projects/spring-petclinic) [![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://github.com/codespaces/new?hide_repo_select=true&ref=main&repo=7517918)

## Understanding the Spring Petclinic application with a few diagrams

[See the presentation here](https://speakerdeck.com/michaelisvy/spring-petclinic-sample-application)

## Run Petclinic locally

Spring Petclinic is a [Spring Boot](https://spring.io/guides/gs/spring-boot) application built using [Maven](https://spring.io/guides/gs/maven/) or [Gradle](https://spring.io/guides/gs/gradle/). You can build a jar file and run it from the command line (it should work just as well with Java 17 or newer):

```bash
git clone https://github.com/spring-projects/spring-petclinic.git
cd spring-petclinic
./mvnw package
java -jar target/*.jar
```

You can then access the Petclinic at <http://localhost:8080/>.

<img width="1042" alt="petclinic-screenshot" src="https://cloud.githubusercontent.com/assets/838318/19727082/2aee6d6c-9b8e-11e6-81fe-e889a5ddfded.png">

Or you can run it from Maven directly using the Spring Boot Maven plugin. If you do this, it will pick up changes that you make in the project immediately (changes to Java source files require a compile as well - most people use an IDE for this):

```bash
./mvnw spring-boot:run
```

> NOTE: If you prefer to use Gradle, you can build the app using `./gradlew build` and look for the jar file in `build/libs`.

## Building a Container

There is no `Dockerfile` in this project. You can build a container image (if you have a docker daemon) using the Spring Boot build plugin:

```bash
./mvnw spring-boot:build-image
```

## In case you find a bug/suggested improvement for Spring Petclinic

Our issue tracker is available [here](https://github.com/spring-projects/spring-petclinic/issues).

## Database configuration

In its default configuration, Petclinic uses an in-memory database (H2) which
gets populated at startup with data. The h2 console is exposed at `http://localhost:8080/h2-console`,
and it is possible to inspect the content of the database using the `jdbc:h2:mem:<uuid>` URL. The UUID is printed at startup to the console.

A similar setup is provided for MySQL and PostgreSQL if a persistent database configuration is needed. Note that whenever the database type changes, the app needs to run with a different profile: `spring.profiles.active=mysql` for MySQL or `spring.profiles.active=postgres` for PostgreSQL.

You can start MySQL or PostgreSQL locally with whatever installer works for your OS or use docker:

```bash
docker run -e MYSQL_USER=petclinic -e MYSQL_PASSWORD=petclinic -e MYSQL_ROOT_PASSWORD=root -e MYSQL_DATABASE=petclinic -p 3306:3306 mysql:8.2
```

or

```bash
docker run -e POSTGRES_USER=petclinic -e POSTGRES_PASSWORD=petclinic -e POSTGRES_DB=petclinic -p 5432:5432 postgres:16.1
```

Further documentation is provided for [MySQL](https://github.com/spring-projects/spring-petclinic/blob/main/src/main/resources/db/mysql/petclinic_db_setup_mysql.txt)
and [PostgreSQL](https://github.com/spring-projects/spring-petclinic/blob/main/src/main/resources/db/postgres/petclinic_db_setup_postgres.txt).

Instead of vanilla `docker` you can also use the provided `docker-compose.yml` file to start the database containers. Each one has a profile just like the Spring profile:

```bash
docker-compose --profile mysql up
```

or

```bash
docker-compose --profile postgres up
```

## Test Applications

At development time we recommend you use the test applications set up as `main()` methods in `PetClinicIntegrationTests` (using the default H2 database and also adding Spring Boot Devtools), `MySqlTestApplication` and `PostgresIntegrationTests`. These are set up so that you can run the apps in your IDE to get fast feedback and also run the same classes as integration tests against the respective database. The MySql integration tests use Testcontainers to start the database in a Docker container, and the Postgres tests use Docker Compose to do the same thing.

## Compiling the CSS

There is a `petclinic.css` in `src/main/resources/static/resources/css`. It was generated from the `petclinic.scss` source, combined with the [Bootstrap](https://getbootstrap.com/) library. If you make changes to the `scss`, or upgrade Bootstrap, you will need to re-compile the CSS resources using the Maven profile "css", i.e. `./mvnw package -P css`. There is no build profile for Gradle to compile the CSS.

## Working with Petclinic in your IDE

### Prerequisites

The following items should be installed in your system:

- Java 17 or newer (full JDK, not a JRE)
- [Git command line tool](https://help.github.com/articles/set-up-git)
- Your preferred IDE
  - Eclipse with the m2e plugin. Note: when m2e is available, there is an m2 icon in `Help -> About` dialog. If m2e is
  not there, follow the install process [here](https://www.eclipse.org/m2e/)
  - [Spring Tools Suite](https://spring.io/tools) (STS)
  - [IntelliJ IDEA](https://www.jetbrains.com/idea/)
  - [VS Code](https://code.visualstudio.com)

### Steps

1. On the command line run:

    ```bash
    git clone https://github.com/spring-projects/spring-petclinic.git
    ```

1. Inside Eclipse or STS:

    Open the project via `File -> Import -> Maven -> Existing Maven project`, then select the root directory of the cloned repo.

    Then either build on the command line `./mvnw generate-resources` or use the Eclipse launcher (right-click on project and `Run As -> Maven install`) to generate the CSS. Run the application's main method by right-clicking on it and choosing `Run As -> Java Application`.

1. Inside IntelliJ IDEA:

    In the main menu, choose `File -> Open` and select the Petclinic [pom.xml](pom.xml). Click on the `Open` button.

    - CSS files are generated from the Maven build. You can build them on the command line `./mvnw generate-resources` or right-click on the `spring-petclinic` project then `Maven -> Generates sources and Update Folders`.

    - A run configuration named `PetClinicApplication` should have been created for you if you're using a recent Ultimate version. Otherwise, run the application by right-clicking on the `PetClinicApplication` main class and choosing `Run 'PetClinicApplication'`.

1. Navigate to the Petclinic

    Visit [http://localhost:8080](http://localhost:8080) in your browser.

## Looking for something in particular?

|Spring Boot Configuration | Class or Java property files  |
|--------------------------|---|
|The Main Class | [PetClinicApplication](https://github.com/spring-projects/spring-petclinic/blob/main/src/main/java/org/springframework/samples/petclinic/PetClinicApplication.java) |
|Properties Files | [application.properties](https://github.com/spring-projects/spring-petclinic/blob/main/src/main/resources) |
|Caching | [CacheConfiguration](https://github.com/spring-projects/spring-petclinic/blob/main/src/main/java/org/springframework/samples/petclinic/system/CacheConfiguration.java) |

## Interesting Spring Petclinic branches and forks

The Spring Petclinic "main" branch in the [spring-projects](https://github.com/spring-projects/spring-petclinic)
GitHub org is the "canonical" implementation based on Spring Boot and Thymeleaf. There are
[quite a few forks](https://spring-petclinic.github.io/docs/forks.html) in the GitHub org
[spring-petclinic](https://github.com/spring-petclinic). If you are interested in using a different technology stack to implement the Pet Clinic, please join the community there.

## Interaction with other open-source projects

One of the best parts about working on the Spring Petclinic application is that we have the opportunity to work in direct contact with many Open Source projects. We found bugs/suggested improvements on various topics such as Spring, Spring Data, Bean Validation and even Eclipse! In many cases, they've been fixed/implemented in just a few days.
Here is a list of them:

| Name | Issue |
|------|-------|
| Spring JDBC: simplify usage of NamedParameterJdbcTemplate | [SPR-10256](https://jira.springsource.org/browse/SPR-10256) and [SPR-10257](https://jira.springsource.org/browse/SPR-10257) |
| Bean Validation / Hibernate Validator: simplify Maven dependencies and backward compatibility |[HV-790](https://hibernate.atlassian.net/browse/HV-790) and [HV-792](https://hibernate.atlassian.net/browse/HV-792) |
| Spring Data: provide more flexibility when working with JPQL queries | [DATAJPA-292](https://jira.springsource.org/browse/DATAJPA-292) |

## Contributing

The [issue tracker](https://github.com/spring-projects/spring-petclinic/issues) is the preferred channel for bug reports, feature requests and submitting pull requests.

For pull requests, editor preferences are available in the [editor config](.editorconfig) for easy use in common text editors. Read more and download plugins at <https://editorconfig.org>. If you have not previously done so, please fill out and submit the [Contributor License Agreement](https://cla.pivotal.io/sign/spring).

## License

The Spring PetClinic sample application is released under version 2.0 of the [Apache License](https://www.apache.org/licenses/LICENSE-2.0).



## Training for Docker (compose)
This training covers advanced Docker build/run techniques. The goal is to learn how to optimize the build speed of a Docker image (using caching), and building a local, Docker-Compose-based development environment for a Gradle-based application.

# Prerequisites
Docker Desktop (requires license from operations) or Colima (see Colima installation tutorial)
Basic Docker knowledge, regarding building and running images
Basic Docker Compose knowledge

# Preparation steps
On GitHub.com, create a fork of https://github.com/spring-projects/spring-petclinic. If you use the normal fork feature, your fork will always be public. If you want your project's visibility to be private, you have to use https://github.com/new/import instead of forking.

# Task 1: Build an optimized Dockerfile
The goal is to containerize the Petclinic application so that the image build speed is as fast as possible, thanks to intelligent use of BuildKit's caching mechanism.

Create a multi-stage Dockerfile whose first stage (called "build") builds the application with Gradle as .jar file (based on a Java SDK image), the second stage (called "final", based on a Java JRE image) copies the built .jar file into the final image and sets a CMD to start it
Whenever you change some of the .java source code..
... the corresponding RUN statement in your Dockerfile should only rebuild the application. It should not download Gradle or any jar-file dependencies again.
... only those java files that were changed since the last image build should be rebuilt
In the second stage, use the COPY --link trick, and explain to your mentor what it does and why we should use it
Make sure that the final image (the second stage) is actually runnable (docker run -p 8080:8080 ...) and that the frontend loads
Look out for error messages such as Removing daemon from the registry due to communication failure and find a way to fix them
Hints:

# Helpful resources:
https://www.augmentedmind.de/2022/01/23/optimize-docker-build-speed-in-ci/
https://docs.docker.com/language/java/build-images/
https://www.augmentedmind.de/2023/02/05/docker-image-analysis-and-diffing/

For an equivalent to Maven's ./mvnw dependency:resolve (which downloads Maven itself and the dependencies), search for Gradle's write-verification-metadata flag, that you provide to Gradle's help target. Gradle then downloads dependencies, and generates a verification metadata XML file which you should delete again, as you would otherwise run into problems during the Gradle buildstep (the build step would fail to verify at least some of the dependencies).
To see the full history of the output of BuildKit, set the environment variable BUILDKIT_PROGRESS=plain
To avoid that always all java-files are rebuilt, see https://docs.gradle.org/current/userguide/build_cache.html

# Task 2: Local developer setup with docker-compose
A common problem in projects is that developers prefer using natively installed tooling (e.g. a Java SDK installed directly on their Macbook) over Docker-based development. However, in any deployed environment (e.g. production) and in CI/CD pipelines, we use containers to build/test/run the apps.

In order to make it easy for developers to test whether the app image can be built locally, runs locally, or tests pass, many projects have a docker-compose.yaml, to simulate a "production-like" environment that uses containers.

The goal of this task is to build a docker-compose.yaml file:

When the app runs, it should not use the embedded H2 database, but a MySQL database (which you need to define as a separate service in docker-compose.yaml). The Petclinic's README provides some details here, and the repository also comes with a docker-compose.yaml file that you can base your docker-compose.yaml file on. So in total, your docker-compose.yaml file should define two services, one for the Petclinic app, one for the database.
Note: the term "profile" used in the Petclinic README is ambiguous! A docker-compose profile is something different than a Spring profile! The Petclinic app already comes with pre-made Spring profiles that instruct the backend to use the MySQL database, see the application-mysql.properties file stored in the repo.
When you run docker-compose up -d, the MySQL service should start, and only once it is up and the port is reachable (hint: docker-compose supports health checks), the app container should be started. Otherwise, the Spring Boot app might try to connect to the MySQL database which is not ready yet, and throw errors.
Publish the Petclinic's container port so that you can access the website in your browser
If you run docker compose up [-d], and your Petclinic image has never been built yet, it should be automatically built
Hints:

https://reflectoring.io/spring-boot-profiles/
https://docs.docker.com/compose/compose-file/compose-versioning/ (read the red box carefully, essentially the take-away message is that you should not have a version: "x.y" block at the top of your docker-compose.yaml file anymore, because these are for the Compose V1 legacy version. These Docker folks have some brain damage when it comes to versioning.)
https://docs.docker.com/compose/compose-file/build/

# Task 3: reducing copy and paste of DB credentials
In your current solution, you most likely have multiple copies of the strings that define the MySQL database host, database name, username and password (spread over the Spring Profile file and the docker-compose.yaml file). This is bad, because if you change the value in one location, you have to remember to replace it in all other locations.

Make use of the .env file mechanism of Docker Compose, to reduce these redundancies as much as possible.

# Task 4: running tests with docker compose
The goal is to allow your developers to run unit tests against the MySQL database. Because this is an integration test (no longer a unit test), it should not be done as part of building an image, but should be run as container.

In your Dockerfile, introduce a new stage called "testhelper" (FROM build as testhelper) which copies the /root/.gradle mounted-cache folder into the image

(example: RUN --mount=type=cache,id=gradle-cache,target=/.gradle cp -R /.gradle /root).

Introduce a new "test" service in your docker-compose.yaml which builds this new "testhelper" stage and runs the resulting image as container, overwriting the entrypoint/CMD to execute the Gradle command that triggers the test suite (configuring the mysql Spring profile). Make sure that this test container does not automatically restart once the test has completed

Use Docker Compose profiles to differentiate whether docker compose up should run the Petclinic app normally, or whether it should run the tests
