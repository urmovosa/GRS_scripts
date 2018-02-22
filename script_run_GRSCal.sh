module load Java

#	in the P-value, lowest P-value first:
#	two-step clumping: 500 kB first and 10 MB later
#	HLA removal

# NB! in the real analysis was used v0.1.2c which fixed the bug of non-working HLA exclusion

rootdir=/groups/umcg-wijmenga/tmp04/umcg-uvosa/GRS_calculation/
ttdir=/groups/umcg-wijmenga/tmp02/projects/umcg-uvosa/Fehrmann_TriTyper/TriTyper/
ssdir=/groups/umcg-wijmenga/tmp04/umcg-uvosa/curated_GWAS_full_summary_statistics/filtered_SS_files/

java -Xmx100g -Xms100g -jar /groups/umcg-wijmenga/tmp04/umcg-uvosa/genetic_risk_score_calculator_010/GeneticRiskScoreCalculator-0.1.2b-SNAPSHOT/GeneticRiskScoreCalculator.jar \
-gi ${ttdir} \
-gt TRITYPER \
-i ${ssdir} \
-o ${rootdir}output \
-p 5e-8:1e-5:1e-4:1e-3:1e-2 \
-r 0.1 \
-w 250000:5000000 \
-er 6:25000000-35000000 \
2>&1 | tee ${rootdir}/calculate_grs_5_thresholds_v012b.log

