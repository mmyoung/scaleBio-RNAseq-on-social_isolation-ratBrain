#!/bin/bash

#SBATCH --job-name=split-bam
#SBATCH --output=split-bam.out
#SBATCH --error=split-bam.err
#SBATCH --time=36:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=8
#SBATCH --mem-per-cpu=10G
#SBATCH --partition=caslake
#SBATCH --account=pi-zhuzhuzhang

export subbam=/project/zhuzhuzhang/lyang/software/subset-bam_linux
export out_bam_dir=/project/zhuzhuzhang/lyang/scaleBio_RNA_rat_brain/out_mRatBN/make_pseudobulk_bigwig/single_cell_bam
export barcode_file=/project/zhuzhuzhang/lyang/scaleBio_RNA_rat_brain/out_mRatBN/make_pseudobulk_bigwig/barcode_tsv/iso-F-04.tsv
export bam=/project/zhuzhuzhang/lyang/scaleBio_RNA_rat_brain/out_mRatBN/alignment/iso-F-04.Rat/iso-F-04.Rat.star.align/iso-F-04.Rat.bam

module load parallel
mkdir $out_bam_dir/iso-F-04
cd $out_bam_dir/iso-F-04

cat $barcode_file | parallel --jobs 8 --colsep '\t' '
    barcode={}
    tmp_file="tmp_${barcode}.tsv"
    echo "$barcode" > "$tmp_file"

    output_bam=${barcode}.bam

    # Check if output BAM file already exists
    if [ ! -f "$output_bam" ]; then
        echo "Processing barcode: $barcode"
        $subbam --bam $bam --cell-barcodes $tmp_file --bam-tag CB:Z --log-level debug --out-bam $output_bam
    else
        echo "Skipping barcode: $barcode (output BAM file exists)"
    fi

    # Clean up temporary file
    rm -f $tmp_file

'
