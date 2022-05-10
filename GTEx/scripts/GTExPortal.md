Get data from GTEx portal <https://gtexportal.org/home/>

    curl -o samples.txt https://storage.googleapis.com/gtex_analysis_v8/annotations/GTEx_Analysis_v8_Annotations_SampleAttributesDS.txt
    curl -o subjects.txt https://storage.googleapis.com/gtex_analysis_v8/annotations/GTEx_Analysis_v8_Annotations_SubjectPhenotypesDS.txt

    library(forcats)
    library(tidyr)

    ## Warning: package 'tidyr' was built under R version 4.1.2

    library(dplyr)

    ## Warning: package 'dplyr' was built under R version 4.1.2

    library(ggplot2)
    library(lubridate)

    subjects <- read.table("../data/subjects.txt", header = T, sep = "\t") %>%
      mutate_if(is.integer, as.factor) %>%
      mutate(SEX = fct_recode(SEX, "Male" = "1", "Female" = "2"),
             SEX = factor(SEX, levels = c("Female" , "Male")),
             DTHHRDY = fct_recode(DTHHRDY, "Ventilator Case" = "0",
                                           "Violent and fast death" = "1",
                                           "Fast death of natural causes" = "2",
                                           "Intermediate death" = "3",
                                           "Slow death" = "4"))

    head(subjects)

    ##       SUBJID    SEX   AGE                DTHHRDY
    ## 1 GTEX-1117F Female 60-69             Slow death
    ## 2 GTEX-111CU   Male 50-59        Ventilator Case
    ## 3 GTEX-111FC   Male 60-69 Violent and fast death
    ## 4 GTEX-111VG   Male 60-69     Intermediate death
    ## 5 GTEX-111YS   Male 60-69        Ventilator Case
    ## 6 GTEX-1122O Female 60-69        Ventilator Case

    samples <- read.table("../data/samples.txt", header = T, sep = "\t") 

    ## Warning in scan(file = file, what = what, sep = sep, quote = quote, dec = dec, :
    ## EOF within quoted string

    ## Warning in scan(file = file, what = what, sep = sep, quote = quote, dec = dec, :
    ## number of items read is not a multiple of the number of columns

    head(samples)

    ##                          SAMPID SMATSSCR SMCENTER
    ## 1      GTEX-1117F-0003-SM-58Q7G       NA       B1
    ## 2      GTEX-1117F-0003-SM-5DWSB       NA       B1
    ## 3      GTEX-1117F-0003-SM-6WBT7       NA       B1
    ## 4 GTEX-1117F-0011-R10a-SM-AHZ7F       NA   B1, A1
    ## 5 GTEX-1117F-0011-R10b-SM-CYKQ8       NA   B1, A1
    ## 6      GTEX-1117F-0226-SM-5GZZ7        0       B1
    ##                                       SMPTHNTS SMRIN           SMTS
    ## 1                                                 NA          Blood
    ## 2                                                 NA          Blood
    ## 3                                                 NA          Blood
    ## 4                                                 NA          Brain
    ## 5                                                7.2          Brain
    ## 6 2 pieces, ~15% vessel stroma, rep delineated   6.8 Adipose Tissue
    ##                          SMTSD SMUBRID SMTSISCH SMTSPAX SMNABTCH
    ## 1                  Whole Blood 0013756     1188      NA BP-38516
    ## 2                  Whole Blood 0013756     1188      NA BP-38516
    ## 3                  Whole Blood 0013756     1188      NA BP-38516
    ## 4 Brain - Frontal Cortex (BA9) 0009834     1193      NA         
    ## 5 Brain - Frontal Cortex (BA9) 0009834     1193      NA BP-42319
    ## 6       Adipose - Subcutaneous 0002190     1214    1125 BP-43693
    ##                                                SMNABTCHT  SMNABTCHD
    ## 1     DNA isolation_Whole Blood_QIAGEN Puregene (Manual) 05/02/2013
    ## 2     DNA isolation_Whole Blood_QIAGEN Puregene (Manual) 05/02/2013
    ## 3     DNA isolation_Whole Blood_QIAGEN Puregene (Manual) 05/02/2013
    ## 4                                                                  
    ## 5                     RNA isolation_PAXgene Tissue miRNA 08/14/2013
    ## 6 RNA Extraction from Paxgene-derived Lysate Plate Based 09/17/2013
    ##           SMGEBTCH  SMGEBTCHD                          SMGEBTCHT SMAFRZE SMGTC
    ## 1       LCSET-4574 01/15/2014 Standard Exome Sequencing v3 (ICE)     WES    NA
    ## 2 GTEx_OM25_Dec_01 01/28/2014            Illumina OMNI SNP Array    OMNI    NA
    ## 3       LCSET-6056 09/20/2014  PCR+ 30x Coverage WGS v2 (HiSeqX)     WGS    NA
    ## 4                                                       ChIP-Seq            NA
    ## 5                                                        RIP-Seq            NA
    ## 6       LCSET-4804 03/05/2014                          TruSeq.v1  RNASEQ    NA
    ##   SME2MPRT SMCHMPRS SMNTRART SMNUMGPS  SMMAPRT SMEXNCRT SM550NRM SMGNSDTC
    ## 1       NA       NA       NA       NA       NA       NA       NA       NA
    ## 2       NA       NA       NA       NA       NA       NA       NA       NA
    ## 3       NA       NA       NA       NA       NA       NA       NA       NA
    ## 4       NA       NA       NA       NA       NA       NA       NA       NA
    ## 5       NA       NA       NA       NA       NA       NA       NA       NA
    ## 6 0.986026   345562 0.966793       NA 0.990383 0.756726       NA    23548
    ##   SMUNMPRT SM350NRM SMRDLGTH SMMNCPB   SME1MMRT SMSFLGTH SMESTLBS   SMMPPD
    ## 1       NA       NA       NA      NA         NA       NA       NA       NA
    ## 2       NA       NA       NA      NA         NA       NA       NA       NA
    ## 3       NA       NA       NA      NA         NA       NA       NA       NA
    ## 4       NA       NA       NA      NA         NA       NA       NA       NA
    ## 5       NA       NA       NA      NA         NA       NA       NA       NA
    ## 6        1       NA       76      NA 0.00240323      136        0 66833200
    ##    SMNTERRT SMRRNANM  SMRDTTL SMVQCFL SMMNCV SMTRSCPT SMMPPDPR SMCGLGTH
    ## 1        NA       NA       NA      NA     NA       NA       NA       NA
    ## 2        NA       NA       NA      NA     NA       NA       NA       NA
    ## 3        NA       NA       NA      NA     NA       NA       NA       NA
    ## 4        NA       NA       NA      NA     NA       NA       NA       NA
    ## 5        NA       NA       NA      NA     NA       NA       NA       NA
    ## 6 0.0329192   209558 67482200 8797660     NA    23575 33158000       NA
    ##   SMGAPPCT SMUNPDRD SMNTRNRT SMMPUNRT SMEXPEFF SMMPPDUN   SME2MMRT SME2ANTI
    ## 1       NA       NA       NA       NA       NA       NA         NA       NA
    ## 2       NA       NA       NA       NA       NA       NA         NA       NA
    ## 3       NA       NA       NA       NA       NA       NA         NA       NA
    ## 4       NA       NA       NA       NA       NA       NA         NA       NA
    ## 5       NA       NA       NA       NA       NA       NA         NA       NA
    ## 6       NA        0 0.210067 0.990383 0.749449 66833200 0.00391915 14462700
    ##   SMALTALG SME2SNSE SMMFLGTH SME1ANTI SMSPLTRD   SMBSMMRT SME1SNSE SME1PCTS
    ## 1       NA       NA       NA       NA       NA         NA       NA       NA
    ## 2       NA       NA       NA       NA       NA         NA       NA       NA
    ## 3       NA       NA       NA       NA       NA         NA       NA       NA
    ## 4       NA       NA       NA       NA       NA         NA       NA       NA
    ## 5       NA       NA       NA       NA       NA         NA       NA       NA
    ## 6  8914900 14575600      144 14648800 11999300 0.00315785 14669500  50.0354
    ##     SMRRNART SME1MPRT SMNUM5CD SMDPMPRT SME2PCTS
    ## 1         NA       NA       NA       NA       NA
    ## 2         NA       NA       NA       NA       NA
    ## 3         NA       NA       NA       NA       NA
    ## 4         NA       NA       NA       NA       NA
    ## 5         NA       NA       NA       NA       NA
    ## 6 0.00310538  0.99474       NA        0  50.1944

    samples2 <- samples %>%
      select(SAMPID, SMTS, SMNABTCH, SMNABTCHD, SMGEBTCHT, SMAFRZE, SMCENTER, SMRIN, SMATSSCR) %>%
      drop_na() %>%
      mutate(SMNABTCHD = lubridate::mdy(SMNABTCHD),
             SAMPID2 = SAMPID) %>%
      separate(SAMPID2, into = c("one", "two"), sep = "-") %>%
      mutate(SUBJID = paste(one, two, sep = "-")) %>%
      select(SUBJID, SAMPID, SMTS, SMNABTCH, SMNABTCHD, SMGEBTCHT, SMAFRZE, SMCENTER, SMRIN, SMATSSCR) %>%
      right_join(subjects, ., by = "SUBJID")

    ## Warning: Expected 2 pieces. Additional pieces discarded in 1528 rows [1, 2, 3,
    ## 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, ...].

    head(samples2)

    ##       SUBJID    SEX   AGE    DTHHRDY                   SAMPID           SMTS
    ## 1 GTEX-1117F Female 60-69 Slow death GTEX-1117F-0226-SM-5GZZ7 Adipose Tissue
    ## 2 GTEX-1117F Female 60-69 Slow death GTEX-1117F-0426-SM-5EGHI         Muscle
    ## 3 GTEX-1117F Female 60-69 Slow death GTEX-1117F-0526-SM-5EGHJ   Blood Vessel
    ## 4 GTEX-1117F Female 60-69 Slow death GTEX-1117F-0626-SM-5N9CS   Blood Vessel
    ## 5 GTEX-1117F Female 60-69 Slow death GTEX-1117F-0726-SM-5GIEN          Heart
    ## 6 GTEX-1117F Female 60-69 Slow death GTEX-1117F-1326-SM-5EGHH Adipose Tissue
    ##   SMNABTCH  SMNABTCHD SMGEBTCHT SMAFRZE SMCENTER SMRIN SMATSSCR
    ## 1 BP-43693 2013-09-17 TruSeq.v1  RNASEQ       B1   6.8        0
    ## 2 BP-43495 2013-09-12 TruSeq.v1  RNASEQ       B1   7.1        0
    ## 3 BP-43495 2013-09-12 TruSeq.v1  RNASEQ       B1   8.0        0
    ## 4 BP-43956 2013-09-25 TruSeq.v1  RNASEQ       B1   6.9        1
    ## 5 BP-44261 2013-10-03 TruSeq.v1  RNASEQ       B1   6.3        1
    ## 6 BP-43495 2013-09-12 TruSeq.v1  RNASEQ       B1   5.9        1

    ggplot(subjects, aes(x = SEX)) +
      geom_bar(stat = "count")

    ggplot(subjects, aes(x = AGE)) +
      geom_bar(stat = "count")

    ggplot(subjects, aes(x = DTHHRDY)) +
      geom_bar(stat = "count") +
      theme(axis.text.x = element_text(angle = 45, hjust = 1)) 

    ggplot(subjects, aes(x = AGE, fill = DTHHRDY)) +
      geom_bar(stat = "count") +
      facet_wrap(~SEX)

    write.csv(subjects, "../data/subjects.csv", row.names = F)
    write.csv(samples2, "../data/samples.csv", row.names = F)
