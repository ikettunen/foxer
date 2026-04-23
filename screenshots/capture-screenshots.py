#!/usr/bin/env python3
"""
Simple screenshot utility for Foxer Paragliding app
Takes screenshots of the running Chrome window

Prerequisites:
  pip install pillow pyautogui

Usage:
  python screenshots/capture-screenshots.py
"""

import subprocess
import time
import os
from pathlib import Path
from datetime import datetime

try:
    from PIL import ImageGrab
except ImportError:
    print("❌ pillow not installed. Install with: pip install pillow pyautogui")
    exit(1)

SCREENSHOTS_DIR = Path(__file__).parent
TIMESTAMP = datetime.now().strftime("%Y%m%d_%H%M%S")

def find_chrome_window():
    """Find Chrome window with Flutter app"""
    try:
        # Use tasklist to find Chrome
        result = subprocess.run(['tasklist'], capture_output=True, text=True)
        if 'chrome.exe' in result.stdout:
            return True
    except:
        pass
    return False

def capture_screen(name, description=""):
    """Capture and save the current screen"""
    filename = f"{name}_{TIMESTAMP}.png"
    filepath = SCREENSHOTS_DIR / filename
    
    # Take screenshot
    screenshot = ImageGrab.grab()
    screenshot.save(filepath)
    
    print(f"✅ {filename}")
    if description:
        print(f"   {description}")
    return filepath

def main():
    print("🎬 Foxer Paragliding - Screenshot Capture\n")
    
    # Check if Chrome is running
    if not find_chrome_window():
        print("⚠️  Chrome doesn't appear to be running.")
        print("   Start the app with: flutter run -d chrome")
        return
    
    print("📸 Capturing screenshots...\n")
    
    try:
        # Splash screen (first capture)
        capture_screen("01_splash", "Splash screen with Foxer branding")
        time.sleep(3)  # Let app load
        
        # Login or Home screen
        capture_screen("02_login_or_home", "Login or Home screen after splash")
        time.sleep(1)
        
        print(f"\n✅ Screenshots saved to: {SCREENSHOTS_DIR}/\n")
        
        # Instructions for next steps
        print("📋 Next steps:")
        print("  1. Check the Chrome window that's still running")
        print("  2. Interact with the app (tap buttons, navigate screens)")
        print("  3. Take additional screenshots manually with Windows+Shift+S")
        print("  4. Or run this script again for another capture\n")
        print("💡 Tip: Leave Chrome window in foreground for best results")
        
    except Exception as e:
        print(f"❌ Error: {e}")
        print("   Make sure Chrome window is visible and not minimized")
        return

if __name__ == "__main__":
    main()
