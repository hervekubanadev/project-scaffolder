# Contributing to Project Scaffolder

## Development Environment

```bash
# Clone the repo
git clone https://github.com/hervekubanadev/project-scaffolder.git
cd project-scaffolder

# Ensure prerequisites
bash --version          # Bash 4+
python3 --version       # Python 3
shellcheck --version    # Optional, for linting
```

## Making Changes

1. Create a feature branch: `git checkout -b feat/my-change`
2. Make your changes.
3. Run ShellCheck: `shellcheck setup_project.sh`
4. Test the script: `bash setup_project.sh` (follow prompts or use test inputs)
5. Commit using conventional commits:

```
<type>: <description>

Types: feat, fix, refactor, docs, chore, test, ci
```

## Code Style

### Shell Script (`setup_project.sh`)

- Follow [Google Shell Style Guide](https://google.github.io/styleguide/shellguide.html)
- Quote all variable expansions: `"$VAR"`
- Use `[[ ]]` for conditionals (Bash 4+)
- Prefer `local` variables in functions
- Use lowercase for function names, UPPERCASE for exported globals
- Error messages go to stderr: `echo "error" >&2`
- Exit codes: 0 success, 1 general error

### Python (generated code)

- Follow PEP 8
- Use f-strings for formatting
- Type hints are encouraged

## Pull Request Process

1. Ensure ShellCheck passes with zero warnings.
2. Run the script end-to-end and verify the generated project works.
3. Update `README.md` if your change affects usage.
4. Update `CHANGELOG.md` with the new version entry.
5. PRs require at least one review.

## Testing

- Manual: `bash setup_project.sh` with various inputs (empty, numeric boundaries, Ctrl+C)
- Lint: `shellcheck setup_project.sh`
- The `Makefile` provides `make test` and `make lint` targets.

## Reporting Issues

Open a GitHub issue with:
- Steps to reproduce
- Expected vs actual behaviour
- Shell version (`bash --version`)
- OS (`uname -a`)
