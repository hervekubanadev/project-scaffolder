# Security Policy

## Supported Versions

| Version | Supported          |
|---------|--------------------|
| 1.x     | :white_check_mark: |

## Reporting a Vulnerability

Report vulnerabilities to **hervekubana.dev** or open a GitHub issue with the `security` label. You should receive a response within 48 hours.

## Security Posture

### Input Validation

All user-supplied input is validated before filesystem operations:

- **Project name**: Must be non-empty. Shell metacharacters are not filtered for directory naming but embedded in `$BASE_DIR` only — the script does not `eval` or `source` user input.
- **Threshold values**: Must be numeric integers in `[0, 100]`. Regex `^[0-9]+$` ensures no injection.
- **Y/n prompts**: Matched against `^[YyNn]$` — any unexpected input is rejected.

### Shell Injection Prevention

- The script uses `read` (not `eval`) for all user interaction.
- Thresholds are injected into JSON via `sed` pattern substitution, not through shell expansion of user-controlled strings.
- No user input is passed to `eval`, `source`, `exec`, `$()`, or backtick expansion.
- `PROJECT_NAME` is used only as a directory name component and in `echo` statements — never in a shell evaluation context.

### Sandboxing

- The scaffolder operates entirely within the current user's working directory.
- It never reads from or writes to system directories (`/etc`, `/usr`, `/opt`, etc.).
- No external network calls are made — the tool is fully offline.
- Python code generation produces a static script; no dynamic code execution occurs at scaffold time.
- `SIGINT` handler archives in-progress work before cleanup, preventing partial state exposure.

### Dependencies

- **Bash 4+**: Built-in `read`, `mkdir`, `sed`, `tar` — no external binaries fetched at runtime.
- **Python 3**: Only invoked in the *generated* project, not by the scaffolder itself.

## Best Practices for Users

1. Always review the script before running: `less setup_project.sh`
2. Run only from directories where you intend to create projects.
3. Keep your shell and Python interpreter up to date.
4. Do not run as `root` — the script is designed for unprivileged users.
