#!/bin/bash
# new.sh - Start a fresh game (archives current save)
# Usage: ./new.sh

set -e

# Get script directory and game root
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GAME_DIR="$(dirname "$SCRIPT_DIR")"
GAME="$GAME_DIR/anchor.z8"
SAVE="$GAME_DIR/state/anchorhead.sav.qzl"
TRANSCRIPT="$GAME_DIR/state/TRANSCRIPT.md"

# Check if game file exists
if [ ! -f "$GAME" ]; then
    echo "Error: Game file not found at $GAME"
    exit 1
fi

# Archive existing save if present
if [ -f "$SAVE" ]; then
    ARCHIVE="$GAME_DIR/state/anchorhead.sav.$(date '+%Y%m%d-%H%M%S').qzl"
    mv "$SAVE" "$ARCHIVE"
    echo "Archived previous save to: $ARCHIVE"
fi

# Reset conversation tracking (new game = fresh start)
CONVERSATION="$GAME_DIR/CONVERSATION.md"

# Archive old conversation if it exists
if [ -f "$CONVERSATION" ]; then
    CONV_ARCHIVE="$GAME_DIR/CONVERSATION.$(date '+%Y%m%d-%H%M%S').md"
    mv "$CONVERSATION" "$CONV_ARCHIVE"
    echo "Archived previous conversation to: $CONV_ARCHIVE"
fi

# Create fresh CONVERSATION.md
{
    echo "# 🎮 Anchorhead - Conversation Log"
    echo ""
} > "$CONVERSATION"

# Reset tracking files
echo "0" > "$GAME_DIR/state/last_conv_line.txt"
date '+%Y-%m-%d' > "$GAME_DIR/state/last_conv_date.txt"

# Start new game, press enter to begin, save
OUTPUT=$(echo -e "\nlook\nsave\n$SAVE\nquit\ny" | dfrotz -m -p -q "$GAME" 2>&1)

# Log to transcript
{
    echo ""
    echo "---"
    echo ""
    echo "# New Game Started - $(date '+%Y-%m-%d %H:%M:%S')"
    echo ""
    echo '```'
    echo "$OUTPUT"
    echo '```'
} >> "$TRANSCRIPT"

# Filter out save/quit prompts from game output
CLEAN_OUTPUT=$(echo "$OUTPUT" | sed -e '/^>Please enter a filename/d' \
    -e '/^Overwrite existing file?/d' \
    -e '/^Ok\.$/d' \
    -e '/^>$/d' \
    -e '/^Are you sure you want to quit?/d')

# Log to conversation
{
    echo "### 🎮 New Game Started"
    echo ""
    echo '```'
    echo "$CLEAN_OUTPUT"
    echo '```'
    echo ""
} >> "$CONVERSATION"

echo "=== New Game Started ==="
echo ""
echo "$OUTPUT"
