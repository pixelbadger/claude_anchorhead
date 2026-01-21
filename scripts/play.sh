#!/bin/bash
# play.sh - Execute one Anchorhead command and return output
# Usage: ./play.sh "go north"

set -e

# Get script directory and game root
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GAME_DIR="$(dirname "$SCRIPT_DIR")"
GAME="$GAME_DIR/anchor.z8"
SAVE="$GAME_DIR/state/anchorhead.sav.qzl"
TRANSCRIPT="$GAME_DIR/state/TRANSCRIPT.md"

CMD="$1"

if [ -z "$CMD" ]; then
    echo "Usage: play.sh <command>"
    echo "Example: play.sh 'go north'"
    exit 1
fi

# Check if game file exists
if [ ! -f "$GAME" ]; then
    echo "Error: Game file not found at $GAME"
    exit 1
fi

# Run the command
if [ -f "$SAVE" ]; then
    # Load from save, execute command, save (with overwrite), quit
    OUTPUT=$(echo -e "$CMD\nsave\n$SAVE\ny\nquit\ny" | dfrotz -m -p -q -L "$SAVE" "$GAME" 2>&1)
else
    # New game, execute command, save, quit
    OUTPUT=$(echo -e "$CMD\nsave\n$SAVE\nquit\ny" | dfrotz -m -p -q "$GAME" 2>&1)
fi

# Log to transcript
{
    echo ""
    echo "## $(date '+%Y-%m-%d %H:%M:%S')"
    echo ""
    echo "> $CMD"
    echo ""
    echo '```'
    echo "$OUTPUT"
    echo '```'
} >> "$TRANSCRIPT"

# Output the result
echo "$OUTPUT"
