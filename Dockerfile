FROM n8nio/n8n

# 基本認證（如你設定）
ENV N8N_BASIC_AUTH_ACTIVE=true
ENV N8N_BASIC_AUTH_USER=admin
ENV N8N_BASIC_AUTH_PASSWORD=yourpassword

# Webhook 與 DB 設定
ENV WEBHOOK_URL=https://your-app.up.railway.app/
ENV DB_TYPE=sqlite
ENV DB_SQLITE_DATABASE=/home/node/.n8n/database.sqlite

# 安裝 puppeteer 所需系統依賴
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

# 安裝 n8n-nodes-puppeteer 套件
RUN npm install -g n8n-nodes-puppeteer

VOLUME ["/home/node/.n8n"]

CMD ["n8n"]
