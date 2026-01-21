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
├── state/                # Game state and logs
│   ├── anchorhead.sav.qzl    # Current save file
│   └── TRANSCRIPT.md         # Complete gameplay log
└── claude.md             # This guide
```

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

All gameplay is automatically logged to:
- **Transcript**: `state/TRANSCRIPT.md` - Markdown-formatted log with timestamps
- **Save File**: `state/anchorhead.sav.qzl` - Binary game state

The transcript includes:
- Timestamp for each command
- The command you issued
- The game's full response

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

The scripts handle all the save/load/quit sequences automatically so you can focus on playing the game.

## Troubleshooting

If you encounter issues:
- Check that `dfrotz` is installed: `which dfrotz`
- Verify the game file exists: `ls -lh anchor.z8`
- Check save file permissions: `ls -lh state/`
- View the transcript for command history: `cat state/TRANSCRIPT.md`

## Continue Playing

To resume playing, simply use `./scripts/play.sh` with your next command. The game state is preserved and ready to continue from the dark back room of the real estate office.
