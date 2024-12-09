#!/bin/bash

# Check for correct usage
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <metadata_file> <bam_directory>"
    echo "Example: $0 metadata.tsv /path/to/bam_files"
    exit 1
fi

# Assign command-line arguments to variables
metadata_file=$1     # Path to metadata file
bam_directory=$2     # Path to directory containing BAM files

cd /project/zhuzhuzhang/lyang/scaleBio_RNA_rat_brain/out_mRatBN/make_pseudobulk_bigwig/sample_celltype_gather_bam

# Loop through each line in the metadata file
while IFS=$'\t' read -r cell_id sample_name cell_type; do
    # Skip the header row (assuming 'CellID', 'SampleName', 'CellType' as column headers)
    if [[ "$cell_id" == "CellID" ]]; then
        continue
    fi

    # Define the directory path for each cell type in each sample
    target_directory="${sample_name}/${cell_type}"

    # Create the target directory if it doesn't exist
    mkdir -p "$target_directory"

    # Define the source BAM file and target soft link path
    source_bam="${bam_directory}/${cell_id}.bam"
    target_link="${target_directory}/${cell_id}.bam"

    # Check if the BAM file exists before creating the link
    if [ -f "$source_bam" ]; then
        ln -s "$source_bam" "$target_link"
        echo "Created soft link for $cell_id in $target_directory"
    else
        echo "Warning: BAM file for $cell_id not found in $bam_directory"
    fi

done < "$metadata_file"