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
      select(SUBJID, SAMPID, SMTS, SMNABTCH, SMNABTCHD, SMGEBTCHT, SMAFRZE, SMCENTER, SMRIN, SMATSSCR) 

    ## Warning: Expected 2 pieces. Additional pieces discarded in 1484 rows [1, 2, 3,
    ## 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, ...].

    tail(samples2)

    ##          SUBJID                   SAMPID            SMTS SMNABTCH  SMNABTCHD
    ## 1479 GTEX-145ME GTEX-145ME-0926-SM-5O9AR Small Intestine BP-47675 2013-12-19
    ## 1480 GTEX-145ME GTEX-145ME-1026-SM-5O9B4         Stomach BP-47675 2013-12-19
    ## 1481 GTEX-145ME GTEX-145ME-1126-SM-5SIAT           Colon BP-47616 2013-12-18
    ## 1482 GTEX-145ME GTEX-145ME-1226-SM-5SIB6           Ovary BP-47616 2013-12-18
    ## 1483 GTEX-145ME GTEX-145ME-1326-SM-5O98Q          Uterus BP-47675 2013-12-19
    ## 1484 GTEX-145ME GTEX-145ME-1426-SM-5RQJS          Vagina BP-48437 2014-01-17
    ##      SMGEBTCHT SMAFRZE SMCENTER SMRIN SMATSSCR
    ## 1479 TruSeq.v1  RNASEQ       B1   7.4        1
    ## 1480 TruSeq.v1  RNASEQ       B1   7.4        1
    ## 1481 TruSeq.v1  RNASEQ       B1   6.9        1
    ## 1482 TruSeq.v1  RNASEQ       B1   7.3        1
    ## 1483 TruSeq.v1  RNASEQ       B1   8.5        1
    ## 1484 TruSeq.v1  RNASEQ       B1   7.2        1

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
