#!/bin/bash
# =============================================================================
# Script 1: System Identity Report
# Author: Navya Trisha Singh | Roll: 24BAS10105
# Course: Open Source Software | Chosen Software: Python
# Description: Displays a welcome screen with system information and
#              details about the open-source OS running beneath Python.
# =============================================================================

# --- Student Info (fill these in) ---
STUDENT_NAME="Navya Trisha Singh"
ROLL_NUMBER="24BAS10105"
SOFTWARE_CHOICE="Python"

# --- Gather system information using command substitution ---
KERNEL=$(uname -r)                          # Kernel version (e.g., 5.15.0-91-generic)
DISTRO=$(lsb_release -d 2>/dev/null | cut -f2 || cat /etc/os-release | grep PRETTY_NAME | cut -d= -f2 | tr -d '"')
USER_NAME=$(whoami)                         # Current logged-in user
HOME_DIR=$HOME                              # Home directory of the current user
UPTIME=$(uptime -p)                         # Human-readable uptime (e.g., up 2 hours)
CURRENT_DATE=$(date '+%A, %d %B %Y')        # Formatted date (e.g., Monday, 01 January 2025)
CURRENT_TIME=$(date '+%H:%M:%S')            # Current time in HH:MM:SS format

# --- OS License Information ---
# Linux is licensed under the GNU General Public License version 2 (GPL v2).
# This means anyone can view, modify, and redistribute the source code,
# as long as they keep the same license — this is called "copyleft".
OS_LICENSE="GNU General Public License v2 (GPL v2)"

# --- Display the welcome banner ---
echo "============================================================"
echo "         OPEN SOURCE AUDIT — SYSTEM IDENTITY REPORT        "
echo "============================================================"
echo ""
echo "  Student  : $STUDENT_NAME ($ROLL_NUMBER)"
echo "  Software : $SOFTWARE_CHOICE (PSF License)"
echo ""
echo "------------------------------------------------------------"
echo "  SYSTEM INFORMATION"
echo "------------------------------------------------------------"
echo "  Distribution : $DISTRO"
echo "  Kernel       : $KERNEL"
echo "  User         : $USER_NAME"
echo "  Home Dir     : $HOME_DIR"
echo "  Uptime       : $UPTIME"
echo "  Date         : $CURRENT_DATE"
echo "  Time         : $CURRENT_TIME"
echo ""
echo "------------------------------------------------------------"
echo "  OPEN SOURCE LICENSE"
echo "------------------------------------------------------------"
echo "  This operating system is covered by:"
echo "  $OS_LICENSE"
echo ""
echo "  This means: you are FREE to use, study, share, and"
echo "  improve this OS. The source code is always available."
echo "============================================================"

