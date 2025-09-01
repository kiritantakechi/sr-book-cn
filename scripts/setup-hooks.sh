#!/bin/bash

# Setup script to install Git hooks for handling 'latest' tag conflicts

echo "🔧 Setting up Git hooks..."

# Create .git/hooks directory if it doesn't exist
mkdir -p .git/hooks

# Copy pre-push hook
cp scripts/.githooks/pre-push .git/hooks/pre-push

# Make hooks executable
chmod +x .git/hooks/pre-push
chmod +x scripts/.githooks/pre-push

# Configure Git to use our hooks directory (optional, for team sharing)
git config core.hooksPath scripts/.githooks

echo "✅ Git hooks installed successfully!"
echo ""
echo "The pre-push hook will now automatically:"
echo "  - Check for 'latest' tag conflicts before each push"
echo "  - Remove local 'latest' tags that conflict with remote"
echo "  - Prevent accidental pushing of 'latest' tags"
echo ""
echo "To share these hooks with your team, they should run:"
echo "  ./scripts/setup-hooks.sh"
