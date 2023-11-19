# This script allows you to scan any directory for fasta/fa files
# The resulting output is a brief report on the contents of fasta/fa
# USAGE
# ./fastascan.sh /path/to/folder number of lines (an integer)

if [[ -n "$1" && -d "$1" ]]; then
  folder="$1"
  echo "Working in $folder"
  echo "..."
else
  folder=$(pwd)
  echo "Warning: no path provided, working in the current directory $folder."
  echo "..."
fi

# Brief summary of the folder
echo "Brief summary of the folder and its subfolders:"
for file in $folder; do
  count_files=$(find . -name "*.fa" -or -name "*.fasta" | wc -l);
  echo "1. There are a total of $count_files detected .fasta/.fa files";

  unique_ids=$(grep ">" $(find . -name "*.fa" -or -name "*.fasta") | wc -l);
  echo "2. There are a total of $unique_ids unique fasta IDs in all deteced files";
  echo "..."
done

# Providing a summary for each file individually
for file in $(find . -name "*.fa" -or -name "*.fasta");
  do echo "Generating report for: $file";
  if [[ -h "$file" ]]; then
    echo "$file is a symlink"
  else
    echo "$file is a regular file"
  fi
  count_seq=$(grep ">" $file | wc -l);
  echo "$file has $count_seq sequences"
  echo "..."

#  if [[ -z "$2" ]]; then
#    lines=0
#  else
#    lines=$2
#  fi

#  if [[ $lines -le $((lines * 2)) ]]; then
#    cat $file
#  else
#    echo "Warning: This file has more than twice the $lines lines. Showing the first and last $lines."
#    head -n "$lines"
#    echo "..."
#    tail -n "$lines"
#  fi
done
