#!/bin/bash
# Script to run integration tests locally

echo "🧪 Paragliding Training App - Integration Tests"
echo "================================================"
echo ""

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter is not installed or not in PATH"
    exit 1
fi

echo "✅ Flutter found"
flutter --version
echo ""

# Get dependencies
echo "📦 Getting dependencies..."
flutter pub get

echo ""
echo "🏃 Running integration tests..."
echo ""

# Run tests with verbose output
flutter test integration_test/ \
    --no-pub \
    --verbose \
    --web-renderer=html

echo ""
echo "✅ Test run completed!"
echo ""
echo "Screenshots location:"
echo "  Android: build/android/screenshots/"
echo "  iOS: build/ios/screenshots/"
echo "  Web: build/web/screenshots/"
