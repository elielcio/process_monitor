#!/bin/bash

# Set default maximum execution time to 10 minutes (600 seconds)
MAX_EXEC_TIME=600

echo "iniciou"
# Parse command line arguments
while getopts ":l" opt; do
  case $opt in
    l)
      LOG=true
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      ;;
  esac
done
shift $((OPTIND-1))

echo "passou pelo options"

# Get process name from command line arguments
if [ $# -eq 0 ]; then
  echo "Usage: $0 process_name [max_execution_time]" >&2
  exit 1
fi
PROCESS_NAME=$1

echo " processo $PROCESS_NAME "
# Get maximum execution time from command line arguments (if specified)
if [ $# -eq 2 ]; then
echo " entrou argumento 2 "
  MAX_EXEC_TIME=$2
fi

echo " Tempo $MAX_EXEC_TIME "
# Initialize the "pid" variable with the process ID of the specified process
pid=$(pgrep "$PROCESS_NAME")

# Check if the process is running
if [ -z "$pid" ]; then
  if [ "$LOG" = true ]; then
    echo "The process is not running."
  fi
  echo "saiu"
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

echo "total $total"

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