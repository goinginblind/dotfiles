#!/bin/bash
set -euo pipefail

export PATH="/usr/local/bin:/usr/bin:/bin:/home/sb/.local/bin" 

REPO_DIR="$HOME/Documents/Obsidian/main"
BRANCH="master"
LOG_DIR="$HOME/.cache/obsidian-automation"
LOG_FILE="$LOG_DIR/auto-commit.log"

mkdir -p "$LOG_DIR"

cd "$REPO_DIR"

{
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] === STARTING JOB ==="

    if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        echo "ERROR: $REPO_DIR is not a git repository."
        exit 1
    fi

    echo "Checking for images to convert..."
    find . -type f \( -iname '*.png' -o -iname '*.jpg' \) -print0 | while IFS= read -r -d '' img; do
        webp="${img%.*}.webp"
        if [ ! -f "$webp" ]; then
            echo "Converting: $img"
            if cwebp -q 90 "$img" -o "$webp" >/dev/null 2>&1; then
                rm "$img"
            fi
        fi
    done

    echo "Updating markdown links..."
    find . -type f -name "*.md" -print0 | xargs -0 sed -i 's/\.png/\.webp/g' 2>/dev/null || true

    git add .

    if ! git diff --cached --quiet; then
        git commit -m "Auto commit: $(date +'%Y-%m-%d %H:%M:%S')"

        if curl -s --head  --request GET https://github.com --connect-timeout 2 > /dev/null; then
            echo "Pushing to origin..."
            git push origin "$BRANCH"
        else
            echo "Offline: skipped push."
        fi
    else
        echo "No changes detected."
    fi

    echo "[$(date +'%Y-%m-%d %H:%M:%S')] === JOB FINISHED ==="
    echo "----------------------------------------"

} >> "$LOG_FILE" 2>&1
