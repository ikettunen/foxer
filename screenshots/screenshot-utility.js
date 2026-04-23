/**
 * Screenshot Utility for Foxer Paragliding App
 * 
 * Takes screenshots of the running Flutter web app on Chrome
 * 
 * Prerequisites:
 * - App must be running: flutter run -d chrome
 * - Node.js installed
 * - Dependencies installed: npm install puppeteer
 * 
 * Usage:
 * node screenshots/screenshot-utility.js
 */

const puppeteer = require('puppeteer');
const fs = require('fs');
const path = require('path');

// Configuration
const CONFIG = {
  // Try common Flutter dev server ports
  ports: [51234, 51235, 8080, 5000],
  // Screenshot settings  
  width: 1280,
  height: 720,
  // Timeouts
  launchTimeout: 10000,
  waiTimeout: 3000,
};

// Create screenshots directory
const screenshotsDir = path.join(__dirname);
if (!fs.existsSync(screenshotsDir)) {
  fs.mkdirSync(screenshotsDir, { recursive: true });
}

/**
 * Find the running Flutter app's port
 */
async function findFlutterPort() {
  for (const port of CONFIG.ports) {
    try {
      const url = `http://localhost:${port}`;
      const response = await fetch(url, { timeout: 1000 });
      if (response.ok) {
        console.log(`✅ Found running app at ${url}`);
        return port;
      }
    } catch (e) {
      // Port not available, try next
    }
  }
  throw new Error(
    `❌ Could not find running Flutter app. Start with: flutter run -d chrome`
  );
}

/**
 * Wait for element to appear on page
 */
async function waitForElement(page, selector, timeout = 5000) {
  try {
    await page.waitForSelector(selector, { timeout });
    return true;
  } catch {
    return false;
  }
}

/**
 * Take a screenshot and save with timestamp
 */
async function takeScreenshot(page, name, description = '') {
  const timestamp = new Date().toISOString().replace(/[:.]/g, '-').slice(0, -5);
  const filename = `${name}_${timestamp}.png`;
  const filepath = path.join(screenshotsDir, filename);
  
  await page.screenshot({ path: filepath, fullPage: false });
  console.log(`📸 Saved: ${filename}`);
  if (description) {
    console.log(`   ${description}`);
  }
  return filepath;
}

/**
 * Main screenshot routine
 */
async function captureScreenshots() {
  let browser;
  
  try {
    console.log('🚀 Foxer Paragliding - Screenshot Capture\n');
    
    // Find running app
    const port = await findFlutterPort();
    const appUrl = `http://localhost:${port}`;
    
    // Launch browser
    console.log('🌐 Launching browser...');
    browser = await puppeteer.launch({
      headless: false,
      args: ['--no-sandbox', '--disable-setuid-sandbox'],
    });
    
    const page = await browser.newPage();
    await page.setViewport({ width: CONFIG.width, height: CONFIG.height });
    
    // Load app
    console.log('⏳ Loading app...');
    await page.goto(appUrl, { waitUntil: 'networkidle0' });
    await page.waitForTimeout(2000); // Wait for initial load
    
    // Screenshot 1: Splash Screen
    console.log('\n📸 Capturing Splash Screen...');
    await takeScreenshot(
      page,
      '01_splash',
      'Splash screen with Foxer branding'
    );
    
    // Wait for navigation to login or home
    await page.waitForTimeout(3000);
    
    // Screenshot 2: Login or Home
    console.log('\n📸 Capturing Login/Home Screen...');
    const hasLoginForm = await waitForElement(page, 'input[type="email"]', 1000);
    
    if (hasLoginForm) {
      await takeScreenshot(
        page,
        '02_login',
        'Login screen with email/password fields'
      );
      
      // Fill in test credentials
      await page.type('input[type="email"]', 'test@example.com');
      await page.type('input[type="password"]', 'password123');
      await takeScreenshot(
        page,
        '03_login_filled',
        'Login form with credentials entered'
      );
      
      // Click login
      const loginButton = await page.$('button');
      if (loginButton) {
        await loginButton.click();
        await page.waitForTimeout(2000);
      }
    }
    
    // Screenshot 3-6: Navigation screens
    console.log('\n📸 Capturing Navigation Screens...');
    
    // Home/Flight Sites
    await takeScreenshot(
      page,
      '04_flight_sites',
      'Flight Sites screen with map'
    );
    
    // Try to click Lessons tab
    const navigationButtons = await page.$$('button');
    if (navigationButtons.length > 0) {
      await navigationButtons[Math.min(1, navigationButtons.length - 1)].click();
      await page.waitForTimeout(1000);
      await takeScreenshot(
        page,
        '05_lessons',
        'Lessons screen with training modules'
      );
    }
    
    // Try to click Reading Materials tab
    if (navigationButtons.length > 1) {
      await navigationButtons[Math.min(2, navigationButtons.length - 1)].click();
      await page.waitForTimeout(1000);
      await takeScreenshot(
        page,
        '06_reading',
        'Reading Materials screen'
      );
    }
    
    // Try to click Discussions tab
    if (navigationButtons.length > 2) {
      await navigationButtons[Math.min(3, navigationButtons.length - 1)].click();
      await page.waitForTimeout(1000);
      await takeScreenshot(
        page,
        '07_discussions',
        'Discussions screen with community forum'
      );
    }
    
    console.log('\n✅ Screenshot capture complete!');
    console.log(`📁 Saved to: ${screenshotsDir}`);
    console.log('\n💡 Tip: Keep the Chrome window open to see your app running');
    
    // Keep browser open for viewing
    console.log('🔍 Browser will stay open. Press Ctrl+C to exit.\n');
    await new Promise(() => {});
    
  } catch (error) {
    console.error('❌ Error:', error.message);
    process.exit(1);
  } finally {
    if (browser) {
      await browser.close();
    }
  }
}

// Run if called directly
if (require.main === module) {
  captureScreenshots().catch(console.error);
}

module.exports = { takeScreenshot, findFlutterPort };
