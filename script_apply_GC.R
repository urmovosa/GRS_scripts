####################################################################################
# This script applies genomic control to all SS files and writes out gzipped files #
# Apply this to only those files which have full summary statistics data available #
####################################################################################

library(data.table)
library(stringr)

#############################
# function for GC adjustment#
#############################

GC_correction <- function(x, input_path, output_path){
  and <- fread(paste(input_path, x, sep = ''), showProgress = F)
  Tvalues <- qchisq(and$P, 1, lower.tail = F) 
  GC <- median(Tvalues)/qchisq(0.5, 1, lower.tail = F)
  p.adj <- pchisq(Tvalues/GC, 1, lower.tail = F)
  and$P <- p.adj
  
  # possible to add rounding of P-values and effect sizes:
  # and$P <- round(and$P, 10)
  # and$Z_OR <- round(and$Z_OR, 10)
  
  write.table(and, gzfile(paste(output_path, x, '.gz', sep = '')), quote = F, row.names = F, sep = '\t')
}

# paths
input_path <- '/groups/umcg-wijmenga/tmp04/umcg-uvosa/curated_GWAS_full_summary_statistics/filtered_SS_files/hg_to_QC/'
output_path <- '/groups/umcg-wijmenga/tmp04/umcg-uvosa/curated_GWAS_full_summary_statistics/filtered_SS_files/SS_filtered_freeze/'

setwd(input_path)  
  

# process files in loop
setwd('/groups/umcg-wijmenga/tmp04/umcg-uvosa/curated_GWAS_full_summary_statistics/filtered_SS_files/hg_to_QC')

for (i in list.files()[!str_detect(list.files(), '27479909_hg19') & 
                       !str_detect(list.files(), '24514567_hg19')]){ 
  
  GC_correction(i, input_path, output_path)
  print(paste('Finished:', i))
  
}

## process files added later:
input_path <- '/groups/umcg-wijmenga/tmp04/umcg-uvosa/curated_GWAS_full_summary_statistics/filtered_SS_files/hg_to_QC_extra/'
output_path <- '/groups/umcg-wijmenga/tmp04/umcg-uvosa/curated_GWAS_full_summary_statistics/filtered_SS_files/SS_filtered_freeze/'

setwd(input_path)

# process files in loop
setwd('/groups/umcg-wijmenga/tmp04/umcg-uvosa/curated_GWAS_full_summary_statistics/filtered_SS_files/hg_to_QC_extra')

for (i in list.files()[!str_detect(list.files(), '27479909_hg19') & 
                       !str_detect(list.files(), '24514567_hg19')]){ 
  
  GC_correction(i, input_path, output_path)
  print(paste('Finished:', i))
  
}


# USE THIS LAST!!!
# process additional file(s) with uncomplete set of associations:
# these are:
# latest Major Depression GWAS
# Immunochip studies:
# celiac_disease_2011_22057235_hg19.txt   # Not corrected for genomic control but 
# Juvenile_Idiopathic_Arthritis_2013_23603761_hg19.txt
# multiple_sclerosis_2013_24076602_hg19.txt
# Narcolepsy_2013_23459209_hg19.txt
# primary_biliary_cirrhosis_2012_22961000_hg19.txt
# psoriasis_2012_23143594_hg19.txt
# T1D_CC_2015_25751624_hg19.txt
# T1D_meta_2015_25751624_hg19.txt
# Metabochip studies:
# Type_2_Diabetes_metabo_2015_26551672_hg19.txt
# glucose_2h_metabo_2012_22885924_rs.txt
# fasting_glucose_metabo_2012_22885924_rs.txt
# fasting_insuline_metabo_2012_22885924_rs.txt
# fasting_insuline_adj_BMI_metabo_2012_22885924_rs.txt
# HDL_cholesterol_metabo_2013_24097068_hg19.txt
# LDL_cholesterol_metabo_2013_24097068_hg19.txt
# Triglycerides_metabo_2013_24097068_hg19.txt
# Total_cholesterol_metabo_2013_24097068_hg19.txt

## GIANT datasets where it was specified that genomic control was applied
# Body_mass_index_EUR_2015_25673413_rs.txt
# Body_mass_index_ALL_2015_25673413_rs.txt
# Body_mass_index_males_2015_25673413_rs.txt
# Body_mass_index_females_2015_25673413_rs.txt
# Height_2014_25282103_rs.txt
# Hip_circumference_EUR_2015_25673412_rs.txt
# Hip_circumference_ALL_2015_25673412_rs.txt
# Waist_circumference_EUR_2015_25673412_rs.txt
# Waist_circumference_ALL_2015_25673412_rs.txt
# Waist_to_hip_ratio_EUR_2015_25673412_hg18_hg19.txt
# Waist_to_hip_ratio_ALL_2015_25673412_hg18_hg19.txt
# Extreme_waist_to_hip_ratio_2013_23563607_rs.txt
# Extreme_bmi_2013_23563607_rs.txt
# Obesity_class_1_2013_23563607_rs.txt
# Obesity_class_2_2013_23563607_rs.txt
# Obesity_class_3_2013_23563607_rs.txt
# Overweight_2013_23563607_rs.txt
# Extreme_height_2013_23563607_rs.txt

input_path <- '/groups/umcg-wijmenga/tmp04/umcg-uvosa/curated_GWAS_full_summary_statistics/filtered_SS_files/hg_to_QC/'
output_path <- '/groups/umcg-wijmenga/tmp04/umcg-uvosa/curated_GWAS_full_summary_statistics/filtered_SS_files/SS_filtered_freeze/'

setwd(input_path)

files <- c('Major_depression_2016_27479909_hg19.txt',
           'Celiac_disease_2011_22057235_hg19.txt',
           'Juvenile_Idiopathic_Arthritis_2013_23603761_hg19.txt',
           'Multiple_sclerosis_2013_24076602_hg19.txt',
           'Narcolepsy_2013_23459209_hg19.txt',
           'Primary_biliary_cirrhosis_2012_22961000_hg19.txt',
           'Psoriasis_2012_23143594_hg19.txt',
           'T1D_CC_2015_25751624_hg19.txt',
           'T1D_meta_2015_25751624_hg19.txt',
           'Type_2_Diabetes_metabo_2015_26551672_hg19.txt',
           'Glucose_2h_metabo_2012_22885924_rs.txt',
           'Fasting_glucose_metabo_2012_22885924_rs.txt',
           'Fasting_insuline_metabo_2012_22885924_rs.txt',
           'HDL_cholesterol_metabo_2013_24097068_hg19.txt',
           'LDL_cholesterol_metabo_2013_24097068_hg19.txt',
           'Triglycerides_metabo_2013_24097068_hg19.txt',
           'Total_cholesterol_metabo_2013_24097068_hg19.txt',
           'Body_mass_index_EUR_2015_25673413_rs.txt',
           'Body_mass_index_ALL_2015_25673413_rs.txt',
           'Body_mass_index_males_2015_25673413_rs.txt',
           'Body_mass_index_females_2015_25673413_rs.txt',
           'Height_2014_25282103_rs.txt',
           'Hip_circumference_EUR_2015_25673412_rs.txt',
           'Hip_circumference_ALL_2015_25673412_rs.txt',
           'Waist_circumference_EUR_2015_25673412_rs.txt',
           'Waist_circumference_ALL_2015_25673412_rs.txt',
           'Waist_to_hip_ratio_EUR_2015_25673412_hg18_hg19.txt',
           'Waist_to_hip_ratio_ALL_2015_25673412_hg18_hg19.txt',
           'Extreme_waist_to_hip_ratio_2013_23563607_rs.txt',
           'Extreme_bmi_2013_23563607_rs.txt',
           'Obesity_class_1_2013_23563607_rs.txt',
           'Obesity_class_2_2013_23563607_rs.txt',
           'Obesity_class_3_2013_23563607_rs.txt',
           'Overweight_2013_23563607_rs.txt',
           'Extreme_height_2013_23563607_rs.txt')

for (i in files){
  
  and <- fread(i)
  write.table(and, gzfile(paste(output_path, i, '.gz', sep = '')), quote = F, row.names = F, sep = '\t')
  print(paste("Finished:", i))
  
}

