FROM node:alpine

WORKDIR /app

COPY . .

COPY package*.json .

COPY pnpm-lock.yaml .

RUN npx pnpm install --frozen-lockfile

CMD npx pnpm start:dev