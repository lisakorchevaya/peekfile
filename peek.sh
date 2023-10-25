#usr/bin/bash
#define the arguments
file="$1"
n_lines="$2"

# print the first 3 lines
head -n "n_lines" "file"

# print a separator line
echo "..."

# print the last 3 lines
tail -n "n_lines" "file"
