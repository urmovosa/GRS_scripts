library(data.table)
library(ggplot2)
library(stringr)
library(dplyr)
library(gridExtra)

and1 <- fread('/Users/urmovosa/Documents/move_to_mac/trans_eQTL_meta_analysis/Genetic_risk_scores_GWAS/diagnostic_plots/summarizationLog_hg18.log', na.strings = 'NaN')
and2 <- fread('/Users/urmovosa/Documents/move_to_mac/trans_eQTL_meta_analysis/Genetic_risk_scores_GWAS/diagnostic_plots/summarizationLog_hg19.log', na.strings = 'NaN')
and3 <- fread('/Users/urmovosa/Documents/move_to_mac/trans_eQTL_meta_analysis/Genetic_risk_scores_GWAS/diagnostic_plots/summarizationLog_fixed.log', na.strings = 'NaN')
and_a <- rbind(and1, and2)
and_a <- and_a[!and_a$NameOfFile %in% and3$NameOfFile, ]
and_a <- rbind(and_a, and3)

and_a[is.na(and_a$AvPStatistic), ]$MinPStatistic <- 0
and_a[is.na(and_a$AvPStatistic), ]$MaxPStatistic <- 0
and_a[is.na(and_a$AvPStatistic), ]$AvPStatistic <- 0

and_a[is.na(and_a$AvEffectStatistic), ]$MinEffectStatistic <- 0
and_a[is.na(and_a$AvEffectStatistic), ]$MaxEffectStatistic <- 0
and_a[is.na(and_a$AvEffectStatistic), ]$AvEffectStatistic <- 0

# do diagnostic plots for 100 datasets
grupp <- split(and_a$NameOfFile, ceiling(seq_along(and_a$NameOfFile)/100))

for (j in 1:length(grupp)){
  
  and <- and_a[and_a$NameOfFile %in% as.character(unlist(grupp[j])), ]
  
  and$NameOfFile <- str_replace(and$NameOfFile, '/groups/umcg-wijmenga/tmp04/umcg-uvosa/input_Marc_Jan/output_files//', '')
  and$NameOfFile <- str_replace(and$NameOfFile, '.txt', '')
  
  and <- and %>%
    rowwise() %>%
    mutate(PercentageRemoved = sum(RemovedMissingGiant, RemovedAllelIssues, RemovedInvalidPosition, RemovedInvalidEffect)/TotalInputAssociations, 
           AssociationsRemaining = TotalInputAssociations - sum(RemovedMissingGiant, RemovedAllelIssues, RemovedInvalidPosition, RemovedInvalidEffect))
  
  andBar <- and[, c(1, 3, 4, 5, 6, 14)]
  andBar <- melt(andBar)
  andBar$variable <- factor(andBar$variable, levels = c('AssociationsRemaining', 
                                                        'AvEffectStatistic',
                                                        'RemovedInvalidEffect',
                                                        'RemovedInvalidPosition',
                                                        'RemovedAllelIssues',
                                                        'RemovedMissingGiant'))
  
  
  andBarHelp <- andBar[andBar$variable == 'AssociationsRemaining', ]
  andBarHelp <- andBarHelp[rev(order(andBarHelp$value)), ]
  
  
  andBar <- andBar[order(andBar$variable,andBar$value), ]
  andBar$NameOfFile <- factor(andBar$NameOfFile, levels = as.character(andBarHelp$NameOfFile))
  and$NameOfFile <- factor(and$NameOfFile, levels = as.character(andBarHelp$NameOfFile))
  andBar$value <- as.integer(andBar$value)
  
  p1 <- ggplot(andBar, aes(x = NameOfFile, y = value, fill = variable, order = variable)) + theme_bw() + 
    geom_bar(stat = 'identity') + coord_flip() + scale_fill_brewer(palette = 'Set1') + 
    geom_hline(yintercept = c(1000000, 2000000, 10000000, 15000000), linetype = 2, colour = 'darkgreen') + 
    theme(axis.text.y = element_text(size = 3))
  
  p2 <- ggplot(and, aes(x = NameOfFile, y = PercentageRemoved)) + theme_bw() + 
    geom_bar(stat = 'identity') + coord_flip() + scale_fill_brewer(palette = 'Set1') + 
    theme(axis.text.y = element_text(size = 3))
  
  p3 <- ggplot(and, aes(x = NameOfFile, 
                        y = AvPStatistic, 
                        ymax = MaxPStatistic,
                        ymin = MinPStatistic)) + 
    geom_point() + 
    geom_line(group = 'AvPStatistic', colour = 'grey') + 
    geom_pointrange() + 
    coord_flip() + 
    theme_bw() + 
    theme(axis.text.y = element_text(size = 3))
  
  # p4 <- ggplot(and, aes(x = NameOfFile, 
  #                       y = AvEffectStatistic, 
  #                       ymax = MaxEffectStatistic,
  #                       ymin = MinEffectStatistic)) + 
  #   geom_point() + 
  #   geom_line(group = 'AvEffectStatistic', colour = 'grey') + 
  #   geom_pointrange() + 
  #   coord_flip() + 
  #   theme_bw() + 
  #   theme(axis.text.y = element_text(size = 3))
  # 
  
  and$IssueWithP <- 'no'
  if (nrow(and[and$MinPStatistic == '0', ])){
  and[and$MinPStatistic == '0', ]$IssueWithP <- 'yes'
  and[and$MinPStatistic == '0', ]$MinPStatistic <- 4.940656e-324
  }
  p5 <- ggplot(and, aes(x = NameOfFile, 
                        y = -log10(MinPStatistic), 
                        ymax = -log10(MaxPStatistic),
                        ymin = -log10(MinPStatistic))) + 
    geom_point(data = and, aes(x = NameOfFile, y = -log10(MinPStatistic), colour = IssueWithP)) + 
    geom_line(data = and, aes(x = NameOfFile, y = -log10(MinPStatistic)), group = 'AvPStatistic', linetype = 2) +
    geom_line(data = and, aes(x = NameOfFile, y = -log10(MaxPStatistic)), group = 'AvPStatistic', linetype = 2) +
    geom_line(data = and, aes(x = NameOfFile, y = -log10(AvPStatistic)), group = 'AvPStatistic', colour = 'red') + 
    coord_flip() + 
    theme_bw() + scale_color_manual(values = c('navy', 'red')) + 
    theme(axis.text.y = element_text(size = 3))
  
  # p6 <- ggplot(and, aes(x = NameOfFile,
  #                       y = AvEffectStatistic,
  #                       ymax = MaxEffectStatistic,
  #                       ymin = MinEffectStatistic)) +
  #   geom_point() +
  #   geom_line(group = 'AvEffectStatistic', colour = 'grey') +
  #   geom_pointrange() +
  #   coord_flip() +
  #   theme_bw() + scale_y_continuous(limits = c(-2, 2)) +
  #   theme(axis.text.y = element_text(size = 3))

  p_grid <- grid.arrange(p1, p2, p3, p5, ncol = 2, nrow = 2)
  
  ggsave(p_grid, file = paste('/Users/urmovosa/Documents/move_to_mac/trans_eQTL_meta_analysis/Genetic_risk_scores_GWAS/QC/QC_', j, '.png', sep = ''), height = 15 + 15/3, width = 15)
  
  
  print(paste(j))
}

