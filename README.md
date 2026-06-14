
# Attendance Tracker – Project Bootstrapper
### Automated Environment Setup via Shell Scripting | Infrastructure as Code (IaC)

---

## Overview

This project eliminates manual project setup by using a single shell script to bootstrap a complete attendance tracking environment. Every folder, file, and configuration is generated automatically, validated, and ready to run — in seconds.

This demonstrates a core principle of professional software engineering: **Infrastructure as Code (IaC)** — where environment setup is reproducible, reliable, and free from human error.

---

## Project Structure Generated

```
attendance_tracker_{input}/
├── attendance_checker.py       # Main Python logic engine
├── Helpers/
│   ├── assets.csv              # Student attendance data
│   └── config.json             # Threshold configuration
└── reports/
    └── reports.log             # Auto-generated attendance report
```

---

## How to Run

**1. Give the script execution permission:**
```bash
chmod +x setup_project.sh
```

**2. Run the bootstrapper:**
```bash
./setup_project.sh
```

**3. Follow the interactive prompts:**
- Enter a project suffix (e.g. `COHORT_A`)
- Set a warning threshold (0–100, default 75%)
- Set a failure threshold (0–100, default 50%)

**4. After setup completes, enter the project and run:**
```bash
cd attendance_tracker_{input}
python3 attendance_checker.py
```

---

## Triggering the Archive / Safe Exit Feature

The script implements a **SIGINT signal trap** (Ctrl+C). To trigger it:

1. Start the script normally: `./setup_project.sh`
2. Enter a project name and proceed through setup
3. At **any point during execution**, press `Ctrl+C`

**What happens:**
```
⚠ INTERRUPT DETECTED (CTRL + C)
⏳ Starting safe shutdown procedure...
✔ Project directory detected
⏳ Creating backup archive...
✔ Backup successful: attendance_tracker_{input}_archive.tar.gz
⏳ Cleaning workspace...
✔ Temporary files removed
SAFE EXIT COMPLETED
```

The incomplete project folder is **deleted** and a `.tar.gz` archive of its current state is saved in the parent directory. This keeps the workspace clean while preserving whatever was generated before the interrupt.

---

## Feature Breakdown

### 1. Directory Automation
The script builds the exact required folder structure using `mkdir`. Before creation, it:
- Rejects **empty project names** and re-prompts
- Checks if the directory **already exists** and exits with an error to prevent overwriting existing work
- Creates all subdirectories (`Helpers/`, `reports/`) and generates all required files in sequence

### 2. Configuration & `sed` Editing
The user is prompted to set two attendance thresholds via the `read` command. The script then uses `sed` to perform **in-place substitution** on `config.json`:

```bash
sed -i "s/\"warning\": [0-9]*/\"warning\": $WARNING/" config.json
sed -i "s/\"failure\": [0-9]*/\"failure\": $FAILURE/" config.json
```

This regex pattern matches the existing numeric value next to each key and replaces it with the user's input — without needing to rewrite the entire file.

**Input validation applied:**
- Rejects non-numeric values (`dafa`, `abc`)
- Rejects values outside the 0–100 range (`787`, `45566`)
- Loops until a valid value is entered for each field

### 3. Process Management — Signal Trap
The trap is registered at the top of the script using:

```bash
trap handle_interrupt SIGINT
```

The `handle_interrupt` function is called whenever `Ctrl+C` is pressed. It:
1. Detects whether the project directory was already created
2. Bundles it into a `.tar.gz` archive using `tar -czf`
3. Deletes the incomplete directory using `rm -rf`
4. Exits cleanly with status code `1`

This was tested by interrupting at different stages — before directory creation, during file generation, and during configuration — confirming the trap handles all cases correctly.

### 4. Environment Validation
Before any files are created, the script runs:

```bash
python3 --version
```

If Python 3 is not found, the script prints an error and exits immediately — preventing setup from continuing in a broken environment.

A final **file integrity check** also confirms all required files exist before declaring success.

### 5. Python Attendance Engine
Once the environment is set up, `attendance_checker.py`:
- Reads student records from `assets.csv`
- Calculates each student's attendance percentage: `(attended / total_sessions) * 100`
- Flags students based on config thresholds:
  - Below `failure` threshold → `URGENT` alert
  - Below `warning` threshold → `WARNING` alert
- Writes timestamped results to `reports/reports.log`
- Archives previous log files automatically on each new run

---

## Edge Cases Handled

| Scenario | Behavior |
|---|---|
| Empty project name entered | Rejected, re-prompted |
| Project directory already exists | Script exits with error |
| Non-numeric threshold entered | Rejected, re-prompted |
| Threshold outside 0–100 | Rejected, re-prompted |
| Ctrl+C before directory created | Exits cleanly, nothing to archive |
| Ctrl+C after directory created | Archives state, deletes directory |
| Python3 not installed | Script exits with warning before setup |

---

## What This Project Demonstrates

- **Shell scripting** for full project lifecycle automation
- **Signal handling** (`trap`, `SIGINT`) for safe process management
- **Stream editing** (`sed`) for dynamic file configuration
- **Input validation** to prevent bad data from entering the system
- **Bash + Python integration** in a single automated workflow
- **IaC principles** — one script, identical output every time

---

## Repository

**Repo name format:** `deploy_agent_Kubanaherve`

---

