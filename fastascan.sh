# This script allows you to scan any directory for fasta/fa files
# The resulting output is a brief report on the contents of fasta/fa
# USAGE
# ./fastascan.sh /path/to/directory
if [[ -d "$1" ]]; then
  folder="$1"
else
  echo "Warning: no path provided, working in the current directory."
  folder=$(pwd)
fi

for file in $folder; do
  count_files=$(find . -name "*.fa" -or -name "*.fasta" | wc -l);
  echo "There are a total of $count_files detected .fasta/.fa files";

  unique_ids=$(grep ">" $(find . -name "*.fa" -or -name "*.fasta") | wc -l);
  echo "There are a total of $unique_ids unique fasta IDs in all deteced files";
done


#lines=$2

# if [ $lines -le $((lines * 2)) ]; then
#  cat file
#else
#  echo "Warning: This file has more than twice the $N_lines lines."
#  head -n "$lines"
#  echo "..."
#  tail -n "$lines"
