const path = require('path');
const puppeteer = require(path.join(__dirname, 'node_modules', 'puppeteer'));

const chrome = 'C:/Program Files/Google/Chrome/Application/chrome.exe';
const outDir = __dirname;
const url = 'http://localhost:8765/';

(async () => {
  const browser = await puppeteer.launch({
    headless: 'new',
    executablePath: chrome,
    args: [
      '--no-sandbox',
      '--enable-webgl',
      '--use-gl=swiftshader',
      '--enable-accelerated-2d-canvas',
      '--ignore-gpu-blocklist',
    ]
  });
  
  const page = await browser.newPage();
  await page.setViewport({ width: 390, height: 844, deviceScaleFactor: 2 });
  
  // 1. Splash screen — wait longer for Flutter/WASM to initialize
  await page.goto(url, { waitUntil: 'networkidle0' });
  await new Promise(r => setTimeout(r, 5000));
  await page.screenshot({ path: path.join(outDir, '01_splash.png') });
  console.log('01_splash.png captured');

  // 2. Login screen (splash auto-navigates after 2s, we waited 5s so should be there)
  await new Promise(r => setTimeout(r, 1000));
  await page.screenshot({ path: path.join(outDir, '02_login.png') });
  console.log('02_login.png captured');

  // Flutter web uses flt-semantics for accessibility, click email field area by position
  // Login form is centered: email field ~40% down, password ~50% down, button ~60%
  await page.mouse.click(195, 340); // email field
  await new Promise(r => setTimeout(r, 300));
  await page.keyboard.type('pilot@foxer.fi');

  await page.mouse.click(195, 420); // password field
  await new Promise(r => setTimeout(r, 300));
  await page.keyboard.type('password123');

  await new Promise(r => setTimeout(r, 500));
  await page.screenshot({ path: path.join(outDir, '03_login_filled.png') });
  console.log('03_login_filled.png captured');

  // Click login button (~60% down)
  await page.mouse.click(195, 500);
  await new Promise(r => setTimeout(r, 2000));
  await page.screenshot({ path: path.join(outDir, '04_home_map.png') });
  console.log('04_home_map.png captured');

  // Navigate tabs by clicking at bottom nav positions
  const tabY = 820;
  const tabPositions = [390*0.125, 390*0.375, 390*0.625, 390*0.875];

  await page.mouse.click(tabPositions[1], tabY); // Lessons
  await new Promise(r => setTimeout(r, 1000));
  await page.screenshot({ path: path.join(outDir, '05_lessons.png') });
  console.log('05_lessons.png captured');

  await page.mouse.click(tabPositions[2], tabY); // Reading
  await new Promise(r => setTimeout(r, 1000));
  await page.screenshot({ path: path.join(outDir, '06_reading.png') });
  console.log('06_reading.png captured');

  await page.mouse.click(tabPositions[3], tabY); // Discussions
  await new Promise(r => setTimeout(r, 1000));
  await page.screenshot({ path: path.join(outDir, '07_discussions.png') });
  console.log('07_discussions.png captured');

  await browser.close();
  console.log('Done!');
})();
