#!/bin/bash

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
NC='\033[0m' # No Color

# Get the directory where the current script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Save the original working directory
ORIGINAL_PWD=$(pwd)

# Enter the script directory
cd "$SCRIPT_DIR" || exit 1

while true; do
    clear
    echo -e "${BLUE}============================================${NC}"
    echo -e "${GREEN}   Script Launcher - Please select a script to execute${NC}"
    echo -e "${BLUE}============================================${NC}"

    # Get all file list (excluding run.sh itself)
    # Sorting rules: first by extension, then by modification time (oldest first)
    # Use an array to store the script list
    scripts=()
    i=1

    # Generate file list with metadata for sorting: Priority(tab)Timestamp(tab)Filename
    # Only list files in the current directory that have execute permissions
    while IFS=$'\t' read -r priority timestamp file; do
        scripts+=("$file")
        
        # Determine color based on extension
        filename=$(basename "$file")
        ext="${filename##*.}"
        
        if [[ "$filename" == "$ext" ]]; then
            file_color="${YELLOW}"
        elif [[ "$ext" == "sh" ]]; then
            file_color="${GREEN}"
        elif [[ "$ext" == "py" ]]; then
            file_color="${BLUE}"
        else
            file_color="${CYAN}"
        fi
        
        # Get file modification time
        mod_time=$(date -d "@$timestamp" "+%Y-%m-%d %H:%M")
        
        # Print format: [Number] Filename (padded)   Time
        printf "  ${file_color}[%2d] %-30s %s${NC}\n" "$i" "$file" "$mod_time"
        ((i++))
    done < <(
        for f in *; do
            if [[ -f "$f" && -x "$f" && "$f" != "run.sh" ]]; then
                # Get extension and set priority: sh=1, py=2, others=3, no_ext=4
                ext="${f##*.}"
                if [[ "$f" == "$ext" ]]; then
                    priority=4
                elif [[ "$ext" == "sh" ]]; then
                    priority=1
                elif [[ "$ext" == "py" ]]; then
                    priority=2
                else
                    priority=3
                fi
                
                # Get timestamp
                ts=$(stat -c %Y "$f")
                # Output: Priority \t Timestamp \t Filename
                printf "%s\t%s\t%s\n" "$priority" "$ts" "$f"
            fi
        done | sort -t$''$'\t' -k1,1n -k2,2n
    )

    # If no executable scripts are found
    if [ ${#scripts[@]} -eq 0 ]; then
        echo -e "${RED}No other executable scripts found in the current directory.${NC}"
        exit 0
    fi

    echo -e "${BLUE}============================================${NC}"
    echo -e "  ${RED}[q] Exit${NC}"
    echo ""

    # Read user input
    read -p "$(echo -e ${GREEN}"Enter the number to select execution: "${NC})" choice

    # Handle exit
    if [[ "$choice" == "q" || "$choice" == "Q" ]]; then
        echo -e "${YELLOW}Exited.${NC}"
        exit 0
    fi

    # Validate input is a valid number
    if ! [[ "$choice" =~ ^[0-9]+$ ]]; then
        echo -e "${RED}Error: Please enter a valid numeric choice.${NC}"
        read -p "Press Enter to continue..."
        continue
    fi

    # Adjust index (user input starts from 1, array from 0)
    index=$((choice - 1))

    # Check if the index is within the valid range
    if [ $index -ge 0 ] && [ $index -lt ${#scripts[@]} ]; then
        selected_script="${scripts[$index]}"
        echo ""
        echo -e "${CYAN}Launching: ${YELLOW}$selected_script${CYAN} ...${NC}"
        echo -e "${BLUE}--------------------------------------------${NC}"
        
        # Execute the script
        # Utility scripts (without extensions) should run in the original directory
        case "$selected_script" in
            "find_and_open"|"fpath"|"replace_string"|"search_and_open")
                (cd "$ORIGINAL_PWD" && "$SCRIPT_DIR/$selected_script")
                ;;
            *)
                ./"$selected_script"
                ;;
        esac
        
        echo -e "${BLUE}--------------------------------------------${NC}"
        echo -e "${GREEN}Execution finished.${NC}"
        read -p "Press Enter to continue..."
    else
        echo -e "${RED}Error: Invalid choice number.${NC}"
        read -p "Press Enter to continue..."
    fi
done