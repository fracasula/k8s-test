FROM node:slim
EXPOSE 8080

RUN mkdir /usr/src/app && \
    mkdir /usr/src/app/website

WORKDIR /usr/src/app

COPY server.js .
COPY website/index.html ./website/

CMD node server.js
