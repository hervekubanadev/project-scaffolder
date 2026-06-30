<div align="center">
  <h1>Project Scaffolder</h1>
  <p><strong>Infrastructure-as-Code project bootstrapping agent</strong></p>
  <p>
    <img src="https://img.shields.io/badge/Bash-4EAA25" alt="Bash">
    <img src="https://img.shields.io/badge/Python-3-3776AB" alt="Python 3">
    <img src="https://img.shields.io/badge/IaC-00B4AB" alt="IaC">
    <img src="https://img.shields.io/badge/DevOps-FF6B6B" alt="DevOps">
  </p>
</div>

---

## Overview

Project Scaffolder is a DevOps provisioning tool that automates the creation of complete project environments. It combines Infrastructure-as-Code principles with shell automation to scaffold, configure, and validate new projects — eliminating manual setup and ensuring reproducible environments.

Think of it as **`create-react-app` for backend projects** — a deterministic, repeatable scaffolding agent.

---

## How It Works

```
┌──────────────┐     ┌──────────────┐     ┌──────────────┐
│   Input      │ ──► │  Provision   │ ──► │   Validate   │
│  Project     │     │  Directories │     │  File Check  │
│  Thresholds  │     │  Files       │     │  Integrity   │
│              │     │  Config      │     │              │
└──────────────┘     └──────────────┘     └──────────────┘
                            │
                      ┌─────▼─────┐
                      │  Output    │
                      │  Ready-to- │
                      │  Run       │
                      │  Project   │
                      └───────────┘
```

### Tech Stack

| Layer | Technology |
|-------|-----------|
| **Orchestration** | Bash 5+ shell scripting |
| **Runtime Logic** | Python 3 |
| **Data Formats** | CSV, JSON, plain-text |
| **File Editing** | sed (stream editor) |
| **Archiving** | tar + gzip |
| **Platform** | macOS, Linux |

---

## Features

### 🚀 Automated Project Scaffolding
- Creates complete project directory structure in seconds
- Generates configuration files with user-defined parameters
- Produces ready-to-run Python application code

### 🛡️ Enterprise-Grade Error Handling
- Input validation (empty names, non-numeric thresholds, range checking)
- Duplicate directory collision detection
- Permission-denied error recovery
- Python 3 pre-flight environment check
- Final file integrity verification

### 🔄 Smart Configuration
- Dynamic threshold injection using `sed` (cross-platform: macOS + Linux)
- JSON-based configuration for runtime parameters
- Warning/failure level validation (warning < failure enforced)

### ⚡ Signal Protection
- SIGINT (Ctrl+C) trap that archives the incomplete project
- Graceful cleanup of partial artifacts
- Timestamped `.tar.gz` archive on interruption

### 📊 Built-in Attendance Checker
- CSV-based student attendance tracking
- Configurable warning and failure thresholds
- Dry-run mode for testing
- Timestamped reports with auto-archiving

---

## Quick Start

```bash
# Clone the repository
git clone https://github.com/hervekubanadev/project-scaffolder.git
cd project-scaffolder

# Run the scaffolder
bash setup_project.sh

# Follow the prompts:
# 1. Enter project name
# 2. Set warning threshold (default: 75)
# 3. Set failure threshold (default: 50)
```

### Example

```bash
$ bash setup_project.sh
╔══════════════════════════════════════════╗
║   ATTENDANCE TRACKER SETUP              ║
╚══════════════════════════════════════════╝

Enter project name: my_class
Enter warning threshold: 70
Enter failure threshold: 40

✓ Project 'my_class' created successfully!
```

### Generated Project Structure

```
attendance_tracker_my_class/
├── Helpers/
│   ├── assets.csv          # Student attendance data
│   └── config.json         # Threshold configuration
├── reports/
│   └── reports.log         # Auto-generated reports
└── attendance_checker.py   # Ready-to-run Python script
```

---

## Project Structure

```
├── setup_project.sh        # Main scaffolding agent (320 lines)
├── Link-to-video           # Walkthrough demonstration link
├── .gitignore              # Excludes generated projects
└── README.md               # This file
```

### `setup_project.sh` Architecture

```
HEADER ──► INPUT ──► ENV CHECK ──► DIR CREATION ──► FILE GEN ──► CONFIG ──► VALIDATION ──► COMPLETION
  │          │            │              │                │            │              │
  colors    prompts    Python 3      mkdir tree      heredoc     sed          file check
  helpers   validate   detection                     templates   thresholds   summary
```

---

## Roadmap

- [x] Directory and file scaffolding
- [x] Dynamic configuration injection
- [x] Input validation and error handling
- [x] Signal trapping with archive recovery
- [x] Cross-platform support (macOS + Linux)
- [ ] Plugin system for custom project templates
- [ ] Docker-based project environments
- [ ] Git repository initialization
- [ ] CI/CD pipeline generation (GitHub Actions)
- [ ] Support for additional project types (Flask, FastAPI, Express)
- [ ] YAML/TOML configuration support
- [ ] Interactive menu (whiptail/dialog)

---

## Use Cases

- **DevOps Engineers:** Automate project provisioning across teams
- **Educators:** Generate standardized project environments for students
- **Consultants:** Quickly scaffold client projects with consistent structure
- **Hackathons:** Instant project setup so teams focus on code, not config

---

## License

Distributed under the MIT License. See `LICENSE` for more information.

---

## Contact

**KUBANA Friend Herve** - [hervekubana.dev](https://hervekubana.dev)

Project Link: [https://github.com/hervekubanadev/project-scaffolder](https://github.com/hervekubanadev/project-scaffolder)

---

<div align="center">
  <sub>Built with ❤️ for DevOps automation | Kigali, Rwanda</sub>
</div>
