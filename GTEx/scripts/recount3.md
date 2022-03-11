    library(tidyverse)

    ## ── Attaching packages ─────────────────────────────────────── tidyverse 1.3.1 ──

    ## ✓ ggplot2 3.3.5     ✓ purrr   0.3.4
    ## ✓ tibble  3.1.6     ✓ dplyr   1.0.7
    ## ✓ tidyr   1.1.4     ✓ stringr 1.4.0
    ## ✓ readr   2.1.1     ✓ forcats 0.5.1

    ## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
    ## x dplyr::filter() masks stats::filter()
    ## x dplyr::lag()    masks stats::lag()

    library(recount3)

    ## Loading required package: SummarizedExperiment

    ## Loading required package: MatrixGenerics

    ## Loading required package: matrixStats

    ## 
    ## Attaching package: 'matrixStats'

    ## The following object is masked from 'package:dplyr':
    ## 
    ##     count

    ## 
    ## Attaching package: 'MatrixGenerics'

    ## The following objects are masked from 'package:matrixStats':
    ## 
    ##     colAlls, colAnyNAs, colAnys, colAvgsPerRowSet, colCollapse,
    ##     colCounts, colCummaxs, colCummins, colCumprods, colCumsums,
    ##     colDiffs, colIQRDiffs, colIQRs, colLogSumExps, colMadDiffs,
    ##     colMads, colMaxs, colMeans2, colMedians, colMins, colOrderStats,
    ##     colProds, colQuantiles, colRanges, colRanks, colSdDiffs, colSds,
    ##     colSums2, colTabulates, colVarDiffs, colVars, colWeightedMads,
    ##     colWeightedMeans, colWeightedMedians, colWeightedSds,
    ##     colWeightedVars, rowAlls, rowAnyNAs, rowAnys, rowAvgsPerColSet,
    ##     rowCollapse, rowCounts, rowCummaxs, rowCummins, rowCumprods,
    ##     rowCumsums, rowDiffs, rowIQRDiffs, rowIQRs, rowLogSumExps,
    ##     rowMadDiffs, rowMads, rowMaxs, rowMeans2, rowMedians, rowMins,
    ##     rowOrderStats, rowProds, rowQuantiles, rowRanges, rowRanks,
    ##     rowSdDiffs, rowSds, rowSums2, rowTabulates, rowVarDiffs, rowVars,
    ##     rowWeightedMads, rowWeightedMeans, rowWeightedMedians,
    ##     rowWeightedSds, rowWeightedVars

    ## Loading required package: GenomicRanges

    ## Loading required package: stats4

    ## Loading required package: BiocGenerics

    ## Loading required package: parallel

    ## 
    ## Attaching package: 'BiocGenerics'

    ## The following objects are masked from 'package:parallel':
    ## 
    ##     clusterApply, clusterApplyLB, clusterCall, clusterEvalQ,
    ##     clusterExport, clusterMap, parApply, parCapply, parLapply,
    ##     parLapplyLB, parRapply, parSapply, parSapplyLB

    ## The following objects are masked from 'package:dplyr':
    ## 
    ##     combine, intersect, setdiff, union

    ## The following objects are masked from 'package:stats':
    ## 
    ##     IQR, mad, sd, var, xtabs

    ## The following objects are masked from 'package:base':
    ## 
    ##     anyDuplicated, append, as.data.frame, basename, cbind, colnames,
    ##     dirname, do.call, duplicated, eval, evalq, Filter, Find, get, grep,
    ##     grepl, intersect, is.unsorted, lapply, Map, mapply, match, mget,
    ##     order, paste, pmax, pmax.int, pmin, pmin.int, Position, rank,
    ##     rbind, Reduce, rownames, sapply, setdiff, sort, table, tapply,
    ##     union, unique, unsplit, which.max, which.min

    ## Loading required package: S4Vectors

    ## 
    ## Attaching package: 'S4Vectors'

    ## The following objects are masked from 'package:dplyr':
    ## 
    ##     first, rename

    ## The following object is masked from 'package:tidyr':
    ## 
    ##     expand

    ## The following objects are masked from 'package:base':
    ## 
    ##     expand.grid, I, unname

    ## Loading required package: IRanges

    ## 
    ## Attaching package: 'IRanges'

    ## The following objects are masked from 'package:dplyr':
    ## 
    ##     collapse, desc, slice

    ## The following object is masked from 'package:purrr':
    ## 
    ##     reduce

    ## Loading required package: GenomeInfoDb

    ## Loading required package: Biobase

    ## Welcome to Bioconductor
    ## 
    ##     Vignettes contain introductory material; view with
    ##     'browseVignettes()'. To cite Bioconductor, see
    ##     'citation("Biobase")', and for packages 'citation("pkgname")'.

    ## 
    ## Attaching package: 'Biobase'

    ## The following object is masked from 'package:MatrixGenerics':
    ## 
    ##     rowMedians

    ## The following objects are masked from 'package:matrixStats':
    ## 
    ##     anyMissing, rowMedians

    # get GTEx heart data
    human_projects <- available_projects(organism = "human")

    ## 2022-03-11 10:38:06 caching file sra.recount_project.MD.gz.

    ## 2022-03-11 10:38:08 caching file gtex.recount_project.MD.gz.

    ## 2022-03-11 10:38:09 caching file tcga.recount_project.MD.gz.

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

    ## 2022-03-11 10:38:14 downloading and reading the metadata.

    ## 2022-03-11 10:38:15 caching file gtex.gtex.HEART.MD.gz.

    ## 2022-03-11 10:38:17 caching file gtex.recount_project.HEART.MD.gz.

    ## 2022-03-11 10:38:18 caching file gtex.recount_qc.HEART.MD.gz.

    ## 2022-03-11 10:38:20 caching file gtex.recount_seq_qc.HEART.MD.gz.

    ## 2022-03-11 10:38:21 downloading and reading the feature information.

    ## 2022-03-11 10:38:22 caching file human.gene_sums.G026.gtf.gz.

    ## 2022-03-11 10:38:23 downloading and reading the counts: 942 samples across 63856 features.

    ## 2022-03-11 10:38:24 caching file gtex.gene_sums.HEART.G026.gz.

    ## 2022-03-11 10:38:39 construcing the RangedSummarizedExperiment (rse) object.

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

    # format data for DESEq2
    countData <- assays(rse_gtex)$raw_counts %>% as.data.frame()
    colData <- colData(rse_gtex) %>% as.data.frame()

    # check that rows and samples match
    head(rownames(colData) == colnames(countData))

    ## [1] TRUE TRUE TRUE TRUE TRUE TRUE

    # variables
    dim(colData)

    ## [1] 942 198

    dim(countData)

    ## [1] 63856   942

    colData <-  colData %>%
      filter(gtex.run_acc != "NA",
             gtex.smnabtcht != "RNA isolation_PAXgene Tissue miRNA") %>%
      dplyr::select(external_id, study, gtex.run_acc, 
                    gtex.age, gtex.smtsd)
    head(colData)

    ##                                           external_id study gtex.run_acc
    ## GTEX-12ZZX-0726-SM-5EGKA.1 GTEX-12ZZX-0726-SM-5EGKA.1 HEART   SRR1340617
    ## GTEX-13D11-1526-SM-5J2NA.1 GTEX-13D11-1526-SM-5J2NA.1 HEART   SRR1345436
    ## GTEX-ZAJG-0826-SM-5PNVA.1   GTEX-ZAJG-0826-SM-5PNVA.1 HEART   SRR1367456
    ## GTEX-11TT1-1426-SM-5EGIA.1 GTEX-11TT1-1426-SM-5EGIA.1 HEART   SRR1378243
    ## GTEX-13VXT-1126-SM-5LU3A.1 GTEX-13VXT-1126-SM-5LU3A.1 HEART   SRR1381693
    ## GTEX-14ASI-0826-SM-5Q5EB.1 GTEX-14ASI-0826-SM-5Q5EB.1 HEART   SRR1335164
    ##                            gtex.age               gtex.smtsd
    ## GTEX-12ZZX-0726-SM-5EGKA.1    40-49 Heart - Atrial Appendage
    ## GTEX-13D11-1526-SM-5J2NA.1    50-59 Heart - Atrial Appendage
    ## GTEX-ZAJG-0826-SM-5PNVA.1     50-59   Heart - Left Ventricle
    ## GTEX-11TT1-1426-SM-5EGIA.1    20-29 Heart - Atrial Appendage
    ## GTEX-13VXT-1126-SM-5LU3A.1    20-29   Heart - Left Ventricle
    ## GTEX-14ASI-0826-SM-5Q5EB.1    60-69 Heart - Atrial Appendage

    # get countdata for this subset of colData

    ## colData and countData must contain the exact same samples. 
    savecols <- as.character(rownames(colData)) #select the rowsname 
    savecols <- as.vector(savecols) # make it a vector
    countData <- countData %>% dplyr::select(one_of(savecols)) # select just the columns 
     

    # variables
    dim(colData)

    ## [1] 306   5

    dim(countData)

    ## [1] 63856   306

    # check that rows and samples match
    head(rownames(colData) == colnames(countData))

    ## [1] TRUE TRUE TRUE TRUE TRUE TRUE

    names(countData) <- gsub(x = names(countData), pattern = "\\-", replacement = "_")
    rownames(colData) <- gsub(x = rownames(colData) , pattern = "\\-", replacement = "_")


    # check that rows and samples match
    head(rownames(colData) == colnames(countData))

    ## [1] TRUE TRUE TRUE TRUE TRUE TRUE

    head(colData)[1:5]

    ##                                           external_id study gtex.run_acc
    ## GTEX_12ZZX_0726_SM_5EGKA.1 GTEX-12ZZX-0726-SM-5EGKA.1 HEART   SRR1340617
    ## GTEX_13D11_1526_SM_5J2NA.1 GTEX-13D11-1526-SM-5J2NA.1 HEART   SRR1345436
    ## GTEX_ZAJG_0826_SM_5PNVA.1   GTEX-ZAJG-0826-SM-5PNVA.1 HEART   SRR1367456
    ## GTEX_11TT1_1426_SM_5EGIA.1 GTEX-11TT1-1426-SM-5EGIA.1 HEART   SRR1378243
    ## GTEX_13VXT_1126_SM_5LU3A.1 GTEX-13VXT-1126-SM-5LU3A.1 HEART   SRR1381693
    ## GTEX_14ASI_0826_SM_5Q5EB.1 GTEX-14ASI-0826-SM-5Q5EB.1 HEART   SRR1335164
    ##                            gtex.age               gtex.smtsd
    ## GTEX_12ZZX_0726_SM_5EGKA.1    40-49 Heart - Atrial Appendage
    ## GTEX_13D11_1526_SM_5J2NA.1    50-59 Heart - Atrial Appendage
    ## GTEX_ZAJG_0826_SM_5PNVA.1     50-59   Heart - Left Ventricle
    ## GTEX_11TT1_1426_SM_5EGIA.1    20-29 Heart - Atrial Appendage
    ## GTEX_13VXT_1126_SM_5LU3A.1    20-29   Heart - Left Ventricle
    ## GTEX_14ASI_0826_SM_5Q5EB.1    60-69 Heart - Atrial Appendage

    head(countData)[1:5]

    ##                   GTEX_12ZZX_0726_SM_5EGKA.1 GTEX_13D11_1526_SM_5J2NA.1
    ## ENSG00000278704.1                          0                          0
    ## ENSG00000277400.1                          0                          0
    ## ENSG00000274847.1                          0                          0
    ## ENSG00000277428.1                          0                          0
    ## ENSG00000276256.1                          0                          0
    ## ENSG00000278198.1                          0                          0
    ##                   GTEX_ZAJG_0826_SM_5PNVA.1 GTEX_11TT1_1426_SM_5EGIA.1
    ## ENSG00000278704.1                         0                          0
    ## ENSG00000277400.1                         0                          0
    ## ENSG00000274847.1                         0                          0
    ## ENSG00000277428.1                         0                          0
    ## ENSG00000276256.1                         0                          0
    ## ENSG00000278198.1                         0                          0
    ##                   GTEX_13VXT_1126_SM_5LU3A.1
    ## ENSG00000278704.1                          0
    ## ENSG00000277400.1                          0
    ## ENSG00000274847.1                          0
    ## ENSG00000277428.1                          0
    ## ENSG00000276256.1                          0
    ## ENSG00000278198.1                          0

    write.csv(countData, file = paste("../data/countData", params$myproject, "csv", sep = "."),
              row.names = T)
    write.csv(colData, file = paste("../data/colData", params$myproject, "csv", sep = "."),
              row.names = T)
