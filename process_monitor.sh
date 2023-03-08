#!/bin/bash

# Set default maximum execution time to 10 minutes (600 seconds)
MAX_EXEC_TIME=600

# Parse command line arguments
while getopts ":l:r" opt; do
  case $opt in
    l)
      LOG=true
      ;;
    r)
      RESTART=true
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      ;;
  esac
done
shift $((OPTIND-1))

# Get process name from command line arguments
if [ $# -eq 0 ]; then
  echo "Usage: $0 process_name [max_execution_time]" >&2
  exit 1
fi
PROCESS_NAME=$1

# Get maximum execution time from command line arguments (if specified)
if [ $# -eq 2 ]; then
  MAX_EXEC_TIME=$2
fi

# Initialize the "pid" variable with the process ID of the specified process
pid=$(pgrep "$PROCESS_NAME")

# Check if the process is running
if [ -z "$pid" ]; then
  if [ "$LOG" = true ]; then
    echo "The process is not running."
  fi
  exit 1
fi

# Get the process execution time
time=$(ps -o etime= -p "$pid")

# Split the time into days, hours, minutes, and seconds
d=$(echo "$time" | awk -F '-' '{print $1}')
h=$(echo "$time" | awk -F '-' '{print $2}' | awk -F ':' '{print $1}')
m=$(echo "$time" | awk -F '-' '{print $2}' | awk -F ':' '{print $2}')
s=$(echo "$time" | awk -F '-' '{print $2}' | awk -F ':' '{print $3}')

# Calculate the total execution time in seconds
total=$(echo "$d * 86400 + $h * 3600 + $m * 60 + $s" | bc)

# Check if the execution time is greater than the maximum execution time
if [ "$total" -gt "$MAX_EXEC_TIME" ]; then
  #if [ "$LOG" = true ]; then
    echo "The process has been running for more than $MAX_EXEC_TIME seconds. Terminating..."
  #fi
  kill "$pid"
else
  if [ "$LOG" = true ]; then
    echo "The process has been running for $time."
  fi
fi

# Restart the process
if [ "$RESTART" = true ]; then
    echo "Restarting the process..."
    systemctl stop "$PROCESS_NAME"
    systemctl start "$PROCESS_NAME"
fi