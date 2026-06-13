#!/bin/bash

echo "🚀 Initializing Attendance Tracker Project Factory"

PROJECT_NAME=""
read -p "Enter project suffix (e.g. student1): " PROJECT_NAME

BASE_DIR="attendance_tracker_${PROJECT_NAME}"

echo "🔍 Checking Python3 installation..."

if python3 --version >/dev/null 2>&1; then
  echo "✅ Python3 is available"
else
  echo "⚠️ Warning: Python3 is not installed"
fi

