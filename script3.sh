#!/bin/bash
# =============================================================================
# Script 3: Disk and Permission Auditor
# Author: Navya Trisha Singh | Roll: 24BAS10105
# Course: Open Source Software | Chosen Software: Python
# Description: Loops through important Linux directories and reports their
#              size, owner, and permissions. Also checks Python-specific
#              directories to show where Python lives on the filesystem.
# =============================================================================

# --- List of standard system directories to audit ---
# Arrays in bash use parentheses and space-separated values
DIRS=("/etc" "/var/log" "/home" "/usr/bin" "/tmp" "/usr/lib")

# --- Python-specific directories to check separately ---
# These are where Python installs its interpreter, libraries, and configs
PYTHON_DIRS=("/usr/bin/python3" "/usr/lib/python3" "/etc/python3" "/usr/local/lib/python3.10" "/usr/local/lib/python3.11" "/usr/local/lib/python3.12")

echo "============================================================"
echo "          DISK AND PERMISSION AUDITOR                      "
echo "============================================================"
echo ""
echo "  Legend: [permissions] [owner] [group] | size"
echo ""
echo "------------------------------------------------------------"
echo "  STANDARD SYSTEM DIRECTORIES"
echo "------------------------------------------------------------"

# --- For loop over system directories ---
# ${DIRS[@]} expands the full array; quotes handle spaces in paths
for DIR in "${DIRS[@]}"; do
    if [ -d "$DIR" ]; then
        # ls -ld gives details of the directory itself (not its contents)
        # awk extracts: field 1=permissions, field 3=owner, field 4=group
        PERMS=$(ls -ld "$DIR" | awk '{print $1}')
        OWNER=$(ls -ld "$DIR" | awk '{print $3}')
        GROUP=$(ls -ld "$DIR" | awk '{print $4}')

        # du -sh gives human-readable size; 2>/dev/null hides permission errors
        # cut -f1 takes only the first column (the size number)
        SIZE=$(du -sh "$DIR" 2>/dev/null | cut -f1)

        # Print formatted output — printf aligns columns neatly
        printf "  %-20s | %-12s | Owner: %-10s | Size: %s\n" \
               "$DIR" "$PERMS" "$OWNER/$GROUP" "${SIZE:-N/A}"
    else
        echo "  $DIR — does not exist on this system"
    fi
done

echo ""
echo "------------------------------------------------------------"
echo "  PYTHON-SPECIFIC DIRECTORIES"
echo "------------------------------------------------------------"
echo "  (These show where Python lives on your Linux system)"
echo ""

# --- Check Python directories — same loop logic, different array ---
FOUND=0   # Counter to track if we found any Python directories

for PYDIR in "${PYTHON_DIRS[@]}"; do
    # -e checks if path exists (works for files AND directories)
    if [ -e "$PYDIR" ]; then
        FOUND=$((FOUND + 1))   # Increment counter using arithmetic expansion

        # Check if it's a directory or a file for correct ls flag
        if [ -d "$PYDIR" ]; then
            PERMS=$(ls -ld "$PYDIR" | awk '{print $1}')
            OWNER=$(ls -ld "$PYDIR" | awk '{print $3}')
            SIZE=$(du -sh "$PYDIR" 2>/dev/null | cut -f1)
            TYPE="DIR "
        else
            PERMS=$(ls -l "$PYDIR" | awk '{print $1}')
            OWNER=$(ls -l "$PYDIR" | awk '{print $3}')
            SIZE=$(ls -lh "$PYDIR" | awk '{print $5}')
            TYPE="FILE"
        fi

        printf "  [%s] %-35s | %-12s | Owner: %-8s | Size: %s\n" \
               "$TYPE" "$PYDIR" "$PERMS" "$OWNER" "${SIZE:-N/A}"
    fi
done

# If no Python directories were found, print a helpful message
if [ "$FOUND" -eq 0 ]; then
    echo "  No Python directories found. Is Python installed?"
    echo "  Try: sudo apt install python3"
fi

echo ""
echo "------------------------------------------------------------"
echo "  WHY PERMISSIONS MATTER FOR OPEN SOURCE"
echo "------------------------------------------------------------"
echo "  In Linux, permissions enforce the principle of least privilege."
echo "  Python's system libraries are owned by root and readable by all"
echo "  — open for anyone to inspect, but protected from accidental edits."
echo "  This reflects open-source values: transparency + responsibility."
echo "============================================================"

