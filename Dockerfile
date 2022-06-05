FROM openjdk:11
LABEL maintainer="roshan"
ADD target/hello-world-spring-boot-pom-0.0.1-SNAPSHOT.jar hello-world-spring-boot-pom.jar
ENTRYPOINT ["java", "-jar", "hello-world-spring-boot-pom.jar"]
