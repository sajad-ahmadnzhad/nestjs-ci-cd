FROM node:alpine

WORKDIR /app

COPY package*.json .

COPY pnpm-lock.yaml .

RUN npx pnpm install --frozen-lockfile

COPY . .

EXPOSE 4000

CMD npx prisma generate && npx prisma migrate deploy && npx pnpm start:dev