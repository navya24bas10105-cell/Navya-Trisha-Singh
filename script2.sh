#!/bin/bash
# =============================================================================
# Script 2: FOSS Package Inspector
# Author: Aryan Singh | Roll: 24MIM10121
# Course: Open Source Software | Chosen Software: Python
# Description: Checks if Python (and related FOSS packages) are installed,
#              retrieves version/license info, and prints a philosophy note
#              about each package using a case statement.
# =============================================================================

# --- The primary package we are auditing ---
PACKAGE="python3"

# --- Function to check and describe a package ---
# Functions let us reuse the same logic for multiple packages
inspect_package() {
    local PKG=$1   # First argument = package name

    echo ""
    echo "------------------------------------------------------------"
    echo "  Inspecting: $PKG"
    echo "------------------------------------------------------------"

    # Check if package is installed using dpkg (Ubuntu/Debian)
    # &>/dev/null suppresses all output so we only use the exit code
    if dpkg -l "$PKG" 2>/dev/null | grep -q "^ii"; then
        echo "  Status  : INSTALLED"

        # Get the installed version
        VERSION=$(dpkg -l "$PKG" 2>/dev/null | grep "^ii" | awk '{print $3}')
        echo "  Version : $VERSION"

        # Get a short description from dpkg
        SUMMARY=$(dpkg -l "$PKG" 2>/dev/null | grep "^ii" | awk '{$1=$2=$3=$4=""; print $0}' | sed 's/^ *//')
        echo "  Summary : $SUMMARY"

    else
        echo "  Status  : NOT INSTALLED"
        echo "  Tip     : Install it with: sudo apt install $PKG"
    fi

    # --- Case statement: print philosophy note based on package name ---
    # A case statement is like if-else but cleaner for matching string patterns
    case $PKG in
        python3)
            echo "  Philosophy: Python — 'Batteries included.' Born from Guido's"
            echo "              belief that code should be readable by humans first."
            ;;
        git)
            echo "  Philosophy: Git — Linus built it in 2 weeks after BitKeeper"
            echo "              revoked free access. Freedom by necessity."
            ;;
        vlc)
            echo "  Philosophy: VLC — Students at École Normale Supérieure built"
            echo "              it to stream video freely across their campus."
            ;;
        firefox)
            echo "  Philosophy: Firefox — Mozilla's answer to IE's monopoly."
            echo "              A nonprofit browser for an open web."
            ;;
        apache2 | httpd)
            echo "  Philosophy: Apache — 'A patchy server.' Built from patches"
            echo "              shared freely between webmasters in the 1990s."
            ;;
        *)
            echo "  Philosophy: An open-source tool built on the idea that"
            echo "              knowledge shared is knowledge multiplied."
            ;;
    esac
}

# --- Main execution ---
echo "============================================================"
echo "           FOSS PACKAGE INSPECTOR                          "
echo "============================================================"

# Inspect Python (our main software)
inspect_package "python3"

# Inspect a few related/comparison FOSS packages
inspect_package "git"
inspect_package "vlc"
inspect_package "firefox"

echo ""
echo "============================================================"
echo "  Audit complete. All packages above are open-source."
echo "============================================================"

