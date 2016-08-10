module load Java

java -Xmx55g -Xms55g -jar /groups/umcg-wijmenga/tmp04/umcg-uvosa/FixSnpNamesGWAS-1.0.4-SNAPSHOT-jar-with-dependencies.jar \
-r /groups/umcg-wijmenga/tmp02/projects/umcg-uvosa/temp_annotation_files/GiantStatistics_Filtered_on_Maf0.001_Indels_AmbigiousSnps.vars.gz \
-a /groups/umcg-wijmenga/tmp04/umcg-uvosa/input_Marc_Jan/rs_synonyms/SNP_synonyms.txt.gz \
-o /groups/umcg-wijmenga/tmp04/umcg-uvosa/input_Marc_Jan/output_files/ \
-s /groups/umcg-wijmenga/tmp04/umcg-uvosa/curated_GWAS_full_summary_statistics/hg19_rs/ \
-p 1 2>&1 | tee /groups/umcg-wijmenga/tmp04/umcg-uvosa/input_Marc_Jan/Log_Annotations.txt

java -Xmx55g -Xms55g -jar /groups/umcg-wijmenga/tmp04/umcg-uvosa/FixSnpNamesGWAS-1.0.4-SNAPSHOT-jar-with-dependencies.jar \
-r /groups/umcg-wijmenga/tmp02/projects/umcg-uvosa/temp_annotation_files/GiantStatistics_Filtered_on_Maf0.001_Indels_AmbigiousSnps.vars.gz \
-a /groups/umcg-wijmenga/tmp04/umcg-uvosa/input_Marc_Jan/rs_synonyms/SNP_synonyms.txt.gz \
-o /groups/umcg-wijmenga/tmp04/umcg-uvosa/input_Marc_Jan/output_files2/ \
-s /groups/umcg-wijmenga/tmp04/umcg-uvosa/curated_GWAS_full_summary_statistics/hg18_to_hg19/ \
-p 1 2>&1 | tee /groups/umcg-wijmenga/tmp04/umcg-uvosa/input_Marc_Jan/Log_Annotations_hg18.txt

#	re-standardize files after fixing:

rm /groups/umcg-wijmenga/tmp04/umcg-uvosa/input_Marc_Jan/output_fixed_files/*

java -Xmx55g -Xms55g -jar /groups/umcg-wijmenga/tmp04/umcg-uvosa/input_Marc_Jan/FixSnpNamesGWAS-1.0.4-SNAPSHOT-jar-with-dependencies.jar \
-r /groups/umcg-wijmenga/tmp02/projects/umcg-uvosa/temp_annotation_files/GiantStatistics_Filtered_on_Maf0.001_Indels_AmbigiousSnps.vars.gz \
-a /groups/umcg-wijmenga/tmp04/umcg-uvosa/input_Marc_Jan/rs_synonyms/SNP_synonyms.txt.gz \
-o /groups/umcg-wijmenga/tmp04/umcg-uvosa/input_Marc_Jan/output_fixed_files/ \
-s /groups/umcg-wijmenga/tmp04/umcg-uvosa/curated_GWAS_full_summary_statistics/fixed_files/ \
-p 1 2>&1 | tee /groups/umcg-wijmenga/tmp04/umcg-uvosa/input_Marc_Jan/Log_Annotations_fixed_MAF0001.txt

java -Xmx55g -Xms55g -jar /groups/umcg-wijmenga/tmp04/umcg-uvosa/input_Marc_Jan/FixSnpNamesGWAS-1.0.4-SNAPSHOT-jar-with-dependencies.jar \
-r /groups/umcg-wijmenga/tmp02/projects/umcg-uvosa/temp_annotation_files/GiantStatistics_Filtered_on_Maf0.01_Indels_AmbigiousSnps.vars.gz \
-a /groups/umcg-wijmenga/tmp04/umcg-uvosa/input_Marc_Jan/rs_synonyms/SNP_synonyms.txt.gz \
-o /groups/umcg-wijmenga/tmp04/umcg-uvosa/input_Marc_Jan/output_fixed_files_MAF001/ \
-s /groups/umcg-wijmenga/tmp04/umcg-uvosa/curated_GWAS_full_summary_statistics/fixed_files/ \
-p 1 2>&1 | tee /groups/umcg-wijmenga/tmp04/umcg-uvosa/input_Marc_Jan/Log_Annotations_fixed_MAF001.txt

java -Xmx55g -Xms55g -jar /groups/umcg-wijmenga/tmp04/umcg-uvosa/input_Marc_Jan/FixSnpNamesGWAS-1.0.4-SNAPSHOT-jar-with-dependencies.jar \
-r /groups/umcg-wijmenga/tmp02/projects/umcg-uvosa/temp_annotation_files/GiantStatistics_Filtered_on_Maf0.05_Indels_AmbigiousSnps.vars.gz \
-a /groups/umcg-wijmenga/tmp04/umcg-uvosa/input_Marc_Jan/rs_synonyms/SNP_synonyms.txt.gz \
-o /groups/umcg-wijmenga/tmp04/umcg-uvosa/input_Marc_Jan/output_fixed_files_MAF005/ \
-s /groups/umcg-wijmenga/tmp04/umcg-uvosa/curated_GWAS_full_summary_statistics/fixed_files/ \
-p 1 2>&1 | tee /groups/umcg-wijmenga/tmp04/umcg-uvosa/input_Marc_Jan/Log_Annotations_fixed_MAF005.txt

java -Xmx55g -Xms55g -jar /groups/umcg-wijmenga/tmp04/umcg-uvosa/input_Marc_Jan/FixSnpNamesGWAS-1.0.4-SNAPSHOT-jar-with-dependencies.jar \
-r /groups/umcg-wijmenga/tmp02/projects/umcg-uvosa/temp_annotation_files/GiantStatistics_Filtered_on_Maf0.001_Indels_AmbigiousSnps.vars.gz \
-a /groups/umcg-wijmenga/tmp04/umcg-uvosa/input_Marc_Jan/rs_synonyms/SNP_synonyms.txt.gz \
-o /groups/umcg-wijmenga/tmp04/umcg-uvosa/input_Marc_Jan/output_fixed_files_filtered/ \
-s /groups/umcg-wijmenga/tmp04/umcg-uvosa/curated_GWAS_full_summary_statistics/curated_files_QC_filters/hg18_hg19/ \
-p 1 2>&1 | tee /groups/umcg-wijmenga/tmp04/umcg-uvosa/input_Marc_Jan/Log_Annotations_fixed_filtered.txt

