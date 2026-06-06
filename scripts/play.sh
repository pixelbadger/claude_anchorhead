#!/bin/bash
# play.sh - Execute one Anchorhead command and return output
# Usage: ./play.sh "go north" ["optional inner monologue"]

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GAME_DIR="$(dirname "$SCRIPT_DIR")"
GAME="$GAME_DIR/anchor.z8"
SAVE="$GAME_DIR/state/anchorhead.sav.qzl"
TRANSCRIPT="$GAME_DIR/state/TRANSCRIPT.md"
CONVERSATION="$GAME_DIR/CONVERSATION.md"

CMD="$1"
MONOLOGUE="$2"

if [ -z "$CMD" ]; then
    echo "Usage: play.sh <command> [inner monologue]"
    exit 1
fi

if [ ! -f "$GAME" ]; then
    echo "Error: Game file not found at $GAME"
    exit 1
fi

# Run the command
if [ -f "$SAVE" ]; then
    OUTPUT=$(echo -e "$CMD\nsave\n$SAVE\ny\nquit\ny" | dfrotz -m -p -q -L "$SAVE" "$GAME" 2>&1)
else
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

# Filter out save/quit prompts from game output
CLEAN_OUTPUT=$(echo "$OUTPUT" | sed -e '/^>Please enter a filename/d' \
    -e '/^Overwrite existing file?/d' \
    -e '/^Ok\.$/d' \
    -e '/^>$/d' \
    -e '/^Are you sure you want to quit?/d')

# Append to conversation log: optional inner monologue, then command + game output
{
    if [ -n "$MONOLOGUE" ]; then
        echo ""
        echo "---"
        echo ""
        echo "*${MONOLOGUE}*"
        echo ""
    fi
    echo "### \`> $CMD\`"
    echo ""
    echo '```'
    echo "$CLEAN_OUTPUT"
    echo '```'
    echo ""
} >> "$CONVERSATION"

echo "$OUTPUT"
