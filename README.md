# GRS_scripts
Scripts for processing, QC and analysis of GRS QTL

The folder structure for summary statistics curation is as follows:

```
|---filtered_SS_files
    |---annotation_files
        |---SNP_synonyms_ENSEMBL75.txt.gz
        |---GiantStatistics_Filtered_on_Maf0.001_Indels_AmbigiousSnps.vars.gz
    |---tools
        |---FixSnpNamesGWAS-1.0.4-SNAPSHOT-jar-with-dependencies.jar
    |---scripts
        |---LiftOver_hg18_to_hg19.R
        |---Fix_SNP_names_alleles.sh
        |---script_SNP_enrollment_QC.R
        |---script_effect_sizes_QC.R
    |---log_files
        |---hg18_LiftOver.log
        |---fix_SNPName_hg18.txt
        |---fix_SNPName_hg19.txt
        |---summarizationLog_hg18.log
        |---summarizationLog_hg19.log
    |---QC_reports
        |---QC_graphs_all
        |---QC_graphs_MAF005
        |---SNPenrollment_QC_graphs
    |---hg18
        |---all curated SS files in hg18
    |---hg19_rs
        |---all curated SS files in hg19
        |---all curated SS files with rs number
    |---hg18_hg19
        |---hg18 SS files after LiftOver
    |---hg_to_QC
        |---all SS after GIANT standardization
    |---SS_filtered_freeze
        |---PRS_SS_QC_filtered_[year/month/day].tar.gz
```        