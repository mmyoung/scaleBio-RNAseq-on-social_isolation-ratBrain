#!/bin/bash

cd /project/zhuzhuzhang/lyang/scaleBio_RNA_rat_brain/out_mRatBN/make_pseudobulk_bigwig/FvsM_DEG_tracks_plot
awk -F "\t" 'BEGIN{OFS="\t"}{print $8,$9,$10,$7,$6,$11,$2}' /project/zhuzhuzhang/lyang/scaleBio_RNA_rat_brain/out_mRatBN/soc_FvsM_DEG_total_list.txt|sed "1d" |sed s/\\//""/g|sed s/" "/""/g >soc_FvsM_DEG_bed_for_pygenometrack.bed

while read chr start end gene celltype strand fc ;do

    pyGenomeTracks --tracks ./soc_ini_for_genometrack/${celltype}_track.ini --region $chr:$start-$(($end+1)) -o ./soc_FvsM_DEG_plots/${celltype}_${gene}.png --title ${celltype}" soc FvsM logFC: "${fc}
done < ./soc_FvsM_DEG_bed_for_pygenometrack.bed
