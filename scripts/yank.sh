#!/bin/bash

# Debug log
exec 19>>/tmp/yank_debug.log
BASH_XTRACEFD=19
set -x

echo "--- $(date) ---" >&19

# Read input from stdin
input=$(cat)

# Function to try copying via xclip with auto-detection
try_xclip() {
    echo "Entering try_xclip" >&19
    # If DISPLAY is already set and works, use it
    if [ -n "$DISPLAY" ]; then
        echo "DISPLAY is set to $DISPLAY" >&19
        if echo -n "$input" | xclip -selection clipboard -i 2>>/tmp/yank_debug.log; then
            echo "xclip success with existing DISPLAY" >&19
            return 0
        fi
        echo "xclip failed with existing DISPLAY=$DISPLAY" >&19
    else
        echo "DISPLAY is not set" >&19
    fi

    # Try to find a valid DISPLAY and XAUTHORITY from running processes
    echo "Attempting auto-detection for xclip..." >&19
    for socket in /tmp/.X11-unix/X*; do
        [ -e "$socket" ] || continue
        display_num=${socket##*X}
        
        export DISPLAY=":$display_num"
        echo "Trying DISPLAY=$DISPLAY" >&19
        
        # Try default Xauthority
        if [ -f "$HOME/.Xauthority" ]; then
            export XAUTHORITY="$HOME/.Xauthority"
            echo "Using XAUTHORITY=$XAUTHORITY" >&19
            if echo -n "$input" | xclip -selection clipboard -i 2>>/tmp/yank_debug.log; then
                echo "Success!" >&19
                return 0
            fi
            echo "Failed with XAUTHORITY" >&19
        fi
        
        # Try without explicit XAUTHORITY (sometimes it's in a weird place or not needed)
        unset XAUTHORITY
        if echo -n "$input" | xclip -selection clipboard -i 2>>/tmp/yank_debug.log; then
             echo "Success without explicit XAUTHORITY!" >&19
             return 0
        fi
        echo "Failed without XAUTHORITY" >&19
    done
    
    echo "All xclip attempts failed." >&19
    return 1
}

# 1. Try Xclip (Primary for local X11)
# Only attempt xclip if we are NOT in a remote SSH session (SSH_TTY check),
# OR if we are explicitly forwarding X11 (DISPLAY check).
# If we are local (no SSH_TTY), we force try xclip.
echo "Checking environment: SSH_TTY=$SSH_TTY, DISPLAY=$DISPLAY" >&19

if [ -z "$SSH_TTY" ]; then
    echo "Local session detected (SSH_TTY is empty), calling try_xclip" >&19
    try_xclip
elif [ -n "$DISPLAY" ]; then
    echo "Remote session with forwarding (DISPLAY set), calling try_xclip" >&19
    try_xclip
else
    echo "Remote session without forwarding. Skipping xclip." >&19
fi

# 2. OSC 52 (For Terminal/SSH/Tmux capability)
# Always send OSC 52 as a backup/parallel method.
limit=74999
if [ ${#input} -gt $limit ]; then
    input=$(echo -n "$input" | head -c $limit)
fi

b64=$(echo -n "$input" | base64 | tr -d '\n')

if [ -n "$TMUX" ]; then
    echo "Sending Tmux OSC 52 sequence" >&19
    # Tmux wrapping
    printf "\033Ptmux;\033\033]52;c;%s\007\033\\" "$b64" > /dev/tty
else
    echo "Sending Standard OSC 52 sequence" >&19
    # Standard OSC 52
    printf "\033]52;c;%s\007" "$b64" > /dev/tty
fi
