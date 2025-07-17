#!/bin/bash

#SBATCH --job-name=bamcoverage
#SBATCH --output=bamcoverage.out
#SBATCH --error=bamcoverage.err
#SBATCH --time=36:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=2
#SBATCH --mem-per-cpu=2G
#SBATCH --partition=amd
#SBATCH --account=pi-zhuzhuzhang




#cd /project/zhuzhuzhang/lyang/scaleBio_RNA_rat_brain/out_mRatBN/make_pseudobulk_bigwig/bigwigs

bam_dir=/project/zhuzhuzhang/lyang/scaleBio_RNA_rat_brain/out_mRatBN/make_pseudobulk_bigwig/merged_bams

# for i in `ls ${bam_dir}/*.bam`
# do
# BaseName=`basename -s ".bam" ${i}`
# bamCoverage -b ${i} -o ${BaseName}.bw
# done

mkdir /project/zhuzhuzhang/lyang/scaleBio_RNA_rat_brain/out_mRatBN/make_pseudobulk_bigwig/bigwigs_RPGC_normalize
cd /project/zhuzhuzhang/lyang/scaleBio_RNA_rat_brain/out_mRatBN/make_pseudobulk_bigwig/bigwigs_RPGC_normalize
for i in `ls ${bam_dir}/*.bam`
do
    BaseName=`basename -s ".bam" ${i}`
    bamCoverage -b ${i} -o ${BaseName}.bw --normalizeUsing RPGC --effectiveGenomeSize 2647915728
done