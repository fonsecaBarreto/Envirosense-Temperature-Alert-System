FROM node:18.0.0

WORKDIR /usr/src/app

COPY --chown=node:node package*.json ./

RUN npm install

COPY --chown=node:node . .

USER node

EXPOSE 3000

CMD [ "npm", "run", "start" ]

