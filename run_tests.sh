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
echo "📸 Screenshots will be captured during test execution"
echo ""

# Run tests with verbose output on Chrome
flutter test integration_test/app_test.dart \
    --no-pub \
    --verbose \
    --platform=chrome

echo ""
echo "✅ Test run completed!"
echo ""
echo "📸 Screenshots captured - check console output for timing"
echo ""
