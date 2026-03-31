#!/bin/bash
# =============================================================================
# Script 5: The Open Source Manifesto Generator
# Author: Aryan Singh | Roll: 24MIM10121
# Course: Open Source Software | Chosen Software: Python
# Description: Asks the user 3 interactive questions and generates a
#              personalised open source philosophy statement, saved to a file.
#              Demonstrates: read, string concatenation, file writing, date,
#              and the concept of aliases.
# =============================================================================

# --- Alias concept demonstration ---
# In Linux, aliases let you create shortcuts for long commands.
# For example, in your ~/.bashrc you might add:
#   alias py='python3'
#   alias audit='./script1_system_identity.sh'
# We demonstrate the concept here even though aliases don't persist in scripts.
# (Aliases are meant for interactive shell sessions, not scripts.)
alias today='date "+%d %B %Y"'   # Example alias definition (for illustration)

# --- Get the current date using the date command ---
DATE=$(date '+%d %B %Y')         # e.g., 30 March 2026

# --- Output file: named after the current user ---
OUTPUT="manifesto_$(whoami).txt"  # e.g., manifesto_student.txt

# --- Welcome message ---
echo "============================================================"
echo "       THE OPEN SOURCE MANIFESTO GENERATOR"
echo "       Powered by Python's philosophy of openness"
echo "============================================================"
echo ""
echo "  Answer three questions honestly."
echo "  Your answers will be woven into a personal manifesto"
echo "  that reflects your relationship with open source."
echo ""
echo "------------------------------------------------------------"

# --- Question 1: A tool they use every day ---
# read -p prints a prompt and waits for user input
# The input is stored in the variable TOOL
read -p "  1. Name one open-source tool you use every day: " TOOL

# --- Question 2: What freedom means to them ---
read -p "  2. In one word, what does 'freedom' mean to you?  " FREEDOM

# --- Question 3: What they would build and share ---
read -p "  3. Name one thing you would build and share freely: " BUILD

echo ""
echo "------------------------------------------------------------"
echo "  Generating your manifesto..."
echo "------------------------------------------------------------"
echo ""

# --- Build the manifesto using string concatenation ---
# We compose the full paragraph by combining variables with fixed text.
# Using >> appends to the file; > would overwrite it.
# We use > first to create/clear the file, then >> to add lines.

# Clear or create the output file
> "$OUTPUT"

# Write the manifesto to the file line by line
echo "============================================================" >> "$OUTPUT"
echo "  MY OPEN SOURCE MANIFESTO" >> "$OUTPUT"
echo "  Written by: $(whoami) | Date: $DATE" >> "$OUTPUT"
echo "============================================================" >> "$OUTPUT"
echo "" >> "$OUTPUT"

# --- Main paragraph: string concatenation using variables ---
# Each echo adds a sentence; together they form one coherent paragraph.
echo "  Every day, I rely on $TOOL — a piece of software that someone" >> "$OUTPUT"
echo "  built, shared, and gave to the world without asking for anything" >> "$OUTPUT"
echo "  in return. That act of generosity is what open source means to me." >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "  To me, freedom means $FREEDOM. In the context of software, that" >> "$OUTPUT"
echo "  freedom is not just philosophical — it is practical. When I can" >> "$OUTPUT"
echo "  read the source code of the tools I depend on, I am not just a" >> "$OUTPUT"
echo "  user. I am a participant. I can learn, adapt, and contribute." >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "  One day, I want to build $BUILD and share it openly — not because" >> "$OUTPUT"
echo "  I have to, but because I understand what it means to benefit from" >> "$OUTPUT"
echo "  the work of others. Open source is not a license agreement." >> "$OUTPUT"
echo "  It is a philosophy: knowledge grows when it is shared." >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "  I am a student of open source. I stand on the shoulders of" >> "$OUTPUT"
echo "  giants — from Guido van Rossum who gave us Python, to Linus" >> "$OUTPUT"
echo "  Torvalds who gave us Linux, to the thousands of unnamed" >> "$OUTPUT"
echo "  contributors who made the modern world possible, one commit" >> "$OUTPUT"
echo "  at a time." >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "============================================================" >> "$OUTPUT"
echo "  \"Given enough eyeballs, all bugs are shallow.\"" >> "$OUTPUT"
echo "  — Eric S. Raymond, The Cathedral and the Bazaar" >> "$OUTPUT"
echo "============================================================" >> "$OUTPUT"

# --- Display the manifesto on screen ---
echo ""
cat "$OUTPUT"

echo ""
echo "------------------------------------------------------------"
echo "  Your manifesto has been saved to: $OUTPUT"
echo "  Add it to your GitHub repo as a bonus file!"
echo "============================================================"

