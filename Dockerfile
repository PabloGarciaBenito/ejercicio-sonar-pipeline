FROM openjdk:8-jre-alpine

RUN mkdir /app

COPY /home/jenkins/jenkins/jenkins_home/workspace/prueba/app/target/*.jar /app/prueba.jar