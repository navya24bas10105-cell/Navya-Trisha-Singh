#!/bin/bash
# =============================================================================
# Script 4: Log File Analyzer
# Author: Navya Trisha Singh | Roll: 24BAS10105
# Course: Open Source Software | Chosen Software: Python
# Description: Reads a log file line by line, counts occurrences of a keyword,
#              shows the last 5 matching lines, and retries if the file is empty.
#              Demonstrates while-read loops, counters, and command-line args.
# =============================================================================

# --- Command-line arguments ---
# $1 = first argument passed when running the script (the log file path)
# $2 = second argument (the keyword); default is "error" if not provided
LOGFILE=$1
KEYWORD=${2:-"error"}   # := means "use this default if $2 is unset or empty"

# --- Counters ---
COUNT=0         # Counts lines matching the keyword
TOTAL=0         # Counts total lines in the file

# --- Maximum retry attempts if file is empty ---
MAX_RETRIES=3
ATTEMPT=0

# --- Step 1: Validate that a log file argument was provided ---
if [ -z "$LOGFILE" ]; then
    echo "============================================================"
    echo "  ERROR: No log file specified."
    echo "  Usage: ./script4_log_analyzer.sh <logfile> [keyword]"
    echo "  Example: ./script4_log_analyzer.sh /var/log/syslog error"
    echo "============================================================"
    exit 1   # Exit with error code 1 (non-zero = failure in Linux)
fi

# --- Step 2: Check if the file exists ---
if [ ! -f "$LOGFILE" ]; then
    echo "  Error: File '$LOGFILE' not found."
    echo "  Make sure the path is correct and the file exists."
    exit 1
fi

# --- Step 3: Do-while style retry loop if the file is empty ---
# Bash has no native do-while, so we simulate it with a while loop
# -s checks if a file exists AND has a size greater than zero
while [ ! -s "$LOGFILE" ]; do
    ATTEMPT=$((ATTEMPT + 1))   # Increment attempt counter

    echo "  WARNING: '$LOGFILE' appears to be empty. (Attempt $ATTEMPT of $MAX_RETRIES)"

    # If we've hit the max retries, exit gracefully
    if [ "$ATTEMPT" -ge "$MAX_RETRIES" ]; then
        echo "  The file is still empty after $MAX_RETRIES checks. Exiting."
        exit 1
    fi

    echo "  Waiting 2 seconds before retrying..."
    sleep 2   # Pause for 2 seconds between retries
done

# --- Step 4: Print report header ---
echo "============================================================"
echo "              LOG FILE ANALYZER"
echo "============================================================"
echo "  Log File : $LOGFILE"
echo "  Keyword  : '$KEYWORD' (case-insensitive)"
echo "------------------------------------------------------------"

# --- Step 5: Read the file line by line using a while-read loop ---
# IFS= prevents leading/trailing whitespace from being trimmed
# -r prevents backslash from being treated as escape character
while IFS= read -r LINE; do
    TOTAL=$((TOTAL + 1))   # Count every line

    # Check if this line contains the keyword (case-insensitive with -i flag)
    # grep -iq: -i = case insensitive, -q = quiet (no output, just exit code)
    if echo "$LINE" | grep -iq "$KEYWORD"; then
        COUNT=$((COUNT + 1))   # Increment match counter
    fi

done < "$LOGFILE"   # Feed the file into the while loop via input redirection

# --- Step 6: Print summary ---
echo ""
echo "  Total lines scanned : $TOTAL"
echo "  Matching lines      : $COUNT"

# Calculate percentage if total > 0 to avoid division by zero
if [ "$TOTAL" -gt 0 ]; then
    # Bash only does integer math; multiply by 100 first for accuracy
    PERCENT=$(( (COUNT * 100) / TOTAL ))
    echo "  Match percentage    : ${PERCENT}%"
fi

# --- Step 7: Show the last 5 matching lines ---
echo ""
echo "------------------------------------------------------------"
echo "  LAST 5 LINES CONTAINING '$KEYWORD':"
echo "------------------------------------------------------------"

# grep -i = case insensitive; tail -5 = last 5 results
MATCHES=$(grep -i "$KEYWORD" "$LOGFILE" | tail -5)

if [ -z "$MATCHES" ]; then
    echo "  (No matching lines found)"
else
    # Print each match with a line prefix for readability
    echo "$MATCHES" | while IFS= read -r MATCH; do
        echo "  >> $MATCH"
    done
fi

echo ""
echo "============================================================"
echo "  Tip: Run with a different keyword like:"
echo "  ./script4_log_analyzer.sh $LOGFILE WARNING"
echo "============================================================"

