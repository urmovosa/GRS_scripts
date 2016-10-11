####################################################################################
# This script identifies/removes analytic issues from the summary statistics files #
# and applies genomic control to P-values                                          #
####################################################################################

library(data.table)
library(stringr)
library(ggplot2)
library(gridExtra)

# folder with filtered and GIANT 1000G p1v3 harmonized summary statistic files
# for testing- apply to the subset of clearly problematic SS files
setwd('/groups/umcg-wijmenga/tmp04/umcg-uvosa/curated_GWAS_full_summary_statistics/filtered_SS_files/test_QC_GC/')

# function for making effect vs SE(effect) plots
remove_outliers <- function(x){
  par(mfrow = c(1,2))
  and <- fread(x)
  
  # Set P-values which are on the numerical limit to 1e-323
  and[and$P == 0, ]$P <- 1e-323
  # calculate T-values
  Tvalues <- qchisq(and$P, df = 1, lower.tail = F) 
  # calculate SE for beta or log(OR)
  SE <- (and$Z_OR)/sqrt(Tvalues)
  # write out "volcano" plot and effect vs SE(effect) plot
  
  jpeg(paste('plots/heterogeneity_', x, '.jpeg', sep = ''), height = 6, width = 12, res = 300, unit = 'in')
  par(mfrow = c(1, 2))
  
  plot(and$Z_OR, -log10(and$P), cex = 0.3, xlab = 'beta or log(OR)', ylab = '-log10(P)', main = x)
  plot(abs(and$Z_OR), abs(SE), cex = 0.3, xlab = 'abs(beta or log(OR))', ylab = 'abs(SE(beta or log(OR)))', main = x)
  
  dev.off()
}

# function for applying genomic control correction for P-values
apply_GC <- function(x){
  
  and <- fread(x)
  # Set P-values which are on the numerical limit to 1e-323
  and[and$P == 0, ]$P <- 1e-323
  
  # calculate T-values
  Tvalues <- qchisq(and$P, 1, lower.tail = F)
  # calculate lambda
  GC <- median(Tvalues)/qchisq(0.5, 1, lower.tail = F)
  # calculate GC-adjusted lambda
  p.adj <- pchisq(Tvalues/GC, 1, lower.tail = F)
  and$P.GC <- p.adj
  
  # make a plot comparing original and GC-adjusted P (remove later)
  jpeg(paste('plots/GC_', x, '.jpeg', sep = ''), height = 6, width = 6, res = 300, unit = 'in')
  
  maxP <- max(-log10(and$P), -log10(and$P.GC))
  
  plot(-log10(and$P), -log10(and$P.GC), xlab = '-log10(P)',  ylab = '-log10(GC P)', main = x,
       ylim = c(0, maxP), xlim = c(0, maxP))
  
  dev.off()
 # TODO, if strategy is OK, replace original P with GC-corrected P and write the file out
}

# apply functions to all files in the folder

for (i in list.files()){
  
  remove_outliers(i)
  apply_GC(i)
  
  print(i)
}