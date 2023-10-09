#! /bin/env bash

# Read from unix socket
nc -U /tmp/sock.test --recv-only |
    # Print an updated sliding window of most recent characters after each new character
    awk -i util.awk '{ del arr[NR - 11]; arr[NR] = $0; printf "%s\n",join(arr, NR-7, NR, ""); fflush(); }' |
    # Convert non-printable ASCII characters to caret notation
    cat -v |
    # Convert caret notation to Vim's notation
    sed -u 's/\^\([a-zA-Z]\)/<C-\1>/g' |
    # Spell out <Enter>
    sed -u 's/<C-[mM]>/<Enter>/g' |
    sed -u 's/M-\^@kb/<BS>/g' |
    sed -u 's/M-\^@M-}h//g' |
    sed -u 's/\^\[/<Esc>/g' |
    # align the output
    awk '{ printf "\n"; for(x = length($0); x <=20; x++) printf " "; printf "%s",$0; fflush();}'
