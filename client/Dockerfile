FROM node:slim
EXPOSE 8081

RUN mkdir /usr/src/app && \
    mkdir /usr/src/app/website

WORKDIR /usr/src/app

COPY client/client.js .
COPY website/index.html ./website/

CMD node client.js
