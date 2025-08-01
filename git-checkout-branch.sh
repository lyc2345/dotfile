#!/bin/bash

# Define colors for each group
RED='\033[0;31m'    # Red for remote branches
GREEN='\033[0;32m'  # Green for local branches
YELLOW='\033[0;33m' # Yellow for tags
RESET='\033[0m'     # Reset color

# Fetch remote branches, local branches, and tags
remote_branches=$(git branch --remotes --format="%(refname:short)" | sed 's|remotes/[^/]*/||' | sort -u)
local_branches=$(git branch --format="%(refname:short)" | sort -u)
tags=$(git tag -l | sort -u)

# Combine remote branches, local branches, and tags into a single list
all_branches=()

# Prepare the output with manual numbering and coloring
output=""
index=1

# Add remote branches to the output
if [ -n "$remote_branches" ]; then
  while read -r branch; do
    all_branches+=("$branch")
    output="$output$index) ${RED}$branch${RESET}\n"
    ((index++))
  done <<< "$remote_branches"
fi

# Add local branches to the output
if [ -n "$local_branches" ]; then
  while read -r branch; do
    all_branches+=("$branch")
    output="$output$index) ${GREEN}$branch${RESET}\n"
    ((index++))
  done <<< "$local_branches"
fi

# Add tags to the output
if [ -n "$tags" ]; then
  while read -r tag; do
    all_branches+=("$tag")
    output="$output$index) ${YELLOW}$tag${RESET}\n"
    ((index++))
  done <<< "$tags"
fi

# Display the formatted options using printf to handle color and formatting
printf "$output"

# Prompt user to select a branch/tag
echo "Select a branch/tag number to checkout:"

# Read the user's selection and validate it
while true; do
  read -p "Enter the number of the branch/tag: " selected_num
  if [[ $selected_num =~ ^[0-9]+$ ]] && [ $selected_num -gt 0 ] && [ $selected_num -le ${#all_branches[@]} ]; then
    # If the selection is valid, get the branch/tag and check it out
    selection="${all_branches[$selected_num-1]}"
    git checkout "$selection"
    echo "Checked out $selection"
    break
  else
    # If invalid selection, prompt again
    echo "Invalid selection. Please choose a valid number."
  fi
done

