FROM openjdk:8-jre-alpine

RUN mkdir /app

COPY /var/jenkins_home/workspace/prueba/app/target/*.jar /app/prueba.jar