#!/bin/bash

# Professional cleanup script using GitHub CLI with proper JSON parsing
# This script uses more reliable methods to handle GitHub releases

echo "🧹 Professional Release Cleanup Tool"
echo "===================================="

# Check if gh CLI is available
if ! command -v gh &> /dev/null; then
    echo "❌ GitHub CLI (gh) is not installed or not in PATH"
    echo "Please install it from: https://cli.github.com/"
    exit 1
fi

# Check if jq is available
if ! command -v jq &> /dev/null; then
    echo "❌ jq is not installed or not in PATH"
    echo "Please install jq for JSON parsing"
    echo "macOS: brew install jq"
    echo "Ubuntu: sudo apt install jq"
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
echo "🗑️ Step 1: Deleting ALL releases with 'Latest' in the title..."

# Get all releases with "Latest" in title and delete them
LATEST_RELEASES=$(gh release list --limit 50 --json tagName,name | jq -r '.[] | select(.name | contains("Latest")) | .tagName')

if [ -n "$LATEST_RELEASES" ]; then
    echo "$LATEST_RELEASES" | while read -r tag; do
        if [ -n "$tag" ]; then
            echo "  🗑️ Deleting Latest release: $tag"
            gh release delete "$tag" --yes --cleanup-tag 2>/dev/null || true
        fi
    done
    echo "✅ All Latest releases deleted"
else
    echo "ℹ️ No Latest releases found"
fi

echo ""
echo "🧹 Step 2: Cleaning up old build releases (keeping 5 most recent)..."

# Get all build releases, sort by date, and delete old ones
BUILD_RELEASES=$(gh release list --limit 50 --json tagName,name,createdAt | jq -r '.[] | select(.name | startswith("Build ")) | [.createdAt, .tagName] | @tsv' | sort -r | tail -n +6)

if [ -n "$BUILD_RELEASES" ]; then
    echo "$BUILD_RELEASES" | while read -r line; do
        tag=$(echo "$line" | cut -f2)
        if [ -n "$tag" ]; then
            echo "  🗑️ Deleting old build release: $tag"
            gh release delete "$tag" --yes --cleanup-tag 2>/dev/null || true
        fi
    done
    echo "✅ Old build releases cleaned up"
else
    echo "ℹ️ No old build releases to clean up"
fi

echo ""
echo "📦 Step 3: Creating new Latest release from most recent build..."

# Find the most recent build release
MOST_RECENT=$(gh release list --limit 10 --json tagName,name,createdAt | jq -r '.[] | select(.name | startswith("Build ")) | [.createdAt, .tagName, .name] | @tsv' | sort -r | head -1)

if [ -n "$MOST_RECENT" ]; then
    BUILD_TAG=$(echo "$MOST_RECENT" | cut -f2)
    BUILD_NAME=$(echo "$MOST_RECENT" | cut -f3)
    BUILD_DATE=$(echo "$MOST_RECENT" | cut -f1 | cut -d'T' -f1)
    COMMIT_HASH=$(echo "$BUILD_TAG" | sed 's/build-//')
    
    echo "  📥 Found most recent build: $BUILD_TAG"
    echo "  📥 Downloading PDF from $BUILD_TAG..."
    
    # Download the PDF from the most recent build
    if gh release download "$BUILD_TAG" --pattern "book.pdf" --clobber; then
        # Create new latest release with timestamp
        LATEST_TAG="latest-$(date +%Y%m%d-%H%M%S)"
        echo "  📦 Creating new latest release: $LATEST_TAG"
        
        gh release create "$LATEST_TAG" book.pdf \
          --title "Symphonic Rain Chinese Translation - Latest ($BUILD_DATE)" \
          --notes "🎯 **This is the LATEST version** - Always download this one for the most recent translation.

**Source Build**: $BUILD_NAME
**Commit Hash**: $COMMIT_HASH
**Build Date**: $BUILD_DATE

📥 Download \`book.pdf\` to get the latest version of the Chinese translation.

---
*This release is automatically updated with each new commit.*" \
          --latest
          
        # Clean up downloaded file
        rm -f book.pdf
        
        echo "✅ New latest release created: $LATEST_TAG"
    else
        echo "❌ Failed to download PDF from $BUILD_TAG"
    fi
else
    echo "⚠️ No build releases found to create latest from"
fi

echo ""
echo "📋 Final release list:"
gh release list --limit 10

echo ""
echo "🎉 Professional cleanup completed!"
echo ""
echo "Summary:"
echo "- Deleted all duplicate 'Latest' releases"
echo "- Cleaned up old build releases (kept 5 most recent)"
echo "- Created one clean 'Latest' release from most recent build"
