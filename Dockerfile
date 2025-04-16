# Stage 1 
FROM node:18-slim AS scraper

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true

# Install Chromium
RUN apt-get update && apt-get install -y \
  chromium \
  ca-certificates \
  fonts-liberation \
  libappindicator3-1 \
  libasound2 \
  libatk-bridge2.0-0 \
  libnspr4 \
  libnss3 \
  libxss1 \
  libx11-xcb1 \
  --no-install-recommends && \
  rm -rf /var/lib/apt/lists/*

# Set up Node environment
WORKDIR /app
COPY package.json .
RUN npm install
COPY scrape.js .

# Accept a URL at build-time
ARG SCRAPE_URL
ENV SCRAPE_URL=$SCRAPE_URL

# Run the scraper and generate scraped_data.json
RUN node scrape.js

# Stage 2: Python Flask server
FROM python:3.10-slim

WORKDIR /app

# Copy JSON from scraper stage
COPY --from=scraper /app/scraped_data.json .

# Copy server code
COPY server.py .
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 5000

CMD ["python", "server.py"]

