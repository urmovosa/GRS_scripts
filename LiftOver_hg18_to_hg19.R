library(rtracklayer)
library(data.table)
library(stringr)

#	hg18 needs LiftOver and removal of NAs (it does not report num of removed SNPs any more in the output of MJ program)
# path needs to be changed to the folder with hg18 SS files

# read in .chain file:
chain <- import.chain('/groups/umcg-wijmenga/tmp04/umcg-uvosa/GWAS_datasets/chain_files/hg18ToHg19.over.chain')

#	write out .log file for SNPs removed during LiftOver:
write.table(NULL, '../log_files/hg18_LiftOver.log', sep = '\t', quote = F, row.names = F)

#	LiftOver
for (i in list.files()[str_detect(list.files(), '.*hg18.txt')]){

dat <- fread(i)
dat <- dat[!is.na(dat$chr), ]

# convert to the GRances:
gr <- GRanges(seqnames = Rle(paste('chr', dat$chr, sep = '')),
ranges = IRanges(start = dat$pos, end = dat$pos),
strand = Rle(strand('*')),
allele1 = dat$allele1,
allele2 = dat$allele2,
effect_allele = dat$effect_allele,
Z_OR = dat$Z_OR,
P = dat$P)

# LiftOver
gr2 <- liftOver(gr, chain)
gr2 <- as.data.frame(unlist(gr2))
gr2$chr <- str_replace(gr2$seqnames, 'chr', '')
output <- data.frame(chr = gr2$chr, position = gr2$start, allele1 = gr2$allele1, allele2 = gr2$allele2, effect_allele = gr2$effect_allele, Z_OR = gr2$Z_OR, P = gr2$P)

#	change the path!!!
write.table(output, paste('/groups/umcg-wijmenga/tmp04/umcg-uvosa/curated_GWAS_full_summary_statistics/filtered_SS_files/hg18_hg19/', str_replace(i, 'hg18', 'hg18_hg19'), sep = ''), sep = '\t', quote = F, row.names = F)

nr_removed <- data.frame(file = i, initiaNrSNPs = nrow(dat), removedLiftOver = nrow(dat) - nrow(output))
write.table(nr_removed, file = '../log_files/hg18_LiftOver.log', sep = '\t', quote = F, row.names = F, append = T, col.names=!file.exists("../log_files/hg18_LiftOver.log"))

print(i)

}
