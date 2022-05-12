This script is used to generate the files that are in the data
directory. Reset the params to download and process files from different
tissues.

If you need to install recount 3, run the following chunk

    ## Install tidyverse and lubridate

    install.packages("tidyverse")
    install.packages("lubridate")

    ## Install the recount3 R/Bioconductor package
    if (!requireNamespace("BiocManager", quietly = TRUE))
        install.packages("BiocManager")
    BiocManager::install("recount3")

Download data using recount3

    library(tidyverse)
    library(recount3)
    library(lubridate)

    # get GTEx heart data
    human_projects <- available_projects(organism = "human")

    # enter yes

    head(human_projects)

    ##     project organism file_source     project_home project_type n_samples
    ## 1 SRP107565    human         sra data_sources/sra data_sources       216
    ## 2 SRP149665    human         sra data_sources/sra data_sources         4
    ## 3 SRP017465    human         sra data_sources/sra data_sources        23
    ## 4 SRP119165    human         sra data_sources/sra data_sources         6
    ## 5 SRP133965    human         sra data_sources/sra data_sources        12
    ## 6 SRP096765    human         sra data_sources/sra data_sources         7

    tail(human_projects)

    ##      project organism file_source      project_home project_type n_samples
    ## 8737    TGCT    human        tcga data_sources/tcga data_sources       156
    ## 8738    THCA    human        tcga data_sources/tcga data_sources       572
    ## 8739    THYM    human        tcga data_sources/tcga data_sources       122
    ## 8740    UCEC    human        tcga data_sources/tcga data_sources       589
    ## 8741     UCS    human        tcga data_sources/tcga data_sources        57
    ## 8742     UVM    human        tcga data_sources/tcga data_sources        80

    gtex <- subset(human_projects,
                         project == params$myproject  & 
                           file_source == "gtex" & 
                           project_type == "data_sources" )

    head(gtex)

    ##      project organism file_source      project_home project_type n_samples
    ## 8681   HEART    human        gtex data_sources/gtex data_sources       942

    rse_gtex <- create_rse(gtex)
    rse_gtex

    ## class: RangedSummarizedExperiment 
    ## dim: 63856 942 
    ## metadata(8): time_created recount3_version ... annotation recount3_url
    ## assays(1): raw_counts
    ## rownames(63856): ENSG00000278704.1 ENSG00000277400.1 ...
    ##   ENSG00000182484.15_PAR_Y ENSG00000227159.8_PAR_Y
    ## rowData names(10): source type ... havana_gene tag
    ## colnames(942): GTEX-X261-0926-SM-3NMCY.1 GTEX-X4XX-1126-SM-3NMBY.1 ...
    ##   GTEX-1L5NE-0426-SM-E9TIX.1 GTEX-1NV8Z-1526-SM-DTX8X.1
    ## colData names(198): rail_id external_id ... recount_seq_qc.errq
    ##   BigWigURL

Generate files that describe the biosamples and provide the counts for
each biosample. These are called colData and countData based on typical
naming used by
[DESeq2](https://bioconductor.org/packages/release/bioc/vignettes/DESeq2/inst/doc/DESeq2.html).

First, the colData.

    colData <- colData(rse_gtex) %>% 
      as.data.frame()  %>%
      filter(gtex.run_acc != "NA",
             gtex.smnabtcht != "RNA isolation_PAXgene Tissue miRNA") %>%
      dplyr::select(external_id, gtex.smtsd,
                    study, gtex.smts, 
                    gtex.subjid, gtex.run_acc,  
                    gtex.sex, gtex.age,  gtex.dthhrdy,
                    gtex.smrin, gtex.smcenter, gtex.smpthnts, gtex.smnabtchd,
                    recount_qc.aligned_reads..chrm,
                    recount_qc.aligned_reads..chrx,
                    recount_qc.aligned_reads..chry,
                    recount_qc.bc_auc.all_reads_all_bases) %>% 
      mutate(DATE = mdy(gtex.smnabtchd)) %>%
      dplyr::rename(SAMPID = external_id,
                    SMTS = gtex.smts,
                    SUBJID = gtex.subjid,
                    SMTSD = gtex.smtsd,
                    SEX = gtex.sex,
                    AGE = gtex.age,
                    SRA = gtex.run_acc,
                    SMRIN = gtex.smrin,
                    SMCENTER = gtex.smcenter) %>%
      mutate(DTHHRDY = factor(gtex.dthhrdy),
             SEX = factor(SEX),
             SEX = fct_recode(SEX, "Male" = "1", "Female" = "2"),
             SEX = factor(SEX, levels = c("Female" , "Male")),
        DTHHRDY = fct_recode(DTHHRDY, "Ventilator Case" = "0",
                                           "Violent and fast death" = "1",
                                           "Fast death of natural causes" = "2",
                                           "Intermediate death" = "3",
                                           "Slow death" = "4")) %>%
      select(SAMPID, SMTS, SMTSD, SUBJID, SEX, AGE, SMRIN, DTHHRDY, SRA, DATE)

    row.names(colData) <- colData$SAMPID
    head(colData)

    ##                                                SAMPID  SMTS
    ## GTEX-12ZZX-0726-SM-5EGKA.1 GTEX-12ZZX-0726-SM-5EGKA.1 Heart
    ## GTEX-13D11-1526-SM-5J2NA.1 GTEX-13D11-1526-SM-5J2NA.1 Heart
    ## GTEX-ZAJG-0826-SM-5PNVA.1   GTEX-ZAJG-0826-SM-5PNVA.1 Heart
    ## GTEX-11TT1-1426-SM-5EGIA.1 GTEX-11TT1-1426-SM-5EGIA.1 Heart
    ## GTEX-13VXT-1126-SM-5LU3A.1 GTEX-13VXT-1126-SM-5LU3A.1 Heart
    ## GTEX-14ASI-0826-SM-5Q5EB.1 GTEX-14ASI-0826-SM-5Q5EB.1 Heart
    ##                                               SMTSD     SUBJID    SEX   AGE
    ## GTEX-12ZZX-0726-SM-5EGKA.1 Heart - Atrial Appendage GTEX-12ZZX Female 40-49
    ## GTEX-13D11-1526-SM-5J2NA.1 Heart - Atrial Appendage GTEX-13D11 Female 50-59
    ## GTEX-ZAJG-0826-SM-5PNVA.1    Heart - Left Ventricle  GTEX-ZAJG Female 50-59
    ## GTEX-11TT1-1426-SM-5EGIA.1 Heart - Atrial Appendage GTEX-11TT1   Male 20-29
    ## GTEX-13VXT-1126-SM-5LU3A.1   Heart - Left Ventricle GTEX-13VXT Female 20-29
    ## GTEX-14ASI-0826-SM-5Q5EB.1 Heart - Atrial Appendage GTEX-14ASI   Male 60-69
    ##                            SMRIN                      DTHHRDY        SRA
    ## GTEX-12ZZX-0726-SM-5EGKA.1   7.1       Violent and fast death SRR1340617
    ## GTEX-13D11-1526-SM-5J2NA.1   8.9              Ventilator Case SRR1345436
    ## GTEX-ZAJG-0826-SM-5PNVA.1    6.4           Intermediate death SRR1367456
    ## GTEX-11TT1-1426-SM-5EGIA.1   9.0              Ventilator Case SRR1378243
    ## GTEX-13VXT-1126-SM-5LU3A.1   8.6              Ventilator Case SRR1381693
    ## GTEX-14ASI-0826-SM-5Q5EB.1   6.4 Fast death of natural causes SRR1335164
    ##                                  DATE
    ## GTEX-12ZZX-0726-SM-5EGKA.1 2013-10-22
    ## GTEX-13D11-1526-SM-5J2NA.1 2013-12-04
    ## GTEX-ZAJG-0826-SM-5PNVA.1  2013-10-31
    ## GTEX-11TT1-1426-SM-5EGIA.1 2013-10-24
    ## GTEX-13VXT-1126-SM-5LU3A.1 2013-12-17
    ## GTEX-14ASI-0826-SM-5Q5EB.1 2014-01-17

Now the counts

    ## colData and countData must contain the exact same samples. 
    savecols <- as.character(rownames(colData)) #select the rowsname 
    savecols <- as.vector(savecols) # make it a vector

    countData <- assays(rse_gtex)$raw_counts %>% 
      as.data.frame() %>% 
      dplyr::select(one_of(savecols)) %>% # select just the columns 
      mutate(id_version = row.names(.)) %>%
      filter(!grepl("PAR", id_version)) %>%
      separate(id_version, into = c("id"), sep = "\\.", remove = T, extra = "drop")

    row.names(countData) <- countData$id
    countData$id <- NULL
     
    head(countData)[1:5]

    ##                 GTEX-12ZZX-0726-SM-5EGKA.1 GTEX-13D11-1526-SM-5J2NA.1
    ## ENSG00000278704                          0                          0
    ## ENSG00000277400                          0                          0
    ## ENSG00000274847                          0                          0
    ## ENSG00000277428                          0                          0
    ## ENSG00000276256                          0                          0
    ## ENSG00000278198                          0                          0
    ##                 GTEX-ZAJG-0826-SM-5PNVA.1 GTEX-11TT1-1426-SM-5EGIA.1
    ## ENSG00000278704                         0                          0
    ## ENSG00000277400                         0                          0
    ## ENSG00000274847                         0                          0
    ## ENSG00000277428                         0                          0
    ## ENSG00000276256                         0                          0
    ## ENSG00000278198                         0                          0
    ##                 GTEX-13VXT-1126-SM-5LU3A.1
    ## ENSG00000278704                          0
    ## ENSG00000277400                          0
    ## ENSG00000274847                          0
    ## ENSG00000277428                          0
    ## ENSG00000276256                          0
    ## ENSG00000278198                          0

    head(colData)[1:5]

    ##                                                SAMPID  SMTS
    ## GTEX-12ZZX-0726-SM-5EGKA.1 GTEX-12ZZX-0726-SM-5EGKA.1 Heart
    ## GTEX-13D11-1526-SM-5J2NA.1 GTEX-13D11-1526-SM-5J2NA.1 Heart
    ## GTEX-ZAJG-0826-SM-5PNVA.1   GTEX-ZAJG-0826-SM-5PNVA.1 Heart
    ## GTEX-11TT1-1426-SM-5EGIA.1 GTEX-11TT1-1426-SM-5EGIA.1 Heart
    ## GTEX-13VXT-1126-SM-5LU3A.1 GTEX-13VXT-1126-SM-5LU3A.1 Heart
    ## GTEX-14ASI-0826-SM-5Q5EB.1 GTEX-14ASI-0826-SM-5Q5EB.1 Heart
    ##                                               SMTSD     SUBJID    SEX
    ## GTEX-12ZZX-0726-SM-5EGKA.1 Heart - Atrial Appendage GTEX-12ZZX Female
    ## GTEX-13D11-1526-SM-5J2NA.1 Heart - Atrial Appendage GTEX-13D11 Female
    ## GTEX-ZAJG-0826-SM-5PNVA.1    Heart - Left Ventricle  GTEX-ZAJG Female
    ## GTEX-11TT1-1426-SM-5EGIA.1 Heart - Atrial Appendage GTEX-11TT1   Male
    ## GTEX-13VXT-1126-SM-5LU3A.1   Heart - Left Ventricle GTEX-13VXT Female
    ## GTEX-14ASI-0826-SM-5Q5EB.1 Heart - Atrial Appendage GTEX-14ASI   Male

    # variables
    dim(colData)

    ## [1] 306  10

    dim(countData)

    ## [1] 63811   306

    # check that rows and samples match
    head(rownames(colData) == colnames(countData))

    ## [1] TRUE TRUE TRUE TRUE TRUE TRUE

Save the col and count data files

    # save files for later use
    write.csv(countData, file = paste("../data/countData", params$myproject, "csv", sep = "."),
                  row.names = T)
    write.csv(colData, file = paste("../data/colData", params$myproject, "csv", sep = "."),
                  row.names = T)

Afterwards, gzip the large csv files using the following
