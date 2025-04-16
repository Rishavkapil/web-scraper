# 🕸️ Web Scraper + Flask API

## 📌 Objective

This project demonstrates a containerized solution that combines the power of:
- **Node.js + Puppeteer** to scrape content from a dynamic website.
- **Python + Flask** to serve the scraped content as a REST API.
- A **multi-stage Dockerfile** to keep the final image lightweight and production-ready.

---

## 🧩 Features

✅ Scrape a user-defined URL  
✅ Extract page `<title>` and first `<h1>`  
✅ Store scraped data in `scraped_data.json`  
✅ Serve it using Flask at `http://localhost:5000`  
✅ Clean, multi-stage Docker build

---

## 🔧 Technologies Used

- Node.js (v18-slim)
- Puppeteer
- Chromium
- Python (3.10-slim)
- Flask
- Docker

---

## 🚀 How to Use

### Build the Docker image

Replace `https://example.com` with the site you want to scrape:

``` bash
docker build --build-arg SCRAPE_URL=https://example.com -t web-scraper .
```

### Run the Container

``` bash 
docker run -p 5000:5000 web-scraper
```

### Access the Scraped Data 

open your Browser and visit: 

http://localhost:5000


You'll see a JSON response like : 

{
  "title": "Example Domain",
  "firstHeading": "Example Domain"
}

If no ``` <h1> ``` exist on the page , you'll see something like : 

{
  "title": "Google",
  "firstHeading": "No ``` <h1> ``` found"
}

