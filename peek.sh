#!/bin/bash

if [ -z "$2" ]; then
    lines=3
else
    lines=$2
fi

total_lines=$(wc -l < "$1")

if [ "$total_lines" -lt $((2 * lines)) ]; then
    cat "$1"
else
    echo "The file has more than $((2 * lines)) lines. Displaying the first $lines and last $lines lines:"
    head -n "$lines" "$1"
    echo "..."
    tail -n "$lines" "$1"
fi
