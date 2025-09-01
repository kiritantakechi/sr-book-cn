# Scripts Directory

This directory contains utility scripts for managing the repository and handling Git operations.

## 📁 Files

### `setup-hooks.sh`
Installs Git hooks to automatically handle `latest` tag conflicts.

**Usage:**
```bash
./scripts/setup-hooks.sh
```

**What it does:**
- Installs a pre-push hook that prevents `latest` tag conflicts
- Automatically removes local `latest` tags before pushing
- Configures Git to use the custom hooks directory

### `safe-push.sh`
A safe alternative to `git push` that handles tag conflicts automatically.

**Usage:**
```bash
./scripts/safe-push.sh [branch] [remote]
```

**Examples:**
```bash
./scripts/safe-push.sh                    # Push current branch to origin
./scripts/safe-push.sh main               # Push main branch to origin
./scripts/safe-push.sh main upstream      # Push main branch to upstream
```

**What it does:**
- Automatically removes conflicting `latest` tags
- Pushes commits safely
- Pushes other tags (excluding `latest`)

### `.githooks/pre-push`
Git hook script that runs before every `git push` to prevent tag conflicts.

**Automatically:**
- Checks for remote `latest` tag conflicts
- Removes local `latest` tags that would conflict
- Prevents accidental pushing of `latest` tags

## 🚀 Quick Start

1. **Install Git hooks (recommended):**
   ```bash
   ./scripts/setup-hooks.sh
   ```

2. **Or use safe push script:**
   ```bash
   ./scripts/safe-push.sh
   ```

## 🔧 Why These Scripts?

The GitHub Actions workflow creates `latest` tags for releases, which can conflict with local Git operations. These scripts automatically handle these conflicts so you can push code without issues.

## 🤝 Team Usage

For team members to use these scripts:
1. Clone the repository
2. Run `./scripts/setup-hooks.sh` once
3. Continue using `git push` normally - conflicts will be handled automatically
