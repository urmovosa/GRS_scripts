library(data.table)
library(stringr)

setwd('/groups/umcg-wijmenga/tmp04/umcg-uvosa/curated_GWAS_full_summary_statistics/filtered_SS_files/hg_to_QC')

# read in summary statistics file to use only chr1 SNPs:

SNPs <- fread('zcat /groups/umcg-wijmenga/tmp04/umcg-uvosa/temp_annotation_files/GiantStatistics_Filtered_on_Maf0.001_Indels_AmbigiousSnps.vars.gz')
SNPs <- SNPs[SNPs$CHR == 1, ]

MAF_filter <- fread('/groups/umcg-wijmenga/tmp02/projects/umcg-uvosa/GIANT_vcf_EUR/filtered_005/GIANT_1000Gp1v3_CEU_MAF_filter_005.txt')
MAF_filter <- as.character(MAF_filter$MarkerName)

grupp <- split(list.files(pattern = '.txt'), ceiling(seq_along(list.files(pattern = '.txt'))/100))

##  with filter of P<0.01

for (j in 1:length(grupp)){
  jpeg(paste('/groups/umcg-wijmenga/tmp04/umcg-uvosa/curated_GWAS_full_summary_statistics/filtered_SS_files/QC_reports/QC_graphs_P001/', j, '_P001.jpeg', sep = ''), width = 20, height = 20, res = 400, unit = 'in')
  par(mfrow = c(10, 10))
  for (i in as.character(unlist(grupp[j]))) {
    
    and <- fread(i)
    and <- and[and$rs %in% SNPs$ID, ]
    #and <- and[and$rs %in% MAF_filter, ] #  add MAF filter to see if this improves the QC graphs
    and <- and[and$P < 0.01, ] # add P-value filter to remove strange OR/beta datapoints
    trait <- str_replace(i, '_rs.txt', '')
    trait <- str_replace(trait, '_hg19.txt', '')
    if (nrow(and) > 0){
      plot(and$Z_OR, -log10(and$P), xlab = 'Effect size', ylab = '-log10(P)', main = trait, cex.main = 0.4, cex = 0.2)
    } else {
      
      plot(NA, ylim = c(0, 1), xlim = c(0, 1), xlab = 'Effect size', ylab = '-log10(P)', main = trait, cex.main = 0.4, cex = 0.2)
      text(0.5, 0.5, labels = 'All SNPs removed', cex = 0.5) 
    }
    
    print(paste(j, i))
  }
  
  dev.off()
  
}

# all in

for (j in 1:length(grupp)){
  jpeg(paste('/groups/umcg-wijmenga/tmp04/umcg-uvosa/curated_GWAS_full_summary_statistics/filtered_SS_files/QC_reports/QC_graphs_all/', j, '_all.jpeg', sep = ''), width = 20, height = 20, res = 400, unit = 'in')
  par(mfrow = c(10, 10))
  for (i in as.character(unlist(grupp[j]))) {
    
    and <- fread(i)
    and <- and[and$rs %in% SNPs$ID, ]
    #and <- and[and$P < 0.1, ] # add P-value filter to remove strange OR/beta datapoints
    trait <- str_replace(i, '_rs.txt', '')
    trait <- str_replace(trait, '_hg19.txt', '')
    if (nrow(and) > 0){
      plot(and$Z_OR, -log10(and$P), xlab = 'Effect size', ylab = '-log10(P)', main = trait, cex.main = 0.4, cex = 0.2)
    } else {
      
      plot(NA, ylim = c(0, 1), xlim = c(0, 1), xlab = 'Effect size', ylab = '-log10(P)', main = trait, cex.main = 0.4, cex = 0.2)
      text(0.5, 0.5, labels = 'All SNPs removed', cex = 0.5) 
    }
    

    print(paste(j, i))
  }
  
  dev.off()
  
}

# MAF>0.05

for (j in 1:length(grupp)){
  jpeg(paste('/groups/umcg-wijmenga/tmp04/umcg-uvosa/curated_GWAS_full_summary_statistics/filtered_SS_files/QC_reports/QC_graphs_MAF005/', j, '_MAF005.jpeg', sep = ''), width = 20, height = 20, res = 400, unit = 'in')
  par(mfrow = c(10, 10))
  for (i in as.character(unlist(grupp[j]))) {
    
    and <- fread(i)
    and <- and[and$rs %in% SNPs$ID, ]
    and <- and[and$rs %in% MAF_filter, ] #  add MAF filter to see if this improves the QC graphs
    #and <- and[and$P < 0.1, ] # add P-value filter to remove strange OR/beta datapoints
    trait <- str_replace(i, '_rs.txt', '')
    trait <- str_replace(trait, '_hg19.txt', '')
    if (nrow(and) > 0){
      plot(and$Z_OR, -log10(and$P), xlab = 'Effect size', ylab = '-log10(P)', main = trait, cex.main = 0.4, cex = 0.2)
    } else {
      
      plot(NA, ylim = c(0, 1), xlim = c(0, 1), xlab = 'Effect size', ylab = '-log10(P)', main = trait, cex.main = 0.4, cex = 0.2)
      text(0.5, 0.5, labels = 'All SNPs removed', cex = 0.5) 
    }
    
    print(paste(j, i))
  }
  
  dev.off()
  
}


