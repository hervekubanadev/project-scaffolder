

Attendance Tracker – Project Bootstrapper
Overview
This project is a small automation system I built to remove the need for manual setup when starting an attendance tracking application. Instead of creating folders, files, and configurations one by one, the entire environment is generated automatically using a single shell script.
The goal is to demonstrate how Infrastructure as Code (IaC) can make setup faster, more reliable, and less error-prone.

⸻

What This Project Does
When the script runs, it:
* Creates a full project folder named attendance_tracker_{your_input}
* Builds the required structure:
    * attendance_checker.py (main logic)
    * Helpers/ (contains CSV data and config file)
    * reports/ (stores generated logs)
* Generates sample student attendance data
* Creates a configuration file for system settings
* Runs validation checks before completion
It also includes a Python program that:
* Reads student attendance data
* Calculates attendance percentage
* Flags students as WARNING or URGENT based on thresholds
* Writes results into a log file

⸻

How to Use It
Run the setup script:
chmod +x setup_project.sh
./setup_project.sh
You will be asked to:
* Enter a project name
* Set warning threshold (default 75%)
* Set failure threshold (default 50%)
After setup, enter the project folder and run:
python3 attendance_checker.py

⸻

Key Features (Rubric Coverage)
1. Directory Automation
The script automatically builds the required folder structure and files. It prevents duplicates and stops execution if the project already exists.

⸻

2. Configuration & Validation
* Prompts for thresholds using CLI input
* Validates numeric values
* Ensures failure threshold is lower than warning threshold
* Updates configuration using sed

⸻

3. Process Management (Signal Trap)
If the script is interrupted (Ctrl + C):
* It creates a backup archive of the current state
* Deletes the incomplete project folder
* Keeps the workspace clean

⸻

4. Environment Check
Before setup, it checks if Python 3 is installed. If not, it stops execution with an error message.

⸻

5. Logging System
The Python script generates attendance reports with timestamps and stores them in reports/reports.log. Old logs are automatically archived on new runs.

⸻

What I Learned From This Project
This project helped me understand:
* How automation replaces manual setup work
* How shell scripting can control full project lifecycles
* How to handle system signals safely
* How to connect Bash and Python in one workflow
* How real software systems maintain structure and reliability

⸻

Summary
This project is a simple but realistic example of how production systems are built using automation. It turns a manual setup process into a fully repeatable, reliable pipeline with built-in validation, logging, and recovery.


