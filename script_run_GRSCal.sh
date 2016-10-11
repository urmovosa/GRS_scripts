module load Java

#	in the P-value, lowest P-value first:
#	two-step clumping 500 kB first and 10 MB later
java -Xmx40g -Xms40g -jar /groups/umcg-wijmenga/tmp04/umcg-uvosa/genetic_risk_score_calculator_010/GeneticRiskScoreCalculator-0.1.0-SNAPSHOT/GeneticRiskScoreCalculator.jar \
-gi /groups/umcg-wijmenga/tmp02/projects/umcg-uvosa/Fehrmann_TriTyper/TriTyper/ \
-gt TRITYPER \
-i /groups/umcg-wijmenga/tmp04/umcg-uvosa/curated_GWAS_full_summary_statistics/filtered_SS_files/SS_filtered_freeze/ \
-o /groups/umcg-wijmenga/tmp04/umcg-uvosa/genetic_risk_scores_calculated/Fehrmann_HT12v3_20161002 \
-p 5e-8:1e-5:1e-4:1e-3 \
-r 0.1 \
-w 250000:5000000

