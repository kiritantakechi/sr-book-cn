#!/bin/bash

# One-time cleanup script to fix multiple "latest" releases
# This script should be run once to clean up the current mess

echo "🧹 Cleaning up multiple 'latest' releases..."
echo "============================================="

# Check if gh CLI is available
if ! command -v gh &> /dev/null; then
    echo "❌ GitHub CLI (gh) is not installed or not in PATH"
    echo "Please install it from: https://cli.github.com/"
    exit 1
fi

# Check if user is authenticated
if ! gh auth status &> /dev/null; then
    echo "❌ Not authenticated with GitHub CLI"
    echo "Please run: gh auth login"
    exit 1
fi

echo "📋 Current releases:"
gh release list --limit 20

echo ""
echo "🏷️ Removing 'latest' flag from all releases..."

# Remove latest flag from all releases
gh release list --limit 50 | while read line; do
    tag=$(echo "$line" | awk '{print $3}')
    if [ "$tag" != "Draft" ] && [ "$tag" != "" ]; then
        echo "  Updating release: $tag"
        gh release edit "$tag" --latest=false 2>/dev/null || true
    fi
done

echo ""
echo "🗑️ Cleaning up duplicate and old releases..."

# Delete all releases with "Latest" in the title except the most recent one
echo "  Removing duplicate 'Latest' releases..."
gh release list --limit 50 | grep -i "latest" | tail -n +2 | while read line; do
    tag=$(echo "$line" | awk '{print $3}')
    echo "    Deleting duplicate latest release: $tag"
    gh release delete "$tag" --yes 2>/dev/null || true
done

# Delete old timestamped releases, keep only 3 most recent
echo "  Removing old timestamped releases (keeping 3 most recent)..."
gh release list --limit 50 | grep "latest-" | tail -n +4 | while read line; do
    tag=$(echo "$line" | awk '{print $3}')
    echo "    Deleting old timestamped release: $tag"
    gh release delete "$tag" --yes 2>/dev/null || true
done

# Delete old build releases, keep only 5 most recent
echo "  Removing old build releases (keeping 5 most recent)..."
gh release list --limit 50 | grep "build-" | tail -n +6 | while read line; do
    tag=$(echo "$line" | awk '{print $3}')
    echo "    Deleting old build release: $tag"
    gh release delete "$tag" --yes 2>/dev/null || true
done

echo ""
echo "📦 Setting the most recent release as 'latest'..."

# Find the most recent release (any type) and mark it as latest
MOST_RECENT=$(gh release list --limit 1 | head -1 | awk '{print $3}')

if [ -n "$MOST_RECENT" ] && [ "$MOST_RECENT" != "Draft" ]; then
    echo "  Setting $MOST_RECENT as latest"
    gh release edit "$MOST_RECENT" --latest=true
    echo "✅ $MOST_RECENT is now marked as the latest release"
else
    echo "⚠️ No releases found to mark as latest"
fi

echo ""
echo "📋 Final release list:"
gh release list --limit 10

echo ""
echo "✅ Cleanup completed!"
echo ""
echo "Now you should have only one 'latest' release."
echo "Future builds will automatically maintain this state."
