# Scripts Directory

This directory contains utility scripts for managing the repository and handling Git operations.

## 📁 Files

### `cleanup-releases-pro.sh`
Professional tool to clean up duplicate releases and maintain a clean release history.

**Usage:**
```bash
./scripts/cleanup-releases-pro.sh
```

**What it does:**
- Deletes all duplicate "Latest" releases
- Keeps 5 most recent build releases
- Creates a new clean "Latest" release from the most recent build
- Uses JSON parsing for reliable operation

### `setup-hooks.sh` *(Optional)*
Installs Git hooks to automatically handle `latest` tag conflicts.

**Usage:**
```bash
./scripts/setup-hooks.sh
```

### `safe-push.sh` *(Optional)*
A safe alternative to `git push` that handles tag conflicts automatically.

**Usage:**
```bash
./scripts/safe-push.sh [branch] [remote]
```

## 🚀 Quick Start

**For one-time cleanup of existing duplicate releases:**
```bash
./scripts/cleanup-releases-pro.sh
```

**For ongoing development (optional):**
```bash
./scripts/setup-hooks.sh    # Install Git hooks
# OR
./scripts/safe-push.sh      # Use safe push instead of git push
```

## 🔧 Why These Scripts?

The GitHub Actions workflow automatically manages releases, but sometimes duplicate "Latest" releases can accumulate. The cleanup script fixes this issue and maintains a clean release history.

## 🤝 Team Usage

The main cleanup script requires:
- GitHub CLI (`gh`) - Install from https://cli.github.com/
- `jq` for JSON parsing - Install with `brew install jq` (macOS) or `sudo apt install jq` (Ubuntu)
