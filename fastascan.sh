# This script allows you to scan any directory for fasta/fa files
# The resulting output is a brief report on the contents of fasta/fa
# USAGE
# ./fastascan.sh /path/to/folder number of lines (an integer)

# Evaluate the first command argument
if [[ -n "$1" && -d "$1" ]]; then
  folder="$1"
  echo "Working in $folder"
  echo "..."
else
  folder=$(pwd) # if no path provided, sets to default: current directory
  echo "Warning: no path provided, working in the current directory: $folder"
  echo "..."
fi

# Brief summary of the folder: count all files and sequences
echo "Brief summary of the folder and its subfolders:"
for file in "$folder"; do
  count_files=$(find "$folder" -name "*.fa" -or -name "*.fasta" | wc -l);
  echo "1. There are a total of $count_files detected .fasta/.fa files";

  unique_ids=$(grep ">" $(find "$folder" -name "*.fa" -or -name "*.fasta") | wc -l);
  echo "2. There are a total of $unique_ids unique fasta IDs in all deteced files";
  echo "..."
done

# A summary for each file individually
find "$folder" -name "*.fa" -or -name "*.fasta" | while read file; do
  echo "File report:";

  if [[ -h "$file" ]]; then # Check if the file is a regular file
    ftype="symlink"
  else
    ftype="regular file"
  fi

  count_seq=$(grep ">" "$file" | wc -l); # Count the sequences

  # Check the file content
  if grep -q -i -E '^[^>]*[RDQEHILKMFPSWYV]+' "$file"; then # This RegExp finds letter matches exclusive to amino acids (exclude A,C,T,G,U,N) in lines that don't start with ">"
    fcontent="amino acids"
  else # If no match with characters "RDQEHILKMFPSWYV" made, we can assume the file content is nucleotides
    fcontent="nucleotides"
  fi

  # Count total sequence length: sum lengths of all lines of nucleotides/amino acids
  total_seq=$(awk '!/^>/ {gsub(/-| /, ""); len += length} END {print len}' "$file") # Exclude gaps "-", spaces and newline

  # Print file report - a universal string that adapts based on previously defined variables
  echo ""$file" is a "$ftype" containing "$count_seq" sequences of "$fcontent" with a total seuqnce length of "$total_seq $fcontent""
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
