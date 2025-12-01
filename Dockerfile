FROM node:18-alpine

WORKDIR /app

# 安装依赖
COPY package*.json ./
RUN apk add --no-cache python3 make g++ \
    && npm ci --production

# 拷贝应用代码
COPY public ./public
COPY server.js ./server.js
COPY data ./data
RUN mkdir -p uploads/thumbs

ENV PORT=3000
EXPOSE 3000

# 启动服务
CMD ["node", "server.js"]
