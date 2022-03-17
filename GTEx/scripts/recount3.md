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

    library(lubridate)

    ## 
    ## Attaching package: 'lubridate'

    ## The following objects are masked from 'package:GenomicRanges':
    ## 
    ##     intersect, setdiff, union

    ## The following object is masked from 'package:GenomeInfoDb':
    ## 
    ##     intersect

    ## The following objects are masked from 'package:IRanges':
    ## 
    ##     %within%, intersect, setdiff, union

    ## The following objects are masked from 'package:S4Vectors':
    ## 
    ##     intersect, second, second<-, setdiff, union

    ## The following objects are masked from 'package:BiocGenerics':
    ## 
    ##     intersect, setdiff, union

    ## The following objects are masked from 'package:base':
    ## 
    ##     date, intersect, setdiff, union

    # get GTEx heart data
    human_projects <- available_projects(organism = "human")

    ## 2022-03-17 13:30:43 caching file sra.recount_project.MD.gz.

    ## 2022-03-17 13:30:44 caching file gtex.recount_project.MD.gz.

    ## 2022-03-17 13:30:46 caching file tcga.recount_project.MD.gz.

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
    ## 8679  MUSCLE    human        gtex data_sources/gtex data_sources       881

    rse_gtex <- create_rse(gtex)

    ## 2022-03-17 13:30:52 downloading and reading the metadata.

    ## 2022-03-17 13:30:53 caching file gtex.gtex.MUSCLE.MD.gz.

    ## 2022-03-17 13:30:54 caching file gtex.recount_project.MUSCLE.MD.gz.

    ## 2022-03-17 13:30:55 caching file gtex.recount_qc.MUSCLE.MD.gz.

    ## 2022-03-17 13:30:56 caching file gtex.recount_seq_qc.MUSCLE.MD.gz.

    ## 2022-03-17 13:30:58 downloading and reading the feature information.

    ## 2022-03-17 13:30:59 caching file human.gene_sums.G026.gtf.gz.

    ## 2022-03-17 13:31:00 downloading and reading the counts: 881 samples across 63856 features.

    ## 2022-03-17 13:31:01 caching file gtex.gene_sums.MUSCLE.G026.gz.

    ## 2022-03-17 13:31:12 construcing the RangedSummarizedExperiment (rse) object.

    rse_gtex

    ## class: RangedSummarizedExperiment 
    ## dim: 63856 881 
    ## metadata(8): time_created recount3_version ... annotation recount3_url
    ## assays(1): raw_counts
    ## rownames(63856): ENSG00000278704.1 ENSG00000277400.1 ...
    ##   ENSG00000182484.15_PAR_Y ENSG00000227159.8_PAR_Y
    ## rowData names(10): source type ... havana_gene tag
    ## colnames(881): GTEX-WK11-2526-SM-3NM9Y.1 GTEX-POMQ-1926-SM-3NB1Y.1 ...
    ##   GTEX-1LG7Y-0126-SM-E6CJ8.1 GTEX-1LSNM-2326-SM-EWRO8.1
    ## colData names(198): rail_id external_id ... recount_seq_qc.errq
    ##   BigWigURL

    # format data for DESEq2


    colData <- colData(rse_gtex) %>% 
      as.data.frame()  %>%
      filter(gtex.run_acc != "NA",
             gtex.smnabtcht != "RNA isolation_PAXgene Tissue miRNA") %>%
      dplyr::select(external_id, gtex.smtsd,
                    study, gtex.smts, 
                    gtex.subjid, gtex.sampid, gtex.run_acc,  
                    gtex.sex, gtex.age,  gtex.dthhrdy,
                    gtex.smrin, gtex.smcenter, gtex.smpthnts, gtex.smnabtchd,
                    recount_qc.aligned_reads..chrm,
                    recount_qc.aligned_reads..chrx,
                    recount_qc.aligned_reads..chry,
                    recount_qc.bc_auc.all_reads_all_bases) %>% 
      mutate(Date = mdy(gtex.smnabtchd))
    head(colData)

    ##                                           external_id        gtex.smtsd  study
    ## GTEX-YEC3-2126-SM-4YCDB.1   GTEX-YEC3-2126-SM-4YCDB.1 Muscle - Skeletal MUSCLE
    ## GTEX-1128S-2426-SM-5H11B.1 GTEX-1128S-2426-SM-5H11B.1 Muscle - Skeletal MUSCLE
    ## GTEX-14BIM-0326-SM-5SI9B.1 GTEX-14BIM-0326-SM-5SI9B.1 Muscle - Skeletal MUSCLE
    ## GTEX-1445S-0626-SM-5LU3C.1 GTEX-1445S-0626-SM-5LU3C.1 Muscle - Skeletal MUSCLE
    ## GTEX-11EQ8-0526-SM-5N9BC.1 GTEX-11EQ8-0526-SM-5N9BC.1 Muscle - Skeletal MUSCLE
    ## GTEX-144GM-2026-SM-5LU3D.1 GTEX-144GM-2026-SM-5LU3D.1 Muscle - Skeletal MUSCLE
    ##                            gtex.smts gtex.subjid              gtex.sampid
    ## GTEX-YEC3-2126-SM-4YCDB.1     Muscle   GTEX-YEC3  GTEX-YEC3-2126-SM-4YCDB
    ## GTEX-1128S-2426-SM-5H11B.1    Muscle  GTEX-1128S GTEX-1128S-2426-SM-5H11B
    ## GTEX-14BIM-0326-SM-5SI9B.1    Muscle  GTEX-14BIM GTEX-14BIM-0326-SM-5SI9B
    ## GTEX-1445S-0626-SM-5LU3C.1    Muscle  GTEX-1445S GTEX-1445S-0626-SM-5LU3C
    ## GTEX-11EQ8-0526-SM-5N9BC.1    Muscle  GTEX-11EQ8 GTEX-11EQ8-0526-SM-5N9BC
    ## GTEX-144GM-2026-SM-5LU3D.1    Muscle  GTEX-144GM GTEX-144GM-2026-SM-5LU3D
    ##                            gtex.run_acc gtex.sex gtex.age gtex.dthhrdy
    ## GTEX-YEC3-2126-SM-4YCDB.1    SRR1338560        1    50-59            0
    ## GTEX-1128S-2426-SM-5H11B.1   SRR1339108        2    60-69            2
    ## GTEX-14BIM-0326-SM-5SI9B.1   SRR1384371        2    60-69            3
    ## GTEX-1445S-0626-SM-5LU3C.1   SRR1348040        1    60-69            3
    ## GTEX-11EQ8-0526-SM-5N9BC.1   SRR1355217        1    60-69            4
    ## GTEX-144GM-2026-SM-5LU3D.1   SRR1367988        1    20-29            0
    ##                            gtex.smrin gtex.smcenter
    ## GTEX-YEC3-2126-SM-4YCDB.1         8.6            B1
    ## GTEX-1128S-2426-SM-5H11B.1        7.6            B1
    ## GTEX-14BIM-0326-SM-5SI9B.1        7.9            B1
    ## GTEX-1445S-0626-SM-5LU3C.1        7.9            B1
    ## GTEX-11EQ8-0526-SM-5N9BC.1        7.6            C1
    ## GTEX-144GM-2026-SM-5LU3D.1        7.4            B1
    ##                                                                                                    gtex.smpthnts
    ## GTEX-YEC3-2126-SM-4YCDB.1                                2 pieces, 11x8 and 9x8mm; less than 2% interstitial fat
    ## GTEX-1128S-2426-SM-5H11B.1                              2 pieces  ~10% adherent/interstitial fat, rep delineated
    ## GTEX-14BIM-0326-SM-5SI9B.1      6 pieces, some fibers appear mildly atrophied.  Minimal interstitial fat, ~5-10%
    ## GTEX-1445S-0626-SM-5LU3C.1                                  2 pieces, interstitial fat up to ~10% rep delineated
    ## GTEX-11EQ8-0526-SM-5N9BC.1 2 pieces, 5% internal fat, one piece has attachment of 10% additional fat and vessels
    ## GTEX-144GM-2026-SM-5LU3D.1                                                      2 pieces, trace interstitial fat
    ##                            gtex.smnabtchd recount_qc.aligned_reads..chrm
    ## GTEX-YEC3-2126-SM-4YCDB.1      09/05/2013                          26.83
    ## GTEX-1128S-2426-SM-5H11B.1     09/19/2013                          25.31
    ## GTEX-14BIM-0326-SM-5SI9B.1     12/19/2013                          12.26
    ## GTEX-1445S-0626-SM-5LU3C.1     12/18/2013                           9.52
    ## GTEX-11EQ8-0526-SM-5N9BC.1     09/26/2013                          15.78
    ## GTEX-144GM-2026-SM-5LU3D.1     12/18/2013                          24.01
    ##                            recount_qc.aligned_reads..chrx
    ## GTEX-YEC3-2126-SM-4YCDB.1                            1.62
    ## GTEX-1128S-2426-SM-5H11B.1                           1.65
    ## GTEX-14BIM-0326-SM-5SI9B.1                           2.12
    ## GTEX-1445S-0626-SM-5LU3C.1                           1.94
    ## GTEX-11EQ8-0526-SM-5N9BC.1                           1.83
    ## GTEX-144GM-2026-SM-5LU3D.1                           1.45
    ##                            recount_qc.aligned_reads..chry
    ## GTEX-YEC3-2126-SM-4YCDB.1                            0.04
    ## GTEX-1128S-2426-SM-5H11B.1                           0.01
    ## GTEX-14BIM-0326-SM-5SI9B.1                           0.01
    ## GTEX-1445S-0626-SM-5LU3C.1                           0.05
    ## GTEX-11EQ8-0526-SM-5N9BC.1                           0.06
    ## GTEX-144GM-2026-SM-5LU3D.1                           0.05
    ##                            recount_qc.bc_auc.all_reads_all_bases       Date
    ## GTEX-YEC3-2126-SM-4YCDB.1                             8161973645 2013-09-05
    ## GTEX-1128S-2426-SM-5H11B.1                            7154208721 2013-09-19
    ## GTEX-14BIM-0326-SM-5SI9B.1                            7112504184 2013-12-19
    ## GTEX-1445S-0626-SM-5LU3C.1                            5239062292 2013-12-18
    ## GTEX-11EQ8-0526-SM-5N9BC.1                            6188125545 2013-09-26
    ## GTEX-144GM-2026-SM-5LU3D.1                            6510644429 2013-12-18

    names(colData)

    ##  [1] "external_id"                          
    ##  [2] "gtex.smtsd"                           
    ##  [3] "study"                                
    ##  [4] "gtex.smts"                            
    ##  [5] "gtex.subjid"                          
    ##  [6] "gtex.sampid"                          
    ##  [7] "gtex.run_acc"                         
    ##  [8] "gtex.sex"                             
    ##  [9] "gtex.age"                             
    ## [10] "gtex.dthhrdy"                         
    ## [11] "gtex.smrin"                           
    ## [12] "gtex.smcenter"                        
    ## [13] "gtex.smpthnts"                        
    ## [14] "gtex.smnabtchd"                       
    ## [15] "recount_qc.aligned_reads..chrm"       
    ## [16] "recount_qc.aligned_reads..chrx"       
    ## [17] "recount_qc.aligned_reads..chry"       
    ## [18] "recount_qc.bc_auc.all_reads_all_bases"
    ## [19] "Date"

    # get countdata for this subset of colData



    ## colData and countData must contain the exact same samples. 
    savecols <- as.character(rownames(colData)) #select the rowsname 
    savecols <- as.vector(savecols) # make it a vector

    countData <- assays(rse_gtex)$raw_counts %>% 
      as.data.frame() %>% 
      dplyr::select(one_of(savecols)) # select just the columns 
     

    # variables
    dim(colData)

    ## [1] 275  19

    dim(countData)

    ## [1] 63856   275

    # check that rows and samples match
    head(rownames(colData) == colnames(countData))

    ## [1] TRUE TRUE TRUE TRUE TRUE TRUE

    head(colData)[1:5]

    ##                                           external_id        gtex.smtsd  study
    ## GTEX-YEC3-2126-SM-4YCDB.1   GTEX-YEC3-2126-SM-4YCDB.1 Muscle - Skeletal MUSCLE
    ## GTEX-1128S-2426-SM-5H11B.1 GTEX-1128S-2426-SM-5H11B.1 Muscle - Skeletal MUSCLE
    ## GTEX-14BIM-0326-SM-5SI9B.1 GTEX-14BIM-0326-SM-5SI9B.1 Muscle - Skeletal MUSCLE
    ## GTEX-1445S-0626-SM-5LU3C.1 GTEX-1445S-0626-SM-5LU3C.1 Muscle - Skeletal MUSCLE
    ## GTEX-11EQ8-0526-SM-5N9BC.1 GTEX-11EQ8-0526-SM-5N9BC.1 Muscle - Skeletal MUSCLE
    ## GTEX-144GM-2026-SM-5LU3D.1 GTEX-144GM-2026-SM-5LU3D.1 Muscle - Skeletal MUSCLE
    ##                            gtex.smts gtex.subjid
    ## GTEX-YEC3-2126-SM-4YCDB.1     Muscle   GTEX-YEC3
    ## GTEX-1128S-2426-SM-5H11B.1    Muscle  GTEX-1128S
    ## GTEX-14BIM-0326-SM-5SI9B.1    Muscle  GTEX-14BIM
    ## GTEX-1445S-0626-SM-5LU3C.1    Muscle  GTEX-1445S
    ## GTEX-11EQ8-0526-SM-5N9BC.1    Muscle  GTEX-11EQ8
    ## GTEX-144GM-2026-SM-5LU3D.1    Muscle  GTEX-144GM

    head(countData)[1:5]

    ##                   GTEX-YEC3-2126-SM-4YCDB.1 GTEX-1128S-2426-SM-5H11B.1
    ## ENSG00000278704.1                         0                          0
    ## ENSG00000277400.1                         0                          0
    ## ENSG00000274847.1                         0                          0
    ## ENSG00000277428.1                         0                          0
    ## ENSG00000276256.1                         0                          0
    ## ENSG00000278198.1                         0                          0
    ##                   GTEX-14BIM-0326-SM-5SI9B.1 GTEX-1445S-0626-SM-5LU3C.1
    ## ENSG00000278704.1                          0                          0
    ## ENSG00000277400.1                          0                          0
    ## ENSG00000274847.1                          0                          0
    ## ENSG00000277428.1                          0                          0
    ## ENSG00000276256.1                          0                          0
    ## ENSG00000278198.1                          0                          0
    ##                   GTEX-11EQ8-0526-SM-5N9BC.1
    ## ENSG00000278704.1                          0
    ## ENSG00000277400.1                          0
    ## ENSG00000274847.1                          0
    ## ENSG00000277428.1                          0
    ## ENSG00000276256.1                          0
    ## ENSG00000278198.1                          0

    # save files for later use
    write.csv(countData, file = paste("../data/countData", params$myproject, "csv", sep = "."),
                  row.names = T)
    write.csv(colData, file = paste("../data/colData", params$myproject, "csv", sep = "."),
                  row.names = T)
