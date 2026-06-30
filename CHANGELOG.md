# Changelog

All notable changes to Project Scaffolder are documented here.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.3.0] — 2026-06-30

### Added
- `.editorconfig` for consistent editor settings
- `SECURITY.md` with input validation, shell injection prevention, and sandboxing documentation
- `CONTRIBUTING.md` with development guide
- `CHANGELOG.md` (this file)
- `Makefile` with `test`, `lint`, and `clean` targets

### Changed
- Harden `setup_project.sh`: add `set -euo pipefail`, `SHELLCHECK` directives
- Improved error messages with explicit exit codes
- Add `--help` flag for usage information
- Add `--verbose` / `-v` flag for debug output

## [1.2.0] — 2026-06-15

### Changed
- Repositioned as DevOps Automation & Infrastructure Provisioning Engine
- Professional README with architecture diagram, tech stack table, and roadmap
- MIT LICENSE added

## [1.1.0] — 2026-05-20

### Added
- Walkthrough video link
- GitHub Actions CI workflow (ShellCheck + syntax validation)
- `.gitignore` with patterns for generated projects, Python artifacts, and OS files

## [1.0.0] — 2026-05-01

### Added
- Initial release of Attendance Tracker Bootstrapper
- Interactive project scaffolding with name and threshold configuration
- Directory structure creation (`Helpers/`, `reports/`)
- File generation: `assets.csv`, `config.json`, `attendance_checker.py`, `reports.log`
- Cross-platform `sed` detection (macOS / Linux)
- SIGINT handler with tar archive recovery
- Input validation (empty check, numeric bounds)
- Environment pre-flight check (Python 3)
- Final integrity validation
