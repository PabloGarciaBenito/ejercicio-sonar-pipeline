FROM openjdk:8-jre-alpine

RUN mkdir /app

COPY *.jar /app/prueba.jar