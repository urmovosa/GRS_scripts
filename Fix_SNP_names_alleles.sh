module load Java

# -r SNP annotation file (GIANT 1000G p1v3 ALL ancestries)
# -a SNP synonyme file (from BiomaRt)
# -s input folder (unstandardized)
# -o output folder (standardized)
# -p P-value threshold (use 1)
# LogAnnotations.txt is input for script script_SNP_enrollment_QC.R

# hg18 (Lifted over)
java -Xmx55g -Xms55g -jar /groups/umcg-wijmenga/tmp04/umcg-uvosa/FixSnpNamesGWAS-1.0.4-SNAPSHOT-jar-with-dependencies.jar \
-r /groups/umcg-wijmenga/tmp04/umcg-uvosa/temp_annotation_files/GiantStatistics_Filtered_on_Maf0.001_Indels_AmbigiousSnps.vars.gz \
-a /groups/umcg-wijmenga/tmp04/umcg-uvosa/input_Marc_Jan/rs_synonyms/SNP_synonyms.txt.gz \
-s /groups/umcg-wijmenga/tmp04/umcg-uvosa/curated_GWAS_full_summary_statistics/filtered_SS_files/hg18_hg19/ \
-o /groups/umcg-wijmenga/tmp04/umcg-uvosa/curated_GWAS_full_summary_statistics/hg_to_QC/ \
-p 1 2>&1 | tee /groups/umcg-wijmenga/tmp04/umcg-uvosa/curated_GWAS_full_summary_statistics/filtered_SS_files/log_files/fix_SNPName_hg18.txt

# hg19
java -Xmx55g -Xms55g -jar /groups/umcg-wijmenga/tmp04/umcg-uvosa/FixSnpNamesGWAS-1.0.4-SNAPSHOT-jar-with-dependencies.jar \
-r /groups/umcg-wijmenga/tmp04/umcg-uvosa/temp_annotation_files/GiantStatistics_Filtered_on_Maf0.001_Indels_AmbigiousSnps.vars.gz \
-a /groups/umcg-wijmenga/tmp04/umcg-uvosa/input_Marc_Jan/rs_synonyms/SNP_synonyms.txt.gz \
-s /groups/umcg-wijmenga/tmp04/umcg-uvosa/curated_GWAS_full_summary_statistics/filtered_SS_files/hg19/ \
-o /groups/umcg-wijmenga/tmp04/umcg-uvosa/curated_GWAS_full_summary_statistics/hg_to_QC/ \
-p 1 2>&1 | tee /groups/umcg-wijmenga/tmp04/umcg-uvosa/curated_GWAS_full_summary_statistics/filtered_SS_files/log_files/fix_SNPName_hg19.txt
