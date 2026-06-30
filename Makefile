.PHONY: test lint clean help

SHELL := /bin/bash

help:
	@echo "Targets:"
	@echo "  test   - Run the script with automated test inputs"
	@echo "  lint   - Run ShellCheck on setup_project.sh"
	@echo "  clean  - Remove generated project directories and archives"
	@echo "  help   - Show this message"

test:
	@echo "Running project scaffold test..."
	@echo "my_test_school" | bash setup_project.sh
	@echo ""
	@echo "Verifying generated project..."
	@test -d attendance_tracker_my_test_school || { echo "FAIL: directory not created"; exit 1; }
	@test -f attendance_tracker_my_test_school/attendance_checker.py || { echo "FAIL: missing attendance_checker.py"; exit 1; }
	@test -f attendance_tracker_my_test_school/Helpers/config.json || { echo "FAIL: missing config.json"; exit 1; }
	@test -f attendance_tracker_my_test_school/Helpers/assets.csv || { echo "FAIL: missing assets.csv"; exit 1; }
	@test -f attendance_tracker_my_test_school/reports/reports.log || { echo "FAIL: missing reports.log"; exit 1; }
	@echo "All assertions passed."
	@rm -rf attendance_tracker_my_test_school

lint:
	@if command -v shellcheck >/dev/null 2>&1; then \
		shellcheck setup_project.sh; \
	else \
		echo "ShellCheck not installed. Install it with: brew install shellcheck"; \
		exit 1; \
	fi

clean:
	rm -rf attendance_tracker_*/
	rm -f *.tar.gz
	@echo "Cleaned generated projects and archives."
