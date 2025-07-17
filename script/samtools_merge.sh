#!/bin/bash

#SBATCH --job-name=samtools_merge
#SBATCH --output=samtools_merge.out
#SBATCH --error=samtools_merge.err
#SBATCH --time=36:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=8
#SBATCH --mem-per-cpu=2G
#SBATCH --partition=caslake
#SBATCH --account=pi-zhuzhuzhang



cd /project/zhuzhuzhang/lyang/scaleBio_RNA_rat_brain/out_mRatBN/make_pseudobulk_bigwig/merged_bams

module load samtools

for i in iso-F-22 iso-F-35 iso-M-00 iso-M-23 iso-M-40 soc-F-05 soc-F-24 soc-F-36 soc-M-01 soc-M-25 soc-M-41

do
    for j in `ls /project/zhuzhuzhang/lyang/scaleBio_RNA_rat_brain/out_mRatBN/make_pseudobulk_bigwig/sample_celltype_gather_bam/soc-M-41`
    do
        
        BAM_DIR=/project/zhuzhuzhang/lyang/scaleBio_RNA_rat_brain/out_mRatBN/make_pseudobulk_bigwig/sample_celltype_gather_bam/${i}/${j}
        if [ -d $BAM_DIR ]; then

            find $BAM_DIR -name '*.bam' | {
            read firstbam
            samtools view -h "$firstbam"
            while read bam; do
                samtools view "$bam"
            done
            } | samtools view -ubS - | samtools sort -@ 8 -o ${i}-${j}.bam -
            samtools index ${i}-${j}.bam

            samtools view ${i}-${j}.bam|wc -l

        fi

    done

done