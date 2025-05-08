# 使用 debian base image 而非 alpine，因為要裝 puppeteer 依賴
FROM node:18-bullseye

# 設定工作目錄
WORKDIR /app

# 安裝 puppeteer 執行所需的套件
RUN apt-get update && apt-get install -y \
  wget \
  ca-certificates \
  fonts-liberation \
  libappindicator3-1 \
  libasound2 \
  libatk-bridge2.0-0 \
  libatk1.0-0 \
  libcups2 \
  libdbus-1-3 \
  libgdk-pixbuf2.0-0 \
  libnspr4 \
  libnss3 \
  libx11-xcb1 \
  libxcomposite1 \
  libxdamage1 \
  libxrandr2 \
  xdg-utils \
  --no-install-recommends && rm -rf /var/lib/apt/lists/*

# 安裝 n8n 與 puppeteer node 支援
RUN npm install -g n8n n8n-nodes-puppeteer

# 建立必要資料夾
RUN mkdir /data
ENV N8N_USER_FOLDER="/data"

# Railway 環境變數登入設定
ENV N8N_BASIC_AUTH_ACTIVE=true
ENV N8N_BASIC_AUTH_USER=admin
ENV N8N_BASIC_AUTH_PASSWORD=yourpassword
ENV DB_TYPE=sqlite
ENV DB_SQLITE_DATABASE=/data/database.sqlite
ENV WEBHOOK_URL=https://n8n.xi-za.com/

# Railway Volume 掛載點（記得去設定一個 volume 並掛上 /data）
# DO NOT USE VOLUME 指令！Railway 禁止

# 啟動指令
CMD ["n8n"]
