<div align="center">
  <h1>Project Scaffolder</h1>
  <p><strong>DevOps Automation & Infrastructure Provisioning Engine</strong></p>
  <p>
    <img src="https://img.shields.io/badge/Bash-4EAA25" alt="Bash">
    <img src="https://img.shields.io/badge/Python-3-3776AB" alt="Python 3">
    <img src="https://img.shields.io/badge/IaC-00B4AB" alt="Infrastructure as Code">
    <img src="https://img.shields.io/badge/DevOps-FF6B6B" alt="DevOps">
    <img src="https://img.shields.io/badge/Automation-8A2BE2" alt="Automation">
  </p>
</div>

---

## Problem Statement

Development teams waste hours on repetitive project bootstrapping — creating directory structures, configuration files, and application skeletons from scratch. This manual process is error-prone, inconsistent across teams, and lacks validation, leading to misconfigured environments and delayed delivery. Project Scaffolder solves this by providing a deterministic, validated, and repeatable infrastructure provisioning engine that generates production-ready project environments in seconds.

---

## Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                        INPUT LAYER                               │
│  ┌─────────────────┐  ┌────────────────┐  ┌──────────────────┐ │
│  │  Project Name   │  │  Warning       │  │  Failure         │ │
│  │  (validated)    │  │  Threshold     │  │  Threshold       │ │
│  │                 │  │  (0-100)       │  │  (0-100)         │ │
│  └─────────────────┘  └────────────────┘  └──────────────────┘ │
└──────────────────────────────┬───────────────────────────────────┘
                               │
┌──────────────────────────────▼──────────────────────────────────┐
│                      PROVISIONING PIPELINE                       │
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
│                                                                  │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │  ERROR HANDLING & SIGNAL PROTECTION                      │   │
│  │  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  │   │
│  │  │ Input       │  │ Permission   │  │ SIGINT       │  │   │
│  │  │ Validation  │  │ Recovery     │  │ Archive      │  │   │
│  │  └──────────────┘  └──────────────┘  └──────────────┘  │   │
│  └──────────────────────────────────────────────────────────┘   │
└──────────────────────────────────────────────────────────────────┘
```

---

## Features

### Automated Infrastructure Provisioning
- Creates complete project directory structure in seconds
- Generates configuration files with user-defined parameters
- Produces ready-to-run Python application code
- Deterministic output: same inputs → same project structure

### Enterprise-Grade Error Handling
- **Input validation**: Empty names, non-numeric thresholds, range checking
- **Duplicate collision detection**: Prevents overwriting existing projects
- **Permission recovery**: Catches and surfaces permission-denied errors
- **Environment verification**: Python 3 pre-flight check

### Cross-Platform Configuration Engine
- Dynamic threshold injection using `sed` (macOS + Linux)
- BSD/GNU sed auto-detection via `uname`
- JSON-based runtime configuration

### Signal Protection & Recovery
- SIGINT (Ctrl+C) trap archives in-progress project to `.tar.gz`
- Graceful cleanup of partial artifacts
- Timestamped recovery archives

### Built-in Attendance Checker
- CSV-based student attendance tracking
- Configurable warning and failure thresholds
- Dry-run mode for testing
- Timestamped reports with auto-archiving

---

## Tech Stack

| Layer | Technology |
|-------|-----------|
| **Orchestration** | Bash 5+ shell scripting |
| **Runtime Logic** | Python 3 |
| **Data Formats** | CSV, JSON, plain-text |
| **Configuration** | sed (GNU + BSD) |
| **Archiving** | tar + gzip |
| **Platform** | macOS, Linux |

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
│   ├── assets.csv              # Student attendance data
│   └── config.json             # Threshold configuration
├── reports/
│   └── reports.log             # Auto-generated reports
└── attendance_checker.py       # Ready-to-run Python script
```

---

## Security Considerations

| Concern | Mitigation |
|---------|------------|
| Arbitrary execution | Input validated before file system operations |
| Privilege escalation | Runs at user's permission level; permission denied is caught gracefully |
| Partial state on crash | SIGINT handler archives incomplete work |
| Deterministic output | Same inputs always produce identical project structures |
| Network dependency | Operates entirely offline — no external downloads |

---

## Project Structure

```
├── setup_project.sh           # Main provisioning engine (Bash)
├── Link-to-video              # Walkthrough demonstration
├── .gitignore                 # Excludes generated projects
├── .github/
│   └── workflows/
│       └── ci.yml             # CI pipeline (ShellCheck + syntax validation)
├── docs/
│   └── ARCHITECTURE.md        # Detailed architecture documentation
└── README.md                  # This file
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
- [ ] Git repository initialisation
- [ ] CI/CD pipeline generation (GitHub Actions)
- [ ] Support for additional project types (Flask, FastAPI, Express)
- [ ] YAML/TOML configuration support
- [ ] Interactive menu (whiptail/dialog)

---

## Use Cases

- **DevOps Engineers**: Automate project provisioning across teams
- **Educators**: Generate standardised project environments for students
- **Consultants**: Quickly scaffold client projects with consistent structure
- **Hackathons**: Instant project setup so teams focus on code, not config
- **Platform Teams**: Embed as a CI/CD step for automated environment creation

---

## License

Distributed under the MIT License. See `LICENSE` for more information.

---

## Contact

**KUBANA Friend Herve** — [hervekubana.dev](https://hervekubana.dev)

Project Link: [https://github.com/hervekubanadev/project-scaffolder](https://github.com/hervekubanadev/project-scaffolder)

---

<div align="center">
  <sub>Built with ❤️ for DevOps automation | Kigali, Rwanda</sub>
</div>
