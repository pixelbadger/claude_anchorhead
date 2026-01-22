#!/bin/bash
# Extract human-readable conversation from JSONL session file

INPUT="claude-conversation-session.jsonl"
OUTPUT="CONVERSATION.md"

echo "# Anchorhead Interactive Fiction - Claude Code Session" > "$OUTPUT"
echo "" >> "$OUTPUT"
echo "**Session ID:** ef097e7b-37b2-47ac-ae51-83047557fa43" >> "$OUTPUT"
echo "**Started:** 2026-01-21 23:20:19 UTC" >> "$OUTPUT"
echo "**Total Events:** 394 lines (225 assistant, 112 user, others are system events)" >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "This log captures the complete conversation including Claude's explanations," >> "$OUTPUT"
echo "reasoning, and all tool usage between commands." >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "---" >> "$OUTPUT"
echo "" >> "$OUTPUT"

# Process each line
jq -r '
  if .type == "user" then
    "## 🧑 User\n_" + .timestamp + "_\n\n" + .message.content + "\n"
  elif .type == "assistant" then
    "## 🤖 Assistant\n_" + .timestamp + "_\n\n" + 
    ([.message.content[]? | 
      if .type == "thinking" then 
        "<details><summary>💭 Thinking</summary>\n\n" + .thinking + "\n</details>\n"
      elif .type == "text" then 
        .text + "\n"
      elif .type == "tool_use" then
        "**🔧 Tool: " + .name + "**\n```\n" + (.input | tostring) + "\n```\n"
      else empty
      end
    ] | join("\n")) + "\n"
  else empty
  end
' "$INPUT" >> "$OUTPUT"

echo "Conversation extracted to $OUTPUT ($(wc -l < "$OUTPUT") lines)"
