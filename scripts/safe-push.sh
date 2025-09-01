#!/bin/bash

# Safe push script that handles 'latest' tag conflicts automatically

echo "🚀 Safe Push Script"
echo "=================="

# Function to clean up latest tags
cleanup_latest_tags() {
    echo "🔍 Checking for 'latest' tag conflicts..."
    
    # Fetch latest tags
    git fetch --tags --quiet 2>/dev/null || true
    
    # Remove local 'latest' tag if it exists
    if git tag -l | grep -q "^latest$"; then
        echo "🗑️  Removing local 'latest' tag..."
        git tag -d latest
        echo "✅ Local 'latest' tag removed"
    fi
}

# Function to push safely
safe_push() {
    local branch=${1:-$(git branch --show-current)}
    local remote=${2:-origin}
    
    echo "📤 Pushing to $remote/$branch..."
    
    # Push commits (excluding tags)
    if git push "$remote" "$branch"; then
        echo "✅ Successfully pushed commits to $remote/$branch"
        
        # Push tags (excluding 'latest')
        local tags_to_push=$(git tag -l | grep -v "^latest$")
        if [ -n "$tags_to_push" ]; then
            echo "🏷️  Pushing tags (excluding 'latest')..."
            echo "$tags_to_push" | xargs -I {} git push "$remote" {}
        fi
        
        echo "🎉 Push completed successfully!"
    else
        echo "❌ Push failed"
        exit 1
    fi
}

# Main execution
cleanup_latest_tags
safe_push "$@"
