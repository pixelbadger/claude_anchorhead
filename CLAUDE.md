# Anchorhead Interactive Fiction - Claude Code Guide

## Overview

This repository contains **Anchorhead** by Michael S. Gentry, a classic interactive fiction game in Z-machine format, along with helper scripts for playing the game with persistent state management.

## Game File

- `anchor.z8` - Anchorhead game file (Release 5 / Serial number 990206)

## Directory Structure

```
/home/droid/anchorhead/
├── anchor.z8              # Game file
├── scripts/               # Helper scripts
│   ├── play.sh           # Execute a single command
│   ├── status.sh         # Check current location and inventory
│   └── new.sh            # Start a fresh game
├── state/                # Game state (gitignored - local only)
│   ├── anchorhead.sav.qzl    # Current save file
│   ├── TRANSCRIPT.md         # Game-only reference log
│   └── *.txt                 # Session tracking files
├── CONVERSATION.md       # Primary log (committed to git)
├── CONVERSATION.*.md     # Archived logs (committed to git)
└── CLAUDE.md             # This guide
```

## Git Repository

### What's Tracked
- ✅ **Game file** (`anchor.z8`) - The Anchorhead game itself
- ✅ **Scripts** (`scripts/*.sh`) - Helper scripts for playing
- ✅ **Documentation** (`CLAUDE.md`, `README.md`) - Project documentation
- ✅ **Conversation logs** (`CONVERSATION*.md`) - Complete gameplay narratives with Claude's thinking

### What's Ignored
- ❌ **State folder** (`state/`) - Gitignored via `.gitignore`
  - Save files (`.qzl`) - Change every command
  - Transcript logs - Duplicates content in CONVERSATION.md
  - Session tracking files - Local session state only

**Why?** State files change with every single command and would create massive commit noise. The important narrative (your requests + Claude's thinking + game responses) is preserved in `CONVERSATION.md` which IS committed to git.

## How It Works

The scripts use **dfrotz** (dumb frotz) with a save/load cycle:
1. Load the previous save state (if it exists)
2. Execute your command
3. Save the new state
4. Quit the interpreter

This allows persistent gameplay across multiple command executions while maintaining a complete transcript of all actions.

## Usage

### Check Current Status

```bash
./scripts/status.sh
```

Shows your current location and inventory without advancing the game state.

### Execute a Command

```bash
./scripts/play.sh "your command here"
```

Examples:
- `./scripts/play.sh "look"`
- `./scripts/play.sh "go north"`
- `./scripts/play.sh "take lamp"`
- `./scripts/play.sh "examine door"`
- `./scripts/play.sh "inventory"`

### Start a New Game

```bash
./scripts/new.sh
```

Archives the current save (if it exists) and starts fresh. The old save is preserved with a timestamp.

## Game Logs

All gameplay is automatically logged to multiple files:

### Unified Conversation Log ⭐ PRIMARY LOG
- **File**: `CONVERSATION.md`
- **Format**: Markdown with collapsible thinking blocks
- **Contents**: Complete unified log including:
  - 🧑 **User messages** - Your requests and instructions
  - 💭 **Claude's thinking** - Decision-making process (in collapsible `<details>` blocks)
  - 💬 **Claude's responses** - Explanations and commentary
  - 🎮 **Game commands** - The actual commands sent to the game
  - 📖 **Game output** - Complete responses from Anchorhead (in code blocks)
  - ⏱️ **Timestamps** - For all messages and actions
- **Updates**: Automatically appended after each `play.sh` command
- **Day boundaries**: New date headers added when the day changes
- **Purpose**: Single source of truth showing both Claude's thinking AND game responses

### Game Transcript (Reference)
- **File**: `state/TRANSCRIPT.md` (gitignored - local only)
- **Format**: Markdown with timestamps
- **Contents**: Game-only view (commands and responses, no Claude commentary)
- **Purpose**: Clean reference log for reviewing pure gameplay
- **Note**: Not committed to git; CONVERSATION.md contains all game output plus context

### Session Tracking
- **File**: `state/last_conv_line.txt` - Tracks which conversation lines have been processed
- **File**: `state/last_conv_date.txt` - Tracks current date for day boundaries
- **Source**: `~/.claude/projects/-home-droid-anchorhead/*.jsonl` - Raw session data

**CONVERSATION.md is the primary log** - it shows the complete story of both Claude's reasoning and the game's responses in chronological order.

## Playing the Game

Anchorhead is a Lovecraftian horror mystery. Common commands include:

- **Movement**: `north`, `south`, `east`, `west`, `up`, `down`, `in`, `out`
- **Shortcuts**: `n`, `s`, `e`, `w`, `u`, `d`
- **Actions**: `look`, `examine [thing]`, `take [item]`, `drop [item]`
- **Inventory**: `inventory` or `i`
- **Interaction**: `open [door]`, `close [door]`, `push [object]`, `pull [object]`
- **Communication**: `talk to [person]`, `ask [person] about [topic]`

Type `help` in-game for more information.

## Current Game State

**Location**: Inside the Real Estate Office (back room with filing cabinets)

**Inventory**: wedding ring, trenchcoat, clothes, umbrella (closed)

**Progress**: Successfully entered the locked real estate office through a transom window accessed via garbage can in the alley.

## Tips for Playing

1. Use `./scripts/status.sh` frequently to remind yourself where you are
2. Examine everything - this is a mystery game with many clues
3. The transcript log preserves your entire playthrough
4. Save files are automatically managed - you can always continue from where you left off
5. If you want to restart, use `./scripts/new.sh` (your old save will be archived)

## Technical Details

**dfrotz flags used:**
- `-m` - Suppress MORE prompts for continuous output
- `-p` - Plain ASCII output (no formatting codes)
- `-q` - Quiet mode (no startup banners)
- `-L` - Load save file directly

**Conversation logging mechanism:**
- After each game command, `play.sh` performs two logging operations:
  1. **Claude session sync**: Checks for new entries in the Claude session JSONL
     - Only processes lines since the last update (delta processing)
     - Uses single-pass jq for efficient batch processing (not line-by-line loops)
     - Extracts user messages, thinking blocks, and tool calls
     - Tracks position with `state/last_conv_line.txt`
  2. **Game output append**: Directly appends the game's response
     - Captures complete output in formatted code blocks
     - Ensures game responses appear immediately after commands
- Both operations write to `CONVERSATION.md` for unified logging
- Result: Complete chronological log of thinking → command → game response

The scripts handle all the save/load/quit sequences and conversation syncing automatically so you can focus on playing the game.

## Troubleshooting

If you encounter issues:
- Check that `dfrotz` is installed: `which dfrotz`
- Verify the game file exists: `ls -lh anchor.z8`
- Check save file permissions: `ls -lh state/`
- View the transcript for command history: `cat state/TRANSCRIPT.md`

## Continue Playing

To resume playing, simply use `./scripts/play.sh` with your next command. The game state is preserved and ready to continue from the dark back room of the real estate office.
