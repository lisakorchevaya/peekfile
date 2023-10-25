#usr/bin/bash
# print the first 3 lines
head -n $2 $1;

# print a separator line
echo "...";

# print the last 3 lines
tail -n $2 $1;
