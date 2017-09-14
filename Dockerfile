FROM node:slim
EXPOSE 8080

RUN mkdir /usr/src/app && \
    mkdir /usr/src/app/website

WORKDIR /usr/src/app

COPY server.js .
COPY package.json .
COPY package-lock.json .
COPY website/index.html ./website/

RUN npm install

CMD node server.js
