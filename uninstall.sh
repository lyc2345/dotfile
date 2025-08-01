#!/bin/bash

DST="$HOME"

for f in * .[^.]*; do
    unlink "$DST/$(basename "$f")" #2> /dev/null
    if [ $? -eq 0 ]; then
        echo "unlink '$DST/$(basename "$f")'"
    else
        echo "unlink: '$DST/$(basename "$f")' not found"
    fi
done