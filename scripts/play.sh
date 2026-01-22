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
CONVERSATION="$GAME_DIR/CONVERSATION.md"
LAST_LINE_FILE="$GAME_DIR/state/last_conv_line.txt"
SESSION_JSONL="$HOME/.claude/projects/-home-droid-anchorhead"

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

# Get last processed line number (default to 0)
LAST_LINE=0
if [ -f "$LAST_LINE_FILE" ]; then
    LAST_LINE=$(cat "$LAST_LINE_FILE")
fi

# Get last processed date for day boundary detection
LAST_DATE=""
if [ -f "$GAME_DIR/state/last_conv_date.txt" ]; then
    LAST_DATE=$(cat "$GAME_DIR/state/last_conv_date.txt")
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

# Update conversation log from Claude session (optimized version)
# Find the active session file (most recently modified .jsonl)
ACTIVE_SESSION=$(find "$SESSION_JSONL" -maxdepth 1 -name "*.jsonl" -type f -printf '%T@ %p\n' 2>/dev/null | sort -rn | head -1 | cut -d' ' -f2)

if [ -f "$ACTIVE_SESSION" ]; then
    # Get current line count
    CURRENT_LINES=$(wc -l < "$ACTIVE_SESSION")

    # If there are new lines, process them
    if [ "$CURRENT_LINES" -gt "$LAST_LINE" ]; then
        # Get current date for day boundary
        CURRENT_DATE=$(date '+%Y-%m-%d')

        # Add day header if date changed
        if [ "$CURRENT_DATE" != "$LAST_DATE" ]; then
            {
                echo ""
                echo "---"
                echo ""
                echo "# $(date '+%A, %B %d, %Y')"
                echo ""
            } >> "$CONVERSATION"
            echo "$CURRENT_DATE" > "$GAME_DIR/state/last_conv_date.txt"
        fi

        # Extract and format new lines - batch process with jq for speed
        NEW_START=$((LAST_LINE + 1))
        tail -n +$NEW_START "$ACTIVE_SESSION" | jq -r '
            if .type == "user" then
                "## 🧑 User\n_" + (.timestamp | sub("T"; " ") | sub("\\..*"; "")) + "_\n\n" + .message.content + "\n"
            elif .type == "assistant" then
                "## 🤖 Assistant\n_" + (.timestamp | sub("T"; " ") | sub("\\..*"; "")) + "_\n\n" +
                ([.message.content[]? |
                    if .type == "thinking" then
                        "<details><summary>💭 Thinking</summary>\n\n" + .thinking + "\n</details>\n"
                    elif .type == "text" then
                        .text + "\n"
                    elif .type == "tool_use" then
                        "**🔧 Tool: " + .name + "**\n```json\n" + (.input | tojson) + "\n```\n"
                    else empty
                    end
                ] | join("\n")) + "\n"
            else empty
            end
        ' 2>/dev/null >> "$CONVERSATION" || true

        # Update last processed line
        echo "$CURRENT_LINES" > "$LAST_LINE_FILE"
    fi
fi

# Output the result
echo "$OUTPUT"
