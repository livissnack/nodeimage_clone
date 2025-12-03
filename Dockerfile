FROM node:21-alpine AS builder

WORKDIR /app

COPY package*.json ./
RUN apk add --no-cache python3 make g++ \
    && npm ci --production --prefer-dedupe \
    && npm cache clean --force \
    && apk del python3 make g++

FROM node:21-alpine

WORKDIR /app

COPY --from=builder /app/node_modules ./node_modules
COPY package*.json ./

COPY public ./public
COPY server.js ./server.js
COPY data ./data
RUN mkdir -p uploads/thumbs

ENV PORT=7878
EXPOSE 7878

CMD ["node", "server.js"]
