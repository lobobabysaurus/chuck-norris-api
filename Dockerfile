FROM node:6.10.2

RUN apt-get update; apt-get install -y awscli

WORKDIR /chuck

COPY . .
