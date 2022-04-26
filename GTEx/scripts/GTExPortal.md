Get data from GTEx portal <https://gtexportal.org/home/>

    curl -o samples.txt https://storage.googleapis.com/gtex_analysis_v7/annotations/GTEx_v7_Annotations_SampleAttributesDS.txt
    curl -o subjects.txt https://storage.googleapis.com/gtex_analysis_v7/annotations/GTEx_v7_Annotations_SubjectPhenotypesDS.txt

    library(forcats)
    library(tidyr)
    library(dplyr)

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

    library(ggplot2)
    library(lubridate)

    ## 
    ## Attaching package: 'lubridate'

    ## The following objects are masked from 'package:base':
    ## 
    ##     date, intersect, setdiff, union

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

    samples2 <- samples %>%
      select(SAMPID, SMTS, SMNABTCH, SMNABTCHD, SMGEBTCHT, SMAFRZE, SMCENTER, SMRIN, SMATSSCR) %>%
      drop_na() %>%
      mutate(SMNABTCHD = lubridate::mdy(SMNABTCHD),
             SAMPID2 = SAMPID) %>%
      separate(SAMPID2, into = c("one", "two"), sep = "-") %>%
      mutate(SUBJID = paste(one, two, sep = "-")) %>%
      select(SUBJID, SAMPID, SMTS, SMNABTCH, SMNABTCHD, SMGEBTCHT, SMAFRZE, SMCENTER, SMRIN, SMATSSCR) %>%
      right_join(subjects, ., by = "SUBJID")

    ## Warning: Expected 2 pieces. Additional pieces discarded in 1484 rows [1, 2, 3,
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
