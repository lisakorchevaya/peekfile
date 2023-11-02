#!/bin/bash

if [ -z "$2" ]; then
    lines=3
else
    lines=$2
fi

if [ $(wc -l < "$1") -lt $((2 * lines)) ]; then
    cat "$1"
else
    echo "Warning: This file has more than twice the $lines lines. Providing only the first $lines and last $lines lines:"
    head -n "$lines" "$1"
    echo "..."
    tail -n "$lines" "$1"
fi
