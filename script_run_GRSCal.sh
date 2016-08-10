module load Java

#	in the P-value, lowest P-value first:
#	two-step clumping 500 kB first and 10 MB later
# run on the one line!
java -Xmx40g -Xms40g -jar /groups/umcg-wijmenga/tmp04/umcg-uvosa/genetic_risk_score_calculator_v2/GeneticRiskScoreCalculator-0.0.9-SNAPSHOT/GeneticRiskScoreCalculator.jar -gi /groups/umcg-lld/tmp04/LL-imputed-20140306-TriTyper-1000Gharmonized/LL_TT_1000g/ -gt TRITYPER -i /groups/umcg-wijmenga/tmp04/umcg-uvosa/genetic_risk_scores_calculated/input_files2 -o /groups/umcg-wijmenga/tmp04/umcg-uvosa/genetic_risk_scores_calculated/risk_scores_MJ2 -p 5e-8:1e-5:1e-4:1e-3 -r 0.1 -w 250000:5000000
