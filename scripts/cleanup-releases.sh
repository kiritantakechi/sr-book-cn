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

# Delete ALL releases with "Latest" in the title (we'll recreate the proper one later)
echo "  Removing ALL 'Latest' releases..."
gh release list --limit 50 | while read line; do
    tag=$(echo "$line" | awk '{print $3}')
    title=$(echo "$line" | cut -d$'\t' -f1)
    if [[ "$title" == *"Latest"* ]] && [ "$tag" != "Draft" ] && [ "$tag" != "" ]; then
        echo "    Deleting latest release: $tag ($title)"
        gh release delete "$tag" --yes 2>/dev/null || true
    fi
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
echo "📦 Creating a new 'Latest' release from the most recent build..."

# Find the most recent build release
MOST_RECENT_BUILD=$(gh release list --limit 10 | grep "Build " | head -1 | awk '{print $3}')

if [ -n "$MOST_RECENT_BUILD" ] && [ "$MOST_RECENT_BUILD" != "Draft" ]; then
    echo "  Found most recent build: $MOST_RECENT_BUILD"

    # Get the build info
    BUILD_INFO=$(gh release view "$MOST_RECENT_BUILD" --json body,createdAt,tagName)
    BUILD_DATE=$(echo "$BUILD_INFO" | jq -r '.createdAt' | cut -d'T' -f1)
    COMMIT_HASH=$(echo "$MOST_RECENT_BUILD" | sed 's/build-//')

    # Download the PDF from the most recent build
    echo "  Downloading PDF from $MOST_RECENT_BUILD..."
    gh release download "$MOST_RECENT_BUILD" --pattern "book.pdf" --clobber

    # Create new latest release with timestamp
    LATEST_TAG="latest-$(date +%Y%m%d-%H%M%S)"
    echo "  Creating new latest release: $LATEST_TAG"

    gh release create "$LATEST_TAG" book.pdf \
      --title "Symphonic Rain Chinese Translation - Latest ($BUILD_DATE)" \
      --notes "🎯 **This is the LATEST version** - Always download this one for the most recent translation.

**Latest Build**: $MOST_RECENT_BUILD
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
    echo "⚠️ No build releases found to create latest from"
fi

echo ""
echo "📋 Final release list:"
gh release list --limit 10

echo ""
echo "✅ Cleanup completed!"
echo ""
echo "Now you should have only one 'latest' release."
echo "Future builds will automatically maintain this state."
