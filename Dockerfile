FROM openjdk:8u121-jdk-alpine

MAINTAINER Matheus Fidelis <msfidelis01@gmail.com>

COPY elasticmq-sqs /elasticmq-sqs
COPY configs /configs

WORKDIR /elasticmq-sqs

ENV DBPORT=9324

EXPOSE 9324

CMD ["java", "-Dconfig.file=/configs/custom.conf", "-jar", "elasticmq-server-0.13.4.jar"]
