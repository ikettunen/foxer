const { execSync } = require('child_process');
const path = require('path');

const chrome = 'C:/Program Files/Google/Chrome/Application/chrome.exe';
const outDir = 'C:/Users/ikett/foxer/screenshots';
const url = 'http://localhost:8765/';

// We'll use puppeteer for proper delayed screenshots
console.log('Installing puppeteer...');
execSync('npm install puppeteer', { cwd: outDir, stdio: 'inherit' });

const puppeteer = require(path.join(outDir, 'node_modules', 'puppeteer'));

(async () => {
  const browser = await puppeteer.launch({
    headless: 'new',
    executablePath: chrome,
    args: ['--no-sandbox']
  });
  
  const page = await browser.newPage();
  await page.setViewport({ width: 390, height: 844, deviceScaleFactor: 2 });
  
  // 1. Splash screen
  await page.goto(url, { waitUntil: 'networkidle0' });
  await new Promise(r => setTimeout(r, 1500));
  await page.screenshot({ path: path.join(outDir, '01_splash.png') });
  console.log('01_splash.png captured');
  
  // 2. Wait for login screen (splash auto-navigates after 2s)
  await new Promise(r => setTimeout(r, 3000));
  await page.screenshot({ path: path.join(outDir, '02_login.png') });
  console.log('02_login.png captured');
  
  // 3. Fill login form
  await page.waitForSelector('input');
  const inputs = await page.$$('input');
  if (inputs.length >= 2) {
    await inputs[0].type('pilot@foxer.fi');
    await inputs[1].type('password123');
    await new Promise(r => setTimeout(r, 500));
    await page.screenshot({ path: path.join(outDir, '03_login_filled.png') });
    console.log('03_login_filled.png captured');
    
    // 4. Click login button
    const buttons = await page.$$('button');
    for (const btn of buttons) {
      const text = await btn.evaluate(el => el.textContent);
      if (text.includes('Login')) {
        await btn.click();
        break;
      }
    }
    await new Promise(r => setTimeout(r, 2000));
    await page.screenshot({ path: path.join(outDir, '04_home_map.png') });
    console.log('04_home_map.png captured');
    
    // 5. Navigate tabs - find bottom nav items
    // Lessons tab
    const navItems = await page.$$('button');
    // Try clicking navigation destinations by looking for specific text
    await page.evaluate(() => {
      const items = document.querySelectorAll('[class*="NavigationDestination"], [role="tab"]');
      if (items.length > 1) items[1].click();
    });
    await new Promise(r => setTimeout(r, 1000));
    await page.screenshot({ path: path.join(outDir, '05_lessons.png') });
    console.log('05_lessons.png captured');
    
    // Reading tab
    await page.evaluate(() => {
      const items = document.querySelectorAll('[class*="NavigationDestination"], [role="tab"]');
      if (items.length > 2) items[2].click();
    });
    await new Promise(r => setTimeout(r, 1000));
    await page.screenshot({ path: path.join(outDir, '06_reading.png') });
    console.log('06_reading.png captured');
    
    // Discussions tab
    await page.evaluate(() => {
      const items = document.querySelectorAll('[class*="NavigationDestination"], [role="tab"]');
      if (items.length > 3) items[3].click();
    });
    await new Promise(r => setTimeout(r, 1000));
    await page.screenshot({ path: path.join(outDir, '07_discussions.png') });
    console.log('07_discussions.png captured');
  }
  
  await browser.close();
  console.log('All screenshots captured!');
})();
