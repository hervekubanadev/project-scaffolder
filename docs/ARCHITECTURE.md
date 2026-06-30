# Architecture

## System Overview

Project Scaffolder is a DevOps automation engine that provisions complete project environments through a deterministic, multi-phase pipeline. It combines Infrastructure-as-Code principles with defensive programming to deliver reproducible, validated project scaffolding.

```
┌────────────────────────────────────────────────────────────────┐
│                     INPUT LAYER                                 │
│  ┌──────────────────┐  ┌────────────────┐  ┌────────────────┐  │
│  │ Project Name     │  │ Warning        │  │ Failure        │  │
│  │ (validated)      │  │ Threshold      │  │ Threshold      │  │
│  └──────────────────┘  └────────────────┘  └────────────────┘  │
└──────────────────────────────┬──────────────────────────────────┘
                               │
┌──────────────────────────────▼──────────────────────────────────┐
│                     PROVISIONING PIPELINE                        │
│                                                                  │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐       │
│  │  PRE-    │  │  DIR     │  │  FILE    │  │  CONFIG  │       │
│  │  FLIGHT  │─►│  CREATE  │─►│  GEN     │─►│  INJECT  │       │
│  │  CHECK   │  │          │  │          │  │  (sed)   │       │
│  └──────────┘  └──────────┘  └──────────┘  └──────────┘       │
│                                                   │            │
│                                           ┌───────▼───────┐   │
│                                           │  VALIDATION   │   │
│                                           │  & INTEGRITY  │   │
│                                           │  CHECK        │   │
│                                           └───────────────┘   │
└────────────────────────────────────────────────────────────────┘
```

## Pipeline Stages

### 1. Input & Validation

The engine collects user input with layered validation:

- **Project name**: Rejects empty strings, normalises to directory-safe format
- **Warning threshold**: Must be integer 0–100, validated with range checking
- **Failure threshold**: Must be integer 0–100, enforced to be less than warning threshold
- **Duplicate detection**: Aborts if target directory already exists (idempotency guard)

### 2. Pre-flight Environment Check

- Verifies Python 3 availability with version detection
- Gracefully warns if missing (non-blocking — allows partial scaffolding)
- Checks filesystem write permissions in target location

### 3. Directory Structure Creation

Creates a standardised project tree:

```
attendance_tracker_{project_name}/
├── Helpers/
├── reports/
└── attendance_checker.py
```

- Permission-denied errors are caught and surfaced with actionable messages
- Uses `mkdir -p` for idempotent creation

### 4. File Generation

Generates project files via heredoc templates:

| File | Purpose | Template Engine |
|------|---------|-----------------|
| `assets.csv` | Student attendance data | Bash heredoc |
| `config.json` | Threshold configuration | Bash heredoc |
| `attendance_checker.py` | Python runtime logic | Bash heredoc (quoted — no variable expansion) |
| `reports.log` | Initial report placeholder | Bash heredoc |

### 5. Configuration Injection

Uses `sed` for cross-platform (macOS + Linux) in-place editing of `config.json`:

- Replaces `"warning"` and `"failure"` values with user-provided thresholds
- Platform detection via `uname` to handle BSD vs GNU sed differences

### 6. Validation & Integrity

Final verification loop checks existence of all generated files:

- Iterates over expected file list
- Reports missing files with exit code 1 on failure
- Summary output with full file paths for user confirmation

## Error Handling & Resilience

| Scenario | Mechanism | Outcome |
|----------|-----------|---------|
| Empty input | `read` in while loop with `-n` check | Reprompts until valid |
| Non-numeric threshold | Regex `^[0-9]+$` | Reprompts with error |
| Range violation | Arithmetic comparison | Reprompts with constraint |
| Failure > Warning | Backward validation | Reprompts until Warning > Failure |
| Directory collision | `-d` check before creation | Aborts with exit code 1 |
| Permission denied | `mkdir` error capture | Aborts with exit code 1 |
| SIGINT (Ctrl+C) | `trap cleanup SIGINT` | Archives partial project to `.tar.gz` |

## Signal Protection Flow

```
SIGINT
  │
  ▼
cleanup()
  │
  ├── Check if BASE_DIR exists
  │     ├── YES: tar + gzip → archive
  │     └── NO:  skip archive
  ├── rm -rf BASE_DIR (clean workspace)
  └── exit 0 (safe termination)
```

## Data Flow

```
Input ──► Validate ──► Check Env ──► Create Dirs ──► Generate Files ──► Inject Config ──► Verify Integrity ──► Complete
  │          │              │              │                │                  │                  │
  └─ stdin   └─ regex      └─ python3     └─ mkdir -p      └─ heredoc         └─ sed             └─ file -f
              + range       + version      + error           templates          + BSD/GNU          loop
              + compare      detection      handling                            dispatch
```

## Security Considerations

- **No arbitrary code execution**: Input is validated before file creation; project name is used only as a directory name
- **No privilege escalation**: Runs at user's permission level; permission denied is caught gracefully
- **Safe signal handling**: SIGINT archives partial work instead of leaving incomplete state
- **Deterministic output**: Same inputs always produce identical project structures
- **No network access**: Operates entirely offline — no dependency downloads
