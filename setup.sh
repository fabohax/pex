#!/bin/bash

# PEX Development Setup Script
# Initializes the Clarity development environment

set -e

echo "🔧 Setting up PEX Development Environment..."

# Check if Clarinet is installed
if ! command -v clarinet &> /dev/null; then
    echo "❌ Clarinet not found. Please install Clarinet first:"
    echo "   brew install clarinet  (macOS)"
    echo "   Or visit: https://github.com/hirosystems/clarinet"
    exit 1
fi

echo "✅ Clarinet found"

# Check Node.js
if ! command -v node &> /dev/null; then
    echo "⚠️  Node.js not found. Some helper scripts may not work."
else
    echo "✅ Node.js found: $(node --version)"
fi

# Setup .env.local if it doesn't exist
if [ ! -f .env.local ]; then
    echo "📋 Creating .env.local from template..."
    cp .env.example .env.local
    echo "⚠️  Please update .env.local with your configuration"
else
    echo "✅ .env.local already exists"
fi

# Validate contracts
echo "🔍 Validating contracts..."
clarinet check

# Run tests
echo "🧪 Running tests..."
clarinet test

echo ""
echo "✨ Setup complete!"
echo ""
echo "Next steps:"
echo "  1. Edit .env.local with your wallet details"
echo "  2. Run 'clarinet console' to interact with contracts"
echo "  3. Run 'clarinet integrate' for local blockchain"
echo "  4. Review docs/ for detailed documentation"
echo ""
