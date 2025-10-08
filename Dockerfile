FROM node:alpine

WORKDIR /app


COPY package*.json .

COPY pnpm-lock.yaml .

RUN npx pnpm install --frozen-lockfile

COPY . .

EXPOSE 4000

CMD npx pnpm start:dev