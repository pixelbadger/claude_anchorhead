#!/bin/bash
# status.sh - Show current game status (look + inventory)
# Usage: ./status.sh

set -e

# Get script directory and game root
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GAME_DIR="$(dirname "$SCRIPT_DIR")"
GAME="$GAME_DIR/anchor.z8"
SAVE="$GAME_DIR/state/anchorhead.sav.qzl"

# Check if game file exists
if [ ! -f "$GAME" ]; then
    echo "Error: Game file not found at $GAME"
    exit 1
fi

# Check if save file exists
if [ ! -f "$SAVE" ]; then
    echo "No saved game found. Start a new game with ./scripts/new.sh"
    exit 0
fi

# Run look and inventory commands
OUTPUT=$(echo -e "look\ninventory\nquit\ny" | dfrotz -m -p -q -L "$SAVE" "$GAME" 2>&1)

echo "=== Current Status ==="
echo ""
echo "$OUTPUT"
