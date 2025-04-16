const puppeteer = require("puppeteer");
const fs = require("fs");

const url = process.env.SCRAPE_URL;

if (!url) {
  console.error("Please set SCRAPE_URL environment variable.");
  process.exit(1);
}

(async () => {
  const browser = await puppeteer.launch({
    headless: true,
    args: ['--no-sandbox', '--disable-setuid-sandbox'],
  });

  const page = await browser.newPage();
  await page.goto(url, { waitUntil: "domcontentloaded" });

  const data = await page.evaluate(() => {
    return {
      title: document.title,
      firstHeading: document.querySelector("h1")?.innerText || "No <h1> found",
      headings: Array.from(document.querySelectorAll("h1, h2, h3, h4, h5, h6")).map(el => el.innerText)

    };
  });

  fs.writeFileSync("scraped_data.json", JSON.stringify(data, null, 2));
  console.log("Data scraped and saved to scraped_data.json");

  await browser.close();
})();

