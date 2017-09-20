FROM node:slim
EXPOSE 1337

RUN mkdir /usr/src/app

WORKDIR /usr/src/app

COPY nodeserver/server.js .

CMD node server.js
