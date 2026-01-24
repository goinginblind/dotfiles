#!/bin/bash
set -euo pipefail

# === CONFIGURATION ===
REPO_DIR="$HOME/Documents/Obsidian/main"
BRANCH="master"
LOG_FILE="$HOME/sb/scripts/obsidian-auto-commit.log"

cd "$REPO_DIR"

{
echo "[$(date +'%Y-%m-%d %H:%M:%S')] Starting auto-commit job..."

# === 1. Convert all .png and .jpg to .webp ===
find "$REPO_DIR" -type f \( -iname '*.png' -o -iname '*.jpg' \) -print0 |
while IFS= read -r -d '' img; do
    webp="${img%.*}.webp"
    if [ ! -f "$webp" ]; then
        echo "Converting: $img → $webp"
        if cwebp -q 90 "$img" -o "$webp" >/dev/null 2>&1; then
            rm "$img"
        else
            echo "Failed to convert: $img"
        fi
    fi
done

# === 2. Update Markdown links (.png → .webp) ===
find "$REPO_DIR" -type f -name "*.md" -print0 |
while IFS= read -r -d '' md; do
    if grep -q "\.png" "$md"; then
        echo "Updating links in: $md"
        sed -i 's/\.png/\.webp/g' "$md"
    fi
done

# === 3. Commit and push changes ===
git add .

if ! git diff --cached --quiet; then
    git commit -m "Auto commit: $(date +'%Y-%m-%d %H:%M:%S')"
    if ping -q -c 1 -W 2 github.com >/dev/null 2>&1; then
        echo "Internet available — pushing changes..."
        git push origin "$BRANCH"
    else
        echo "No internet — skipping push."
    fi
else
    echo "No changes to commit."
fi

echo "[$(date +'%Y-%m-%d %H:%M:%S')] Job finished successfully."
echo "----------------------------------------"

} >> "$LOG_FILE" 2>&1
