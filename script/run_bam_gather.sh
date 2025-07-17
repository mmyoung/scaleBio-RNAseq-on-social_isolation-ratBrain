#!/bin/bash

#SBATCH --job-name=bam_gather
#SBATCH --output=bam_gather.out
#SBATCH --error=bam_gather.err
#SBATCH --time=36:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=2
#SBATCH --mem-per-cpu=10G
#SBATCH --partition=caslake
#SBATCH --account=pi-zhuzhuzhang

cellID=/project/zhuzhuzhang/lyang/scaleBio_RNA_rat_brain/out_mRatBN/make_pseudobulk_bigwig/sample_celltype_gather_bam/cellID_sample.txt



cd /project/zhuzhuzhang/lyang/scaleBio_RNA_rat_brain/out_mRatBN/make_pseudobulk_bigwig/sample_celltype_gather_bam

for target_sample in iso-F-22 iso-F-35 iso-M-00 iso-M-23 iso-M-40 soc-F-05 soc-F-24 soc-F-36 soc-M-01 soc-M-25 soc-M-41

do

    source_bam_dir=/project/zhuzhuzhang/lyang/scaleBio_RNA_rat_brain/out_mRatBN/make_pseudobulk_bigwig/single_cell_bam/${target_sample}


    awk -v sample=$target_sample '$2==sample' $cellID > ${target_sample}.meta

    /project/zhuzhuzhang/lyang/scaleBio_RNA_rat_brain/out_mRatBN/make_pseudobulk_bigwig/src/gather_bam_files.sh ${target_sample}.meta $source_bam_dir

done