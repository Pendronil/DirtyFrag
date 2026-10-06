#!/bin/bash

# Script to concatenate all .xml, .kt, and .java files into a single text file
# Usage: ./concat_source.sh [output_file]

OUTPUT_FILE="${1:-source_code.txt}"
SEPARATOR="============================================================"

echo "Starting source code concatenation..."
echo "Output file: $OUTPUT_FILE"
rm -f "$OUTPUT_FILE"

echo "SOURCE CODE CONCATENATION" > "$OUTPUT_FILE"
echo "Generated on: $(date)" >> "$OUTPUT_FILE"
echo "Files included: .xml, .kt, .java" >> "$OUTPUT_FILE"
echo "$SEPARATOR" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"

# Counter for files processed
file_count=0

# Function to process files
process_files() {
    local pattern="$1"
    local files
    files=$(find . -name "$pattern" -type f | grep -v "/build/" | grep -v "/.git/")

    while IFS= read -r file; do
        if [[ -n "$file" && -f "$file" ]]; then
            echo "Processing: $file"
            echo "FILE: $file" >> "$OUTPUT_FILE"
            echo "$SEPARATOR" >> "$OUTPUT_FILE"
            cat "$file" >> "$OUTPUT_FILE"
            echo "" >> "$OUTPUT_FILE"
            echo "$SEPARATOR" >> "$OUTPUT_FILE"
            echo "" >> "$OUTPUT_FILE"
            ((file_count++))
        fi
    done <<< "$files"
}

# Process each file type
process_files "*.xml"
process_files "*.kt"
process_files "*.java"
process_files "*.kts"
process_files "*.h"
process_files "*.txt"
process_files "*.c"
process_files "*.S"
process_files "*.inc"
process_files "*.sh"
process_files "Makefile"
process_files "splicehelper"
# Add summary
echo "" >> "$OUTPUT_FILE"
echo "SUMMARY" >> "$OUTPUT_FILE"
echo "$SEPARATOR" >> "$OUTPUT_FILE"
echo "Total files processed: $file_count" >> "$OUTPUT_FILE"
echo "File types: XML, Kotlin, Java" >> "$OUTPUT_FILE"

echo "Completed! Processed $file_count files."
echo "Output saved to: $OUTPUT_FILE"
