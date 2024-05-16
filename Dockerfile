FROM node:20-alpine3.18 as deps
WORKDIR /usr/app

# без локфайла, в контейнере другая ос
COPY ./package.json ./
# не даем зависимостям утечь в фс хостовой машины
COPY ./.dockerignore ./

RUN npm install

FROM node:20-alpine3.18
WORKDIR /usr/app
COPY . ./

COPY --from=deps /usr/app/ ./

ENV NODE_ENV develop
ENV PORT 19932

EXPOSE $PORT

CMD ["npm", "run", "develop"]

