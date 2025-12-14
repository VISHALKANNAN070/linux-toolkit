#!/bin/bash

#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
export DIALOGRC="$SCRIPT_DIR/themes/.dialogrc-dark"


while true; do
 # --- MAIN MENU ---
        CHOICE=$(dialog --clear \
            --title "Linux Toolkit" \
            --menu "Choose an option" 15 60 5 \
            1 "Check running processes" \
            2 "Check recent logs" \
            3 "Check system info" \
            4 "Change Theme" \
            5 "Exit" \
            2>&1 >/dev/tty)
    
        EXIT_STATUS=$?
    
        # --- HANDLING EXIT STATUS ---
        if [ $EXIT_STATUS -eq 255 ]; then
            # If CHOICE is not empty, 'dialog' spit out an error message (Crash)
            if [ -n "$CHOICE" ]; then 
                unset DIALOGRC
                dialog --msgbox "Theme Error Detected!\n\nDialog said: $CHOICE\n\nReverting to default theme." 12 60
                continue
            else
                # If CHOICE is empty, user actually pressed ESC
                break
            fi
        fi
    
        # Handle "Cancel" button (Exit Code 1)
        if [ $EXIT_STATUS -eq 1 ]; then
            break
        fi

    case "$CHOICE" in
        1)
            PROC_COUNT=$(dialog --clear \
                --title "Process Viewer" \
                --inputbox "How many processes do you want to see?" 8 50 10 \
                2>&1 >/dev/tty)

            # If user cancels inputbox
            if [ $? -ne 0 ]; then
                continue
            fi

            temp_file=$(mktemp)
            ./process_check.sh "$PROC_COUNT" > "$temp_file"

            dialog --clear \
                --title "Running Processes" \
                --textbox "$temp_file" 25 100

            rm "$temp_file"
            ;;
        
       2)
   			 LOG_COUNT=$(dialog --clear \
        		--title "Log Viewer" \
        		--inputbox "How many log entries do you want to see?" 8 50 5 \
        		2>&1 >/dev/tty)

    		# If user presses ESC or Cancel
    		if [ $? -ne 0 ]; then
        		continue
    		fi

    		temp_file=$(mktemp)
    		./log_summary.sh "$LOG_COUNT" > "$temp_file"

    		dialog --clear \
        		--title "Recent Logs" \
        		--textbox "$temp_file" 25 100

    		rm "$temp_file"
    		;;
        
       3)
                    # Ask the user if they want Fastfetch
                    dialog --title "System Info Mode" \
                           --yesno "Do you want to view system info using Fastfetch?" 7 60
                    
                    # Capture the decision (0 = Yes, 1 = No)
                    response=$?
        
                    if [ $response -eq 0 ]; then
                        # --- FASTFETCH MODE ---
                        # We exit dialog temporarily to show the colorful logo
                        clear
                        
                        if command -v fastfetch &> /dev/null; then
                            fastfetch
                        else
                            echo "Error: 'fastfetch' is not installed."
                            echo "Install it with: sudo pacman -S fastfetch (or your distro's equivalent)"
                        fi
                        
                        echo ""
                        read -p "Press Enter to return to menu..."
                        
                    else
                        # --- STANDARD SCRIPT MODE ---
                        # This is your original code
                        temp_file=$(mktemp)
                        ./system_info.sh > "$temp_file"
        
                        dialog --clear \
                            --title "System Information" \
                            --textbox "$temp_file" 20 80
        
                        rm "$temp_file"
                    fi
                    ;;
        
       4)
                    THEME=$(dialog --clear \
                        --title "Theme Selection" \
                        --menu "Choose a theme" 10 50 2 \
                        1 "Dark Mode" \
                        2 "Light Mode" \
                        2>&1 >/dev/tty)
                
                    if [ $? -ne 0 ]; then
                        continue
                    fi
                
                    # Define the target file path variable first
                    case "$THEME" in
                        1) TARGET_THEME="$SCRIPT_DIR/themes/.dialogrc-dark" ;;
                        2) TARGET_THEME="$SCRIPT_DIR/themes/.dialogrc-light" ;;
                    esac
        
                    # CHECK IF FILE EXISTS before exporting
                    if [ -f "$TARGET_THEME" ]; then
                        export DIALOGRC="$TARGET_THEME"
                        dialog --msgbox "Theme applied successfully!" 6 40
                    else
                        # Reset variable if file not found to prevent crashing
                        unset DIALOGRC
                        dialog --msgbox "Error: Theme file not found at:\n$TARGET_THEME" 10 60
                    fi
        
                    continue
                    ;;

          5)
            break
            ;;
         
    esac
done

clear
