
# Introduction to R for RNA-Seq Workshop

<!---

_Even though you can [![hackmd-github-sync-badge](https://hackmd.io/2ArmQGwGT0uUyL5Ehqy0hQ/badge)](https://hackmd.io/2ArmQGwGT0uUyL5Ehqy0hQ), please make changes by editing [this .Rmd file](https://github.com/nih-cfde/training-rstudio-binder/blob/data/GTEx/r4rnaseq-workshop.Rmd)._

--->

**When:** Wednesday, April 27, 2022, 10 am - 12 pm PDT [workd
clock](https://www.timeanddate.com/worldclock/fixedtime.html?msg=+Introduction+to+R+for+RNA-Sequencing+Analysis&iso=20220427T10&p1=3736&ah=2)  
**Where:**
[Zoom](https://zoom.us/j/7575820324?pwd=d2UyMEhYZGNiV3kyUFpUL1EwQmthQT09)
and
[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/nih-cfde/training-rstudio-binder/data?urlpath=rstudio)  
**Instructors:** Dr. Rayna Harris  
**Organizer:** [The Common Fund Data
Ecosystem](https://training.nih-cfde.org/)

**Description:** RNA-Sequencing (RNA-Seq) is a popular method for
determining the presence and quantity of RNA in biological samples. In
this 2 hour workshop, we will use R to explore publicly-available
RNA-Seq data from the [Gene Expression Tissue Project
(GTEx)](https://gtexportal.org/home/). Attendees will be introduced to
the R syntax, variables, functions, packages, and data structures common
to RNA-Seq projects. We will use RStudio to import, tidy, transform, and
visualize RNA-Seq count data. Attendees will learn tips and tricks for
making the processes of data wrangling and data harmonization more
manageable. This workshop will not cover cloud-based workflows for
processing RNA-seq reads or statistics and modeling because these topics
are covered in our [RNA-Seq Concepts](https://osf.io/kj5av/) and
[RNA-Seq in the
Cloud](https://github.com/nih-cfde/rnaseq-in-the-cloud/blob/stable/rnaseq-workflow.pdf)
workshops. Rather, this workshop will focus on general R concepts
applied to RNA-Seq data. Familiarity with R is not required but would be
useful.

![](https://hackmd.io/_uploads/SkkxxSHeq.png)

:::info

### Learning Objectives

In this workshop, you will learn how to use R and RStudio to:

-   import and view files commonly associated with RNA-sequencing
    experiments
-   select variables and observations that are relevant to research
    questions (tidy)
-   create and rename variables (transform)
-   join data frames by common variables (harmonize)
-   visualize data using bar graphs, scatter plots, and box plots

You will produce graphs and tables to answer the of the following
motivating questions?

-   How many RNA-sequencing samples are in the GTEx project?
-   Do you have enough samples to test the effects of sex, age, hardy
    scale, and their interactions for all tissues?
-   What is the effect of age on gene expression in the heart?
-   How is my gene of interest affected by age in the heart and muscle?

:::

## Introduction

The book [“R for Data Science”](https://r4ds.had.co.nz/index.html)
provides an excellent framework for using data science to turn raw data
into understanding, insight, and knowledge. We will use this framework
as an outline for this workshop.

**R** is a statistical computing and data visualization programming
language. **RStudio** is an integrated development environment, or IDE,
for R programming. R and RStudio work on Mac, Linux, and Windows
operating systems. The RStudio layout displays lots of useful
information and allows us to run R code from a script and view and save
outputs all from one interface.

When you start RStudio, you’ll see two key regions in the interface: the
console and the output. When working in R, you can type directly into
the console, or you can type into a script. Saving commands in a script
will make it easier to reproduce. You will learn more as we go along!

![](https://hackmd.io/_uploads/H1a8-HHx5.png)

For today’s lesson, we will focus on data from the [Gene-Tissue
Expression (GTEx) Project](https://commonfund.nih.gov/gtex). GTEx is an
ongoing effort to build a comprehensive public resource to study
tissue-specific gene expression and regulation. Samples were collected
from 54 non-diseased tissue sites across nearly 1000 individuals,
primarily for molecular assays including WGS, WES, and RNA-Seq.

![](https://i.imgur.com/AfjBaPE.png)

![](https://i.imgur.com/XyTGHTK.png)

![](https://i.imgur.com/jvhRnUy.png)

### Getting Started

1.  Click the
    [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/nih-cfde/training-rstudio-binder/data?urlpath=rstudio)
    button to generate a computing environment for this workshop.
2.  Navigate to the GTEx folder.
3.  Click `GTEx.Rproj` and click “Yes” to open up an Rproject. This will
    set the working directory to `~/GTEx/`.
4.  If you open the `r4rnaseq-workshop.R` file which contains all the
    commands for today’s workshop, you can click through this and all
    the commands should run successfully.
5.  If you open a new R Script by clicking **File > New File > R
    Script**, you can code along by typing out all the commands for
    today’s lesson as I type them.

Click “Run” to send commands from a script to the console or click
command enter.

### R is a calculator

You can perform simple and advanced calculations in R.

``` r
2 + 2 * 100
```

    ## [1] 202

``` r
log(202)
```

    ## [1] 5.308268

You can save variable and recall them later.

``` r
pval <- 0.05
pval
```

    ## [1] 0.05

``` r
-log10(pval)
```

    ## [1] 1.30103

You can save really long lists of things with a short, descriptive names
that are easy to recall later.

``` r
favorite_genes <- c("BRCA1", "POMC", "GnRH", "MC4R", "FOS", "CNR1")
favorite_genes
```

    ## [1] "BRCA1" "POMC"  "GnRH"  "MC4R"  "FOS"   "CNR1"

### Loading R packages

Many of the functions we will use are pre-installed. The
[Tidyverse](https://www.tidyverse.org/) is a collection of R packages
that include functions, data, and documentation that provide more tools
and capabilities when using R. You can install the popular data
visualization package `ggplot2` with the command
`install.packages("ggplot2")`). It is a good idea to “comment out” this
line of code by adding a `#` at the beginning so that you don’t
re-install the package every time you run the script. For this workshop,
the packages listed in the `.binder/environment.yml` file were
pre-installed with Conda.

``` r
#install.packages("ggplot2")
```

After installing packages, we need to load the functions and tools we
want to use from the package with the `library()` command. Let’s load
the `ggplot2` package.

``` r
library(ggplot2)
```

:::warning

#### Challenge

We will also use functions from the packages `tidyr` and `dplyr` to tidy
and transform data. What command would you run to load these packages?

:::spoiler

`library(tidyr)`  
`library(dplyr)`

:::

You can also navigate to the “Packages” tab in the bottom right pane of
RStudio to view a list of available packages. Packages with a checked
box next to them have been successfully loaded. You can click a box to
load installed packages. Clicking the “Help” Tab will provide a quick
description of the package and its functions.

:::success

#### Key functions

| Function             | Description                                  |
|----------------------|----------------------------------------------|
| `<-`                 | The assignment variable                      |
| `log10()`            | A built-in function for a log transformation |
| `install.packages()` | An R function to install packages            |
| `library()`          | The command used to load installed packages  |

:::

## Importing and viewing data

Data can be imported using packages from base R or the tidyverse. What
are some differences between the data objects imported by base R
functions such as `read.csv()` and Tidyverse functions such as
`read_csv()`? To begin with, `read.csv()` replaces spaces and dashes
periods in column names, and it also preserves row.names. On the other
hand, `read_csv()` preserves spaces and dashes in column names but drops
row.names. For this workshop, we will use `read_csv()`, which means we
may have to replace dashes with periods so that our sample names in all
objects with sample name information.

Today, I will show you how to import the following files:

1.  data/samples.csv
2.  data/GTExHeart_20-29_vs_70-79.tsv
3.  data/colData.HEART.csv
4.  data/countData.HEART.csv.gz

Later, you can practice on your own using the following files:

1.  data/GTExMuscle_20-29_vs_70-79.tsv
2.  data/colData.MUSCLE.csv
3.  data/countData.MUSCLE.csv.gz

The `GTExPortal.csv` file in `./data/` contains information about all
the samples in the GTEx portal. Let’s import this file using
`read.csv()`.

``` r
samples <- read.csv("./data/samples.csv")
```

After importing a file, there are multiple ways to view the data.
`head()` to view the first few lines of each file. `names()` will print
just the column names. `str` will compactly displaying the internal
structure. `summary` will compute statistics.

``` r
View(samples)
head(samples)
```

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

``` r
tail(samples)
```

    ##          SUBJID    SEX   AGE         DTHHRDY                   SAMPID
    ## 1479 GTEX-145ME Female 40-49 Ventilator Case GTEX-145ME-0926-SM-5O9AR
    ## 1480 GTEX-145ME Female 40-49 Ventilator Case GTEX-145ME-1026-SM-5O9B4
    ## 1481 GTEX-145ME Female 40-49 Ventilator Case GTEX-145ME-1126-SM-5SIAT
    ## 1482 GTEX-145ME Female 40-49 Ventilator Case GTEX-145ME-1226-SM-5SIB6
    ## 1483 GTEX-145ME Female 40-49 Ventilator Case GTEX-145ME-1326-SM-5O98Q
    ## 1484 GTEX-145ME Female 40-49 Ventilator Case GTEX-145ME-1426-SM-5RQJS
    ##                 SMTS SMNABTCH  SMNABTCHD SMGEBTCHT SMAFRZE SMCENTER SMRIN
    ## 1479 Small Intestine BP-47675 2013-12-19 TruSeq.v1  RNASEQ       B1   7.4
    ## 1480         Stomach BP-47675 2013-12-19 TruSeq.v1  RNASEQ       B1   7.4
    ## 1481           Colon BP-47616 2013-12-18 TruSeq.v1  RNASEQ       B1   6.9
    ## 1482           Ovary BP-47616 2013-12-18 TruSeq.v1  RNASEQ       B1   7.3
    ## 1483          Uterus BP-47675 2013-12-19 TruSeq.v1  RNASEQ       B1   8.5
    ## 1484          Vagina BP-48437 2014-01-17 TruSeq.v1  RNASEQ       B1   7.2
    ##      SMATSSCR
    ## 1479        1
    ## 1480        1
    ## 1481        1
    ## 1482        1
    ## 1483        1
    ## 1484        1

``` r
str(samples)
```

    ## 'data.frame':    1484 obs. of  13 variables:
    ##  $ SUBJID   : chr  "GTEX-1117F" "GTEX-1117F" "GTEX-1117F" "GTEX-1117F" ...
    ##  $ SEX      : chr  "Female" "Female" "Female" "Female" ...
    ##  $ AGE      : chr  "60-69" "60-69" "60-69" "60-69" ...
    ##  $ DTHHRDY  : chr  "Slow death" "Slow death" "Slow death" "Slow death" ...
    ##  $ SAMPID   : chr  "GTEX-1117F-0226-SM-5GZZ7" "GTEX-1117F-0426-SM-5EGHI" "GTEX-1117F-0526-SM-5EGHJ" "GTEX-1117F-0626-SM-5N9CS" ...
    ##  $ SMTS     : chr  "Adipose Tissue" "Muscle" "Blood Vessel" "Blood Vessel" ...
    ##  $ SMNABTCH : chr  "BP-43693" "BP-43495" "BP-43495" "BP-43956" ...
    ##  $ SMNABTCHD: chr  "2013-09-17" "2013-09-12" "2013-09-12" "2013-09-25" ...
    ##  $ SMGEBTCHT: chr  "TruSeq.v1" "TruSeq.v1" "TruSeq.v1" "TruSeq.v1" ...
    ##  $ SMAFRZE  : chr  "RNASEQ" "RNASEQ" "RNASEQ" "RNASEQ" ...
    ##  $ SMCENTER : chr  "B1" "B1" "B1" "B1" ...
    ##  $ SMRIN    : num  6.8 7.1 8 6.9 6.3 5.9 6.6 6.3 6.5 5.8 ...
    ##  $ SMATSSCR : int  0 0 0 1 1 1 1 1 2 1 ...

``` r
summary(samples)
```

    ##     SUBJID              SEX                AGE              DTHHRDY         
    ##  Length:1484        Length:1484        Length:1484        Length:1484       
    ##  Class :character   Class :character   Class :character   Class :character  
    ##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
    ##                                                                             
    ##                                                                             
    ##                                                                             
    ##     SAMPID              SMTS             SMNABTCH          SMNABTCHD        
    ##  Length:1484        Length:1484        Length:1484        Length:1484       
    ##  Class :character   Class :character   Class :character   Class :character  
    ##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
    ##                                                                             
    ##                                                                             
    ##                                                                             
    ##   SMGEBTCHT           SMAFRZE            SMCENTER             SMRIN       
    ##  Length:1484        Length:1484        Length:1484        Min.   : 3.200  
    ##  Class :character   Class :character   Class :character   1st Qu.: 6.300  
    ##  Mode  :character   Mode  :character   Mode  :character   Median : 7.000  
    ##                                                           Mean   : 7.061  
    ##                                                           3rd Qu.: 7.700  
    ##                                                           Max.   :10.000  
    ##     SMATSSCR     
    ##  Min.   :0.0000  
    ##  1st Qu.:0.0000  
    ##  Median :1.0000  
    ##  Mean   :0.8491  
    ##  3rd Qu.:1.0000  
    ##  Max.   :3.0000

Count files can be very long and wide, so it is a good idea to only view
the first (or last) few rows and columns. Typically, a gene identifier
(like an ensemble id) will be used as the row names. We can use `dim` to
see how many rows and columns are in the file.

``` r
counts <- read.csv("./data/countData.HEART.csv", row.names = 1)
dim(counts)
```

    ## [1] 63856   306

``` r
head(counts)[1:5]
```

    ##                 GTEX.12ZZX.0726.SM.5EGKA GTEX.13D11.1526.SM.5J2NA
    ## ENSG00000278704                        0                        0
    ## ENSG00000277400                        0                        0
    ## ENSG00000274847                        0                        0
    ## ENSG00000277428                        0                        0
    ## ENSG00000276256                        0                        0
    ## ENSG00000278198                        0                        0
    ##                 GTEX.ZAJG.0826.SM.5PNVA GTEX.11TT1.1426.SM.5EGIA
    ## ENSG00000278704                       0                        0
    ## ENSG00000277400                       0                        0
    ## ENSG00000274847                       0                        0
    ## ENSG00000277428                       0                        0
    ## ENSG00000276256                       0                        0
    ## ENSG00000278198                       0                        0
    ##                 GTEX.13VXT.1126.SM.5LU3A
    ## ENSG00000278704                        0
    ## ENSG00000277400                        0
    ## ENSG00000274847                        0
    ## ENSG00000277428                        0
    ## ENSG00000276256                        0
    ## ENSG00000278198                        0

This “countData” was generated by using `recount3` as described in the
file `scripts/recount3.Rmd`. It comes from a Ranged Summarized
Experiment (rse) which contains quantitative information about read
counts as well as quality control information and sample descriptions.
The “colData” from an rse can also be obtained. This information
*should* match the information in our samples file, but there can be
subtle differences in formatting We will read the colData in a later
section.

Very large tabular files are often saved as .tsv files. These can be
imported with `read.table()` or `read_tsv()`. You can also specify the
tab delimiter as well as the row and column names. You can import files
using the default parameters or you can change them. Because the first
column in the .tsv files does not have a row name, by default,
`read.table()`, imports the first column as the row.names. When
`sep = "\t", header = TRUE` is specified, the fist column is imported as
column one and given the column name `X`.

``` r
# with row.names
results <- read.table("./data/GTEx_Heart_20-29_vs_30-39.tsv")
head(results)
```

    ##                logFC    AveExpr          t      P.Value  adj.P.Val         B
    ## A1BG      0.10332788  1.3459363  0.3221575 0.7482217611 0.87480317 -5.672644
    ## A1BG-AS1  0.13609230 -0.2381928  0.6395041 0.5244264675 0.73078056 -5.345563
    ## A2M      -0.01605178  9.7981987 -0.1132389 0.9101410387 0.95645802 -5.956689
    ## A2M-AS1   0.60505571  2.5392220  3.4884410 0.0008131523 0.05545654 -0.635100
    ## A2ML1     0.35413535 -1.1667406  1.0788316 0.2840898578 0.52922642 -4.948617
    ## A2MP1     0.65764737 -0.7564399  3.2615528 0.0016630789 0.06067003 -1.358971

:::warning

#### Challenge

What commands could you use to read the following files: 1. GTEx results
comparing the muscles of 20-29 year old to 70-79 year olds? 1. The csv
file information describing the muscle samples?

:::spoiler

1.  `read.table("./data/GTEx_Muscle_20-29_vs_70-79.tsv")`
2.  `read.csv("./data/countData.MUSCLE.csv", row.names = 1)`

:::

#### Quick summary statistics and sample size

You have now seen a variety of options for importing files. You may use
many more in your R-based RNA-seq workflow, but these basics will get
you started. Let’s now explore the functions `summary()`, `length()`,
`dim()`, and `count()` us to quickly summarize and compare data frames
to answer the following questions.

How many samples do we have? Over 1400!

``` r
dim(samples)
```

    ## [1] 1484   13

How many samples are there per tissue?

``` r
dplyr::count(samples, SMTS) 
```

    ##               SMTS   n
    ## 1   Adipose Tissue 133
    ## 2    Adrenal Gland  20
    ## 3     Blood Vessel 138
    ## 4            Brain  75
    ## 5           Breast  50
    ## 6            Colon  77
    ## 7        Esophagus 143
    ## 8            Heart  99
    ## 9           Kidney   6
    ## 10           Liver  28
    ## 11            Lung  67
    ## 12          Muscle  96
    ## 13           Nerve  70
    ## 14           Ovary  16
    ## 15        Pancreas  30
    ## 16       Pituitary  37
    ## 17        Prostate  24
    ## 18  Salivary Gland  22
    ## 19            Skin 155
    ## 20 Small Intestine  23
    ## 21          Spleen  16
    ## 22         Stomach  29
    ## 23          Testis  37
    ## 24         Thyroid  68
    ## 25          Uterus  14
    ## 26          Vagina  11

How many samples are there per tissue and sex? Can we test the effect of
sex on gene expression in all tissues? For many samples, yes, but not
all tissues were samples from both males and females.

``` r
dplyr::count(samples, SMTS, SEX) 
```

    ##               SMTS    SEX   n
    ## 1   Adipose Tissue Female  40
    ## 2   Adipose Tissue   Male  93
    ## 3    Adrenal Gland Female   7
    ## 4    Adrenal Gland   Male  13
    ## 5     Blood Vessel Female  48
    ## 6     Blood Vessel   Male  90
    ## 7            Brain Female  23
    ## 8            Brain   Male  52
    ## 9           Breast Female  16
    ## 10          Breast   Male  34
    ## 11           Colon Female  25
    ## 12           Colon   Male  52
    ## 13       Esophagus Female  37
    ## 14       Esophagus   Male 106
    ## 15           Heart Female  30
    ## 16           Heart   Male  69
    ## 17          Kidney Female   1
    ## 18          Kidney   Male   5
    ## 19           Liver Female   4
    ## 20           Liver   Male  24
    ## 21            Lung Female  20
    ## 22            Lung   Male  47
    ## 23          Muscle Female  25
    ## 24          Muscle   Male  71
    ## 25           Nerve Female  19
    ## 26           Nerve   Male  51
    ## 27           Ovary Female  16
    ## 28        Pancreas Female  12
    ## 29        Pancreas   Male  18
    ## 30       Pituitary Female  10
    ## 31       Pituitary   Male  27
    ## 32        Prostate   Male  24
    ## 33  Salivary Gland Female   5
    ## 34  Salivary Gland   Male  17
    ## 35            Skin Female  47
    ## 36            Skin   Male 108
    ## 37 Small Intestine Female   8
    ## 38 Small Intestine   Male  15
    ## 39          Spleen Female   8
    ## 40          Spleen   Male   8
    ## 41         Stomach Female   9
    ## 42         Stomach   Male  20
    ## 43          Testis   Male  37
    ## 44         Thyroid Female  17
    ## 45         Thyroid   Male  51
    ## 46          Uterus Female  14
    ## 47          Vagina Female  11

How many samples are there per sex, age, and hardy scale? Do you have
enough samples to test the effects of Sex, Age, and Hardy Scale in the
Heart?

``` r
dplyr::count(samples, SMTS, SEX, AGE, DTHHRDY ) 
```

    ##                SMTS    SEX   AGE                      DTHHRDY  n
    ## 1    Adipose Tissue Female 20-29              Ventilator Case  3
    ## 2    Adipose Tissue Female 30-39              Ventilator Case  2
    ## 3    Adipose Tissue Female 40-49 Fast death of natural causes  1
    ## 4    Adipose Tissue Female 40-49              Ventilator Case  5
    ## 5    Adipose Tissue Female 40-49       Violent and fast death  2
    ## 6    Adipose Tissue Female 50-59 Fast death of natural causes  3
    ## 7    Adipose Tissue Female 50-59                   Slow death  1
    ## 8    Adipose Tissue Female 50-59              Ventilator Case  8
    ## 9    Adipose Tissue Female 60-69 Fast death of natural causes  3
    ## 10   Adipose Tissue Female 60-69                   Slow death  7
    ## 11   Adipose Tissue Female 60-69              Ventilator Case  5
    ## 12   Adipose Tissue   Male 20-29              Ventilator Case  7
    ## 13   Adipose Tissue   Male 20-29       Violent and fast death  2
    ## 14   Adipose Tissue   Male 30-39              Ventilator Case  6
    ## 15   Adipose Tissue   Male 40-49 Fast death of natural causes  1
    ## 16   Adipose Tissue   Male 40-49              Ventilator Case  5
    ## 17   Adipose Tissue   Male 50-59 Fast death of natural causes 13
    ## 18   Adipose Tissue   Male 50-59                   Slow death  4
    ## 19   Adipose Tissue   Male 50-59              Ventilator Case 14
    ## 20   Adipose Tissue   Male 60-69 Fast death of natural causes 16
    ## 21   Adipose Tissue   Male 60-69           Intermediate death  3
    ## 22   Adipose Tissue   Male 60-69                   Slow death  6
    ## 23   Adipose Tissue   Male 60-69              Ventilator Case 10
    ## 24   Adipose Tissue   Male 60-69       Violent and fast death  1
    ## 25   Adipose Tissue   Male 70-79 Fast death of natural causes  1
    ## 26   Adipose Tissue   Male 70-79                   Slow death  2
    ## 27   Adipose Tissue   Male 70-79              Ventilator Case  2
    ## 28    Adrenal Gland Female 50-59              Ventilator Case  4
    ## 29    Adrenal Gland Female 60-69           Intermediate death  1
    ## 30    Adrenal Gland Female 60-69              Ventilator Case  2
    ## 31    Adrenal Gland   Male 20-29              Ventilator Case  1
    ## 32    Adrenal Gland   Male 30-39              Ventilator Case  1
    ## 33    Adrenal Gland   Male 40-49              Ventilator Case  3
    ## 34    Adrenal Gland   Male 50-59 Fast death of natural causes  1
    ## 35    Adrenal Gland   Male 50-59              Ventilator Case  3
    ## 36    Adrenal Gland   Male 60-69 Fast death of natural causes  1
    ## 37    Adrenal Gland   Male 60-69              Ventilator Case  3
    ## 38     Blood Vessel Female 20-29              Ventilator Case  5
    ## 39     Blood Vessel Female 30-39              Ventilator Case  2
    ## 40     Blood Vessel Female 40-49 Fast death of natural causes  1
    ## 41     Blood Vessel Female 40-49              Ventilator Case  4
    ## 42     Blood Vessel Female 40-49       Violent and fast death  3
    ## 43     Blood Vessel Female 50-59 Fast death of natural causes  1
    ## 44     Blood Vessel Female 50-59                   Slow death  2
    ## 45     Blood Vessel Female 50-59              Ventilator Case 11
    ## 46     Blood Vessel Female 60-69 Fast death of natural causes  4
    ## 47     Blood Vessel Female 60-69           Intermediate death  2
    ## 48     Blood Vessel Female 60-69                   Slow death  6
    ## 49     Blood Vessel Female 60-69              Ventilator Case  7
    ## 50     Blood Vessel   Male 20-29              Ventilator Case  8
    ## 51     Blood Vessel   Male 20-29       Violent and fast death  1
    ## 52     Blood Vessel   Male 30-39              Ventilator Case  5
    ## 53     Blood Vessel   Male 40-49 Fast death of natural causes  3
    ## 54     Blood Vessel   Male 40-49                   Slow death  1
    ## 55     Blood Vessel   Male 40-49              Ventilator Case  6
    ## 56     Blood Vessel   Male 50-59 Fast death of natural causes  9
    ## 57     Blood Vessel   Male 50-59                   Slow death  5
    ## 58     Blood Vessel   Male 50-59              Ventilator Case 13
    ## 59     Blood Vessel   Male 60-69 Fast death of natural causes 17
    ## 60     Blood Vessel   Male 60-69           Intermediate death  2
    ## 61     Blood Vessel   Male 60-69                   Slow death  4
    ## 62     Blood Vessel   Male 60-69              Ventilator Case 13
    ## 63     Blood Vessel   Male 70-79 Fast death of natural causes  2
    ## 64     Blood Vessel   Male 70-79              Ventilator Case  1
    ## 65            Brain Female 40-49              Ventilator Case  2
    ## 66            Brain Female 40-49       Violent and fast death  2
    ## 67            Brain Female 50-59 Fast death of natural causes  4
    ## 68            Brain Female 50-59                   Slow death  1
    ## 69            Brain Female 60-69 Fast death of natural causes  4
    ## 70            Brain Female 60-69           Intermediate death  2
    ## 71            Brain Female 60-69                   Slow death  8
    ## 72            Brain   Male 40-49 Fast death of natural causes  4
    ## 73            Brain   Male 50-59 Fast death of natural causes 17
    ## 74            Brain   Male 50-59                   Slow death  3
    ## 75            Brain   Male 60-69 Fast death of natural causes 20
    ## 76            Brain   Male 60-69           Intermediate death  1
    ## 77            Brain   Male 60-69                   Slow death  4
    ## 78            Brain   Male 60-69              Ventilator Case  2
    ## 79            Brain   Male 70-79                   Slow death  1
    ## 80           Breast Female 20-29              Ventilator Case  1
    ## 81           Breast Female 30-39              Ventilator Case  1
    ## 82           Breast Female 40-49 Fast death of natural causes  1
    ## 83           Breast Female 40-49       Violent and fast death  1
    ## 84           Breast Female 50-59 Fast death of natural causes  2
    ## 85           Breast Female 50-59                   Slow death  1
    ## 86           Breast Female 50-59              Ventilator Case  2
    ## 87           Breast Female 60-69 Fast death of natural causes  1
    ## 88           Breast Female 60-69           Intermediate death  1
    ## 89           Breast Female 60-69                   Slow death  2
    ## 90           Breast Female 60-69              Ventilator Case  3
    ## 91           Breast   Male 20-29              Ventilator Case  2
    ## 92           Breast   Male 20-29       Violent and fast death  1
    ## 93           Breast   Male 30-39              Ventilator Case  4
    ## 94           Breast   Male 40-49 Fast death of natural causes  1
    ## 95           Breast   Male 40-49              Ventilator Case  4
    ## 96           Breast   Male 50-59 Fast death of natural causes  4
    ## 97           Breast   Male 50-59                   Slow death  1
    ## 98           Breast   Male 50-59              Ventilator Case  4
    ## 99           Breast   Male 60-69 Fast death of natural causes  6
    ## 100          Breast   Male 60-69           Intermediate death  1
    ## 101          Breast   Male 60-69                   Slow death  1
    ## 102          Breast   Male 60-69              Ventilator Case  3
    ## 103          Breast   Male 70-79 Fast death of natural causes  1
    ## 104          Breast   Male 70-79              Ventilator Case  1
    ## 105           Colon Female 20-29              Ventilator Case  2
    ## 106           Colon Female 30-39              Ventilator Case  2
    ## 107           Colon Female 40-49              Ventilator Case  4
    ## 108           Colon Female 40-49       Violent and fast death  1
    ## 109           Colon Female 50-59              Ventilator Case  7
    ## 110           Colon Female 60-69           Intermediate death  1
    ## 111           Colon Female 60-69                   Slow death  4
    ## 112           Colon Female 60-69              Ventilator Case  4
    ## 113           Colon   Male 20-29              Ventilator Case  5
    ## 114           Colon   Male 20-29       Violent and fast death  2
    ## 115           Colon   Male 30-39              Ventilator Case  2
    ## 116           Colon   Male 40-49 Fast death of natural causes  1
    ## 117           Colon   Male 40-49              Ventilator Case  5
    ## 118           Colon   Male 50-59 Fast death of natural causes  3
    ## 119           Colon   Male 50-59                   Slow death  3
    ## 120           Colon   Male 50-59              Ventilator Case  9
    ## 121           Colon   Male 60-69 Fast death of natural causes 13
    ## 122           Colon   Male 60-69                   Slow death  2
    ## 123           Colon   Male 60-69              Ventilator Case  6
    ## 124           Colon   Male 70-79 Fast death of natural causes  1
    ## 125       Esophagus Female 20-29              Ventilator Case  2
    ## 126       Esophagus Female 30-39              Ventilator Case  3
    ## 127       Esophagus Female 40-49              Ventilator Case  6
    ## 128       Esophagus Female 40-49       Violent and fast death  1
    ## 129       Esophagus Female 50-59 Fast death of natural causes  2
    ## 130       Esophagus Female 50-59              Ventilator Case 13
    ## 131       Esophagus Female 60-69                   Slow death  4
    ## 132       Esophagus Female 60-69              Ventilator Case  6
    ## 133       Esophagus   Male 20-29              Ventilator Case 12
    ## 134       Esophagus   Male 20-29       Violent and fast death  3
    ## 135       Esophagus   Male 30-39              Ventilator Case  5
    ## 136       Esophagus   Male 40-49 Fast death of natural causes  5
    ## 137       Esophagus   Male 40-49              Ventilator Case  9
    ## 138       Esophagus   Male 50-59 Fast death of natural causes 11
    ## 139       Esophagus   Male 50-59                   Slow death  6
    ## 140       Esophagus   Male 50-59              Ventilator Case 19
    ## 141       Esophagus   Male 60-69 Fast death of natural causes 13
    ## 142       Esophagus   Male 60-69           Intermediate death  2
    ## 143       Esophagus   Male 60-69                   Slow death  3
    ## 144       Esophagus   Male 60-69              Ventilator Case 17
    ## 145       Esophagus   Male 70-79              Ventilator Case  1
    ## 146           Heart Female 20-29              Ventilator Case  2
    ## 147           Heart Female 30-39              Ventilator Case  1
    ## 148           Heart Female 40-49              Ventilator Case  3
    ## 149           Heart Female 40-49       Violent and fast death  1
    ## 150           Heart Female 50-59 Fast death of natural causes  4
    ## 151           Heart Female 50-59              Ventilator Case  9
    ## 152           Heart Female 60-69           Intermediate death  2
    ## 153           Heart Female 60-69                   Slow death  4
    ## 154           Heart Female 60-69              Ventilator Case  4
    ## 155           Heart   Male 20-29              Ventilator Case  2
    ## 156           Heart   Male 30-39              Ventilator Case  3
    ## 157           Heart   Male 40-49 Fast death of natural causes  4
    ## 158           Heart   Male 40-49              Ventilator Case  5
    ## 159           Heart   Male 50-59 Fast death of natural causes  6
    ## 160           Heart   Male 50-59                   Slow death  5
    ## 161           Heart   Male 50-59              Ventilator Case  9
    ## 162           Heart   Male 60-69 Fast death of natural causes 15
    ## 163           Heart   Male 60-69           Intermediate death  2
    ## 164           Heart   Male 60-69                   Slow death  4
    ## 165           Heart   Male 60-69              Ventilator Case 11
    ## 166           Heart   Male 70-79 Fast death of natural causes  1
    ## 167           Heart   Male 70-79              Ventilator Case  2
    ## 168          Kidney Female 60-69                   Slow death  1
    ## 169          Kidney   Male 40-49 Fast death of natural causes  1
    ## 170          Kidney   Male 50-59 Fast death of natural causes  1
    ## 171          Kidney   Male 60-69 Fast death of natural causes  2
    ## 172          Kidney   Male 60-69                   Slow death  1
    ## 173           Liver Female 50-59 Fast death of natural causes  1
    ## 174           Liver Female 50-59              Ventilator Case  1
    ## 175           Liver Female 60-69 Fast death of natural causes  1
    ## 176           Liver Female 60-69           Intermediate death  1
    ## 177           Liver   Male 20-29              Ventilator Case  2
    ## 178           Liver   Male 30-39              Ventilator Case  1
    ## 179           Liver   Male 40-49 Fast death of natural causes  1
    ## 180           Liver   Male 40-49              Ventilator Case  1
    ## 181           Liver   Male 50-59 Fast death of natural causes  6
    ## 182           Liver   Male 50-59              Ventilator Case  3
    ## 183           Liver   Male 60-69 Fast death of natural causes  9
    ## 184           Liver   Male 60-69           Intermediate death  1
    ## 185            Lung Female 20-29              Ventilator Case  2
    ## 186            Lung Female 30-39              Ventilator Case  1
    ## 187            Lung Female 40-49 Fast death of natural causes  1
    ## 188            Lung Female 40-49              Ventilator Case  3
    ## 189            Lung Female 50-59 Fast death of natural causes  1
    ## 190            Lung Female 50-59                   Slow death  1
    ## 191            Lung Female 50-59              Ventilator Case  3
    ## 192            Lung Female 60-69 Fast death of natural causes  2
    ## 193            Lung Female 60-69           Intermediate death  1
    ## 194            Lung Female 60-69                   Slow death  3
    ## 195            Lung Female 60-69              Ventilator Case  2
    ## 196            Lung   Male 20-29              Ventilator Case  2
    ## 197            Lung   Male 30-39              Ventilator Case  2
    ## 198            Lung   Male 40-49 Fast death of natural causes  2
    ## 199            Lung   Male 40-49              Ventilator Case  3
    ## 200            Lung   Male 50-59 Fast death of natural causes  6
    ## 201            Lung   Male 50-59                   Slow death  3
    ## 202            Lung   Male 50-59              Ventilator Case  7
    ## 203            Lung   Male 60-69 Fast death of natural causes 10
    ## 204            Lung   Male 60-69                   Slow death  3
    ## 205            Lung   Male 60-69              Ventilator Case  6
    ## 206            Lung   Male 70-79 Fast death of natural causes  2
    ## 207            Lung   Male 70-79              Ventilator Case  1
    ## 208          Muscle Female 20-29              Ventilator Case  2
    ## 209          Muscle Female 30-39              Ventilator Case  1
    ## 210          Muscle Female 40-49 Fast death of natural causes  1
    ## 211          Muscle Female 40-49              Ventilator Case  2
    ## 212          Muscle Female 40-49       Violent and fast death  1
    ## 213          Muscle Female 50-59 Fast death of natural causes  2
    ## 214          Muscle Female 50-59                   Slow death  1
    ## 215          Muscle Female 50-59              Ventilator Case  5
    ## 216          Muscle Female 60-69 Fast death of natural causes  2
    ## 217          Muscle Female 60-69           Intermediate death  1
    ## 218          Muscle Female 60-69                   Slow death  5
    ## 219          Muscle Female 60-69              Ventilator Case  2
    ## 220          Muscle   Male 20-29              Ventilator Case  4
    ## 221          Muscle   Male 20-29       Violent and fast death  1
    ## 222          Muscle   Male 30-39              Ventilator Case  4
    ## 223          Muscle   Male 40-49 Fast death of natural causes  2
    ## 224          Muscle   Male 40-49                   Slow death  1
    ## 225          Muscle   Male 40-49              Ventilator Case  4
    ## 226          Muscle   Male 50-59 Fast death of natural causes  9
    ## 227          Muscle   Male 50-59                   Slow death  2
    ## 228          Muscle   Male 50-59              Ventilator Case 10
    ## 229          Muscle   Male 60-69 Fast death of natural causes 16
    ## 230          Muscle   Male 60-69           Intermediate death  2
    ## 231          Muscle   Male 60-69                   Slow death  5
    ## 232          Muscle   Male 60-69              Ventilator Case  6
    ## 233          Muscle   Male 60-69       Violent and fast death  1
    ## 234          Muscle   Male 70-79 Fast death of natural causes  2
    ## 235          Muscle   Male 70-79                   Slow death  1
    ## 236          Muscle   Male 70-79              Ventilator Case  1
    ## 237           Nerve Female 20-29              Ventilator Case  1
    ## 238           Nerve Female 30-39              Ventilator Case  1
    ## 239           Nerve Female 40-49 Fast death of natural causes  1
    ## 240           Nerve Female 40-49              Ventilator Case  1
    ## 241           Nerve Female 40-49       Violent and fast death  1
    ## 242           Nerve Female 50-59 Fast death of natural causes  2
    ## 243           Nerve Female 50-59                   Slow death  1
    ## 244           Nerve Female 50-59              Ventilator Case  4
    ## 245           Nerve Female 60-69 Fast death of natural causes  2
    ## 246           Nerve Female 60-69           Intermediate death  1
    ## 247           Nerve Female 60-69                   Slow death  2
    ## 248           Nerve Female 60-69              Ventilator Case  2
    ## 249           Nerve   Male 20-29              Ventilator Case  3
    ## 250           Nerve   Male 20-29       Violent and fast death  1
    ## 251           Nerve   Male 30-39              Ventilator Case  2
    ## 252           Nerve   Male 40-49 Fast death of natural causes  1
    ## 253           Nerve   Male 40-49              Ventilator Case  2
    ## 254           Nerve   Male 50-59 Fast death of natural causes  9
    ## 255           Nerve   Male 50-59                   Slow death  2
    ## 256           Nerve   Male 50-59              Ventilator Case  9
    ## 257           Nerve   Male 60-69 Fast death of natural causes 10
    ## 258           Nerve   Male 60-69           Intermediate death  1
    ## 259           Nerve   Male 60-69                   Slow death  3
    ## 260           Nerve   Male 60-69              Ventilator Case  6
    ## 261           Nerve   Male 70-79                   Slow death  1
    ## 262           Nerve   Male 70-79              Ventilator Case  1
    ## 263           Ovary Female 20-29              Ventilator Case  2
    ## 264           Ovary Female 30-39              Ventilator Case  1
    ## 265           Ovary Female 40-49              Ventilator Case  2
    ## 266           Ovary Female 40-49       Violent and fast death  1
    ## 267           Ovary Female 50-59 Fast death of natural causes  2
    ## 268           Ovary Female 50-59              Ventilator Case  4
    ## 269           Ovary Female 60-69           Intermediate death  1
    ## 270           Ovary Female 60-69                   Slow death  2
    ## 271           Ovary Female 60-69              Ventilator Case  1
    ## 272        Pancreas Female 20-29              Ventilator Case  2
    ## 273        Pancreas Female 40-49              Ventilator Case  2
    ## 274        Pancreas Female 50-59 Fast death of natural causes  1
    ## 275        Pancreas Female 50-59              Ventilator Case  5
    ## 276        Pancreas Female 60-69              Ventilator Case  2
    ## 277        Pancreas   Male 20-29              Ventilator Case  2
    ## 278        Pancreas   Male 30-39              Ventilator Case  1
    ## 279        Pancreas   Male 40-49              Ventilator Case  2
    ## 280        Pancreas   Male 50-59 Fast death of natural causes  2
    ## 281        Pancreas   Male 50-59              Ventilator Case  4
    ## 282        Pancreas   Male 60-69 Fast death of natural causes  3
    ## 283        Pancreas   Male 60-69              Ventilator Case  4
    ## 284       Pituitary Female 40-49 Fast death of natural causes  1
    ## 285       Pituitary Female 40-49              Ventilator Case  1
    ## 286       Pituitary Female 40-49       Violent and fast death  1
    ## 287       Pituitary Female 50-59 Fast death of natural causes  2
    ## 288       Pituitary Female 50-59                   Slow death  1
    ## 289       Pituitary Female 60-69 Fast death of natural causes  2
    ## 290       Pituitary Female 60-69                   Slow death  2
    ## 291       Pituitary   Male 40-49 Fast death of natural causes  1
    ## 292       Pituitary   Male 50-59 Fast death of natural causes  4
    ## 293       Pituitary   Male 50-59                   Slow death  2
    ## 294       Pituitary   Male 60-69 Fast death of natural causes 13
    ## 295       Pituitary   Male 60-69           Intermediate death  1
    ## 296       Pituitary   Male 60-69                   Slow death  2
    ## 297       Pituitary   Male 60-69              Ventilator Case  1
    ## 298       Pituitary   Male 70-79 Fast death of natural causes  1
    ## 299       Pituitary   Male 70-79                   Slow death  1
    ## 300       Pituitary   Male 70-79              Ventilator Case  1
    ## 301        Prostate   Male 20-29              Ventilator Case  3
    ## 302        Prostate   Male 20-29       Violent and fast death  1
    ## 303        Prostate   Male 30-39              Ventilator Case  1
    ## 304        Prostate   Male 40-49 Fast death of natural causes  1
    ## 305        Prostate   Male 40-49              Ventilator Case  2
    ## 306        Prostate   Male 50-59 Fast death of natural causes  2
    ## 307        Prostate   Male 50-59              Ventilator Case  4
    ## 308        Prostate   Male 60-69 Fast death of natural causes  4
    ## 309        Prostate   Male 60-69                   Slow death  2
    ## 310        Prostate   Male 60-69              Ventilator Case  4
    ## 311  Salivary Gland Female 20-29              Ventilator Case  1
    ## 312  Salivary Gland Female 30-39              Ventilator Case  1
    ## 313  Salivary Gland Female 60-69 Fast death of natural causes  1
    ## 314  Salivary Gland Female 60-69                   Slow death  1
    ## 315  Salivary Gland Female 60-69              Ventilator Case  1
    ## 316  Salivary Gland   Male 20-29       Violent and fast death  1
    ## 317  Salivary Gland   Male 30-39              Ventilator Case  1
    ## 318  Salivary Gland   Male 40-49 Fast death of natural causes  1
    ## 319  Salivary Gland   Male 40-49              Ventilator Case  1
    ## 320  Salivary Gland   Male 50-59 Fast death of natural causes  2
    ## 321  Salivary Gland   Male 50-59              Ventilator Case  1
    ## 322  Salivary Gland   Male 60-69 Fast death of natural causes  7
    ## 323  Salivary Gland   Male 60-69           Intermediate death  1
    ## 324  Salivary Gland   Male 60-69              Ventilator Case  2
    ## 325            Skin Female 20-29              Ventilator Case  4
    ## 326            Skin Female 30-39              Ventilator Case  2
    ## 327            Skin Female 40-49 Fast death of natural causes  2
    ## 328            Skin Female 40-49              Ventilator Case  4
    ## 329            Skin Female 40-49       Violent and fast death  2
    ## 330            Skin Female 50-59 Fast death of natural causes  4
    ## 331            Skin Female 50-59                   Slow death  2
    ## 332            Skin Female 50-59              Ventilator Case 10
    ## 333            Skin Female 60-69 Fast death of natural causes  3
    ## 334            Skin Female 60-69           Intermediate death  2
    ## 335            Skin Female 60-69                   Slow death  7
    ## 336            Skin Female 60-69              Ventilator Case  5
    ## 337            Skin   Male 20-29              Ventilator Case  6
    ## 338            Skin   Male 20-29       Violent and fast death  2
    ## 339            Skin   Male 30-39              Ventilator Case  6
    ## 340            Skin   Male 40-49 Fast death of natural causes  4
    ## 341            Skin   Male 40-49                   Slow death  1
    ## 342            Skin   Male 40-49              Ventilator Case  6
    ## 343            Skin   Male 50-59 Fast death of natural causes 17
    ## 344            Skin   Male 50-59                   Slow death  3
    ## 345            Skin   Male 50-59              Ventilator Case 10
    ## 346            Skin   Male 60-69 Fast death of natural causes 23
    ## 347            Skin   Male 60-69           Intermediate death  2
    ## 348            Skin   Male 60-69                   Slow death  9
    ## 349            Skin   Male 60-69              Ventilator Case 10
    ## 350            Skin   Male 60-69       Violent and fast death  1
    ## 351            Skin   Male 70-79 Fast death of natural causes  4
    ## 352            Skin   Male 70-79                   Slow death  2
    ## 353            Skin   Male 70-79              Ventilator Case  2
    ## 354 Small Intestine Female 40-49              Ventilator Case  1
    ## 355 Small Intestine Female 50-59              Ventilator Case  4
    ## 356 Small Intestine Female 60-69 Fast death of natural causes  1
    ## 357 Small Intestine Female 60-69              Ventilator Case  2
    ## 358 Small Intestine   Male 20-29              Ventilator Case  2
    ## 359 Small Intestine   Male 20-29       Violent and fast death  1
    ## 360 Small Intestine   Male 30-39              Ventilator Case  1
    ## 361 Small Intestine   Male 40-49 Fast death of natural causes  1
    ## 362 Small Intestine   Male 40-49              Ventilator Case  2
    ## 363 Small Intestine   Male 50-59              Ventilator Case  4
    ## 364 Small Intestine   Male 60-69 Fast death of natural causes  1
    ## 365 Small Intestine   Male 60-69              Ventilator Case  3
    ## 366          Spleen Female 20-29              Ventilator Case  1
    ## 367          Spleen Female 30-39              Ventilator Case  1
    ## 368          Spleen Female 40-49              Ventilator Case  1
    ## 369          Spleen Female 50-59              Ventilator Case  4
    ## 370          Spleen Female 60-69              Ventilator Case  1
    ## 371          Spleen   Male 30-39              Ventilator Case  1
    ## 372          Spleen   Male 40-49              Ventilator Case  2
    ## 373          Spleen   Male 50-59              Ventilator Case  4
    ## 374          Spleen   Male 60-69              Ventilator Case  1
    ## 375         Stomach Female 20-29              Ventilator Case  1
    ## 376         Stomach Female 40-49              Ventilator Case  2
    ## 377         Stomach Female 50-59              Ventilator Case  4
    ## 378         Stomach Female 60-69 Fast death of natural causes  1
    ## 379         Stomach Female 60-69              Ventilator Case  1
    ## 380         Stomach   Male 20-29              Ventilator Case  4
    ## 381         Stomach   Male 20-29       Violent and fast death  1
    ## 382         Stomach   Male 30-39              Ventilator Case  1
    ## 383         Stomach   Male 40-49              Ventilator Case  2
    ## 384         Stomach   Male 50-59 Fast death of natural causes  2
    ## 385         Stomach   Male 50-59              Ventilator Case  6
    ## 386         Stomach   Male 60-69              Ventilator Case  3
    ## 387         Stomach   Male 70-79              Ventilator Case  1
    ## 388          Testis   Male 20-29              Ventilator Case  3
    ## 389          Testis   Male 20-29       Violent and fast death  1
    ## 390          Testis   Male 30-39              Ventilator Case  2
    ## 391          Testis   Male 40-49 Fast death of natural causes  2
    ## 392          Testis   Male 40-49              Ventilator Case  2
    ## 393          Testis   Male 50-59 Fast death of natural causes  3
    ## 394          Testis   Male 50-59                   Slow death  1
    ## 395          Testis   Male 50-59              Ventilator Case  5
    ## 396          Testis   Male 60-69 Fast death of natural causes 12
    ## 397          Testis   Male 60-69                   Slow death  1
    ## 398          Testis   Male 60-69              Ventilator Case  3
    ## 399          Testis   Male 70-79 Fast death of natural causes  1
    ## 400          Testis   Male 70-79              Ventilator Case  1
    ## 401         Thyroid Female 20-29              Ventilator Case  1
    ## 402         Thyroid Female 30-39              Ventilator Case  1
    ## 403         Thyroid Female 40-49 Fast death of natural causes  1
    ## 404         Thyroid Female 40-49              Ventilator Case  2
    ## 405         Thyroid Female 40-49       Violent and fast death  1
    ## 406         Thyroid Female 50-59 Fast death of natural causes  1
    ## 407         Thyroid Female 50-59              Ventilator Case  5
    ## 408         Thyroid Female 60-69 Fast death of natural causes  1
    ## 409         Thyroid Female 60-69           Intermediate death  1
    ## 410         Thyroid Female 60-69                   Slow death  2
    ## 411         Thyroid Female 60-69              Ventilator Case  1
    ## 412         Thyroid   Male 20-29              Ventilator Case  3
    ## 413         Thyroid   Male 20-29       Violent and fast death  1
    ## 414         Thyroid   Male 30-39              Ventilator Case  1
    ## 415         Thyroid   Male 40-49 Fast death of natural causes  2
    ## 416         Thyroid   Male 40-49              Ventilator Case  4
    ## 417         Thyroid   Male 50-59 Fast death of natural causes 10
    ## 418         Thyroid   Male 50-59                   Slow death  2
    ## 419         Thyroid   Male 50-59              Ventilator Case  7
    ## 420         Thyroid   Male 60-69 Fast death of natural causes 10
    ## 421         Thyroid   Male 60-69                   Slow death  2
    ## 422         Thyroid   Male 60-69              Ventilator Case  6
    ## 423         Thyroid   Male 60-69       Violent and fast death  1
    ## 424         Thyroid   Male 70-79                   Slow death  1
    ## 425         Thyroid   Male 70-79              Ventilator Case  1
    ## 426          Uterus Female 20-29              Ventilator Case  2
    ## 427          Uterus Female 30-39              Ventilator Case  1
    ## 428          Uterus Female 40-49              Ventilator Case  2
    ## 429          Uterus Female 40-49       Violent and fast death  1
    ## 430          Uterus Female 50-59 Fast death of natural causes  1
    ## 431          Uterus Female 50-59              Ventilator Case  3
    ## 432          Uterus Female 60-69 Fast death of natural causes  1
    ## 433          Uterus Female 60-69                   Slow death  2
    ## 434          Uterus Female 60-69              Ventilator Case  1
    ## 435          Vagina Female 30-39              Ventilator Case  1
    ## 436          Vagina Female 40-49              Ventilator Case  2
    ## 437          Vagina Female 40-49       Violent and fast death  1
    ## 438          Vagina Female 50-59              Ventilator Case  3
    ## 439          Vagina Female 60-69                   Slow death  3
    ## 440          Vagina Female 60-69              Ventilator Case  1

:::warning

#### Challenge

What series commands would you use to import the
`data/colData.MUSCLE.csv` and count the number of muscles samples per
sex, age?

How many female muscles samples are there from age group 30-39?

*Hint: use head() or names() after importing a file to verify the
variable names.*

:::spoiler

`df <- read.csv("./data/colData.MUSCLE.csv")`
`dplyr::count(df, SMTS, SEX, AGE)`
`# 3 samples are in the female group age 30-39`

:::

:::success

#### Key functions for importing and quickly viewing raw and summarized data

| Function              | Description                                                     |
|-----------------------|-----------------------------------------------------------------|
| `read.csv()`          | A base R function for importing comma separated tabular data    |
| `read_csv()`          | A tidyR function for importing .csv files as tibbles            |
| `read.table()`        | A base R function for importing tabular data with any delimiter |
| `read_tsv()`          | A tidyR function for importing .tsv files as tibbles            |
| `as_tibble()`         | Convert data frames to tibbles                                  |
| `head()` and `tail()` | Print the first or last 6 lines of an object                    |
| `dim()`               | A function that prints the dimensions of an object              |
| `length()`            | Calculate the length of an object                               |
| `count()`             | A dplyr function that counts number of samples per group        |
| `str()`               | A function that prints the internal structure of an object      |
| `summary()`           | A function that summarizes each variable                        |

:::

## Visualizing data with ggplot2

`ggplot2` is a very popular package for making visualization. It is
built on the “grammar of graphics”. Any plot can be expressed from the
same set of components: a data set, a coordinate system, and a set of
“geoms” or the visual representation of data points such as points,
bars, line, or boxes. This is the template we build on:

    ggplot(data = <DATA>, aes(<MAPPINGS>)) +
      <geom_function>() +
      ...

We just used the `count()` function to calculate how many samples are in
each group. The function for creating bar graphs (`geom_bar()`) also
makes use of `stat = "count"` to plot the total number of observations
per variable. Let’s use ggplot2 to create a visual representation of how
many samples there are per tissue, sex, and hardiness.

``` r
ggplot(samples, aes(x = SMTS)) +
  geom_bar(stat = "count")
```

![](./images/bar1-1.png)<!-- -->

In the last section, we will discuss how to modify the `themes()` to
adjust the axes, legends, and more. For now, let’s flip the x and y
coordinates so that we can read the sample names. We do this by adding a
layer and the function `coord_flip()`

``` r
ggplot(samples, aes(x = SMTS)) +
  geom_bar(stat = "count") + 
  coord_flip()
```

![](./images/bar2-1.png)<!-- -->

Now, there are two ways we can visualize another variable in addition to
tissue. We can add color or we can add facets.

Let’s first color the data by age bracket. Color is an aesthetic, so it
must go inside the `aes()`. If you include `aes(color = AGE)` inside
`ggplot()`, the color will be applied to every layer in your plot. If
you add `aes(color = AGE)` inside `geom_bar()`, it will only be applied
to that layer (which is important later when you layer multiple geoms.

head(samples)

``` r
ggplot(samples, aes(x = SMTS, color = AGE)) +
  geom_bar(stat = "count") + 
  coord_flip()
```

![](./images/bar3-1.png)<!-- -->

Note that the bars are outlined in a color according to hardy scale. If
instead, you would the bars “filled” with color, use the aesthetic
`aes(fill = AGE)`

``` r
ggplot(samples, aes(x = SMTS, fill = AGE)) +
  geom_bar(stat = "count") + 
  coord_flip()
```

![](./images/bar4-1.png)<!-- -->

Now, let’s use `facet_wrap(~SEX)` to break the data into two groups
based on the variable sex.

``` r
ggplot(samples, aes(x = SMTS, fill = AGE)) +
  geom_bar(stat = "count") + 
  coord_flip() +
  facet_wrap(~SEX)
```

![](./images/bar5-1.png)<!-- -->

![](https://i.imgur.com/AfjBaPE.png)

With this graph, we have an excellent overview of the total numbers of
RNA-Seq samples in the GTEx project, and we can see where we are missing
data (for good biological reasons). However, this plot doesn’t show us
Hardy Scale. It’s hard to layer 4 variables, so let’s remove Tissue as a
variable by focusing just on one Tissue.

:::warning

#### Challenge

Create a plot showing the total number of samples per Sex, Age Bracket,
and Hardy Scale for *just* the Heart samples. Paste the code you used in
the chat.

:::spoiler

There are many options. Here are a few.

      ggplot(samples, aes(x = DTHHRDY, fill = AGE))  +
          geom_bar(stat = "count") +
          facet_wrap(~SEX) 
        
      ggplot(samples, aes(x = AGE, fill = as.factor(DTHHRDY)))  +
          geom_bar(stat = "count") +
          facet_wrap(~SEX) 

:::

One thing these plots show us is that we don’t have enough samples to
test the effects of all our experimental variables (age, sex, tissue,
and hardy scale) and their interactions on gene expression. We can,
however, focus on one or two variables or groups at a time.

Earlier, we imported the file “data/GTEx_Heart_20-29_vs_70-79.tsv”)” and
saved it as “results”. This file contains the results of a differential
gene expression analysis comparing heart tissue from 20-29 to heart
tissue from 30-39 year olds. This is a one-way design investigating only
the effect of age (but not sex or hardy scale) on gene expression in the
heart. Let’s visualize these results.

[Volcano Plots](https://en.wikipedia.org/wiki/Volcano_plot_(statistics))
are a type of scatter plots that show the log fold change (logFC) on the
x axis and the inverse log (`-log10()`) of a p-value that has been
corrected for multiple hypothesis testing (adj.P.Val). Let’s create a
Volcano Plot using the `gplot()` and `geom_point()`. *Note: this may
take a minute because there are 15,000 points that must be plotted*

``` r
ggplot(results, aes(x = logFC, y = -log10(adj.P.Val))) +
  geom_point() 
```

![](./images/volcano1-1.png)<!-- -->

The inverse log of p \< 05 is 1.30103. We can add a horizontal line to
our plot using `geom_hline()` so that we can visually see how many genes
or points are significant and how many are not.

``` r
ggplot(results, aes(x = logFC, y = -log10(adj.P.Val))) +
  geom_point() +
  geom_hline(yintercept = -log10(0.05))
```

![](./images/volcano2-1.png)<!-- -->

``` r
ggplot(results, aes(x = logFC, y = -log10(adj.P.Val))) +
  geom_point(aes(color = ifelse( adj.P.Val < 0.05, "p < 0.05", "NS"))) +
  geom_hline(yintercept = -log10(0.05)) 
```

![](./images/volcano3-1.png)<!-- -->

``` r
ggplot(results, aes(x = logFC, y = -log10(adj.P.Val))) +
  geom_point(aes(color = ifelse( adj.P.Val < 0.05, "p < 0.05", "NS"))) +
  geom_hline(yintercept = -log10(0.05))  +
  theme(legend.position = "bottom") +
  labs(color = "20-29 vs 30-39 year olds", 
       subtitle = "Heart Tissue Gene Expression")
```

![](./images/volcano4-1.png)<!-- -->

:::warning

#### Challenge

Create a volcano plot for the results comparing the heart tissue of
20-29 year olds to that of 70-70 year olds? Are there more or less
differential expressed gene between 20 and 30 year olds or 20 and 70
year olds?

:::spoiler

      df <- read.table("./data/GTEx_Heart_20-29_vs_70-79.tsv")

      ggplot(df, aes(x = logFC, y = -log10(adj.P.Val))) +
        geom_point() +
        geom_hline(yintercept = -log10(0.05))
      
      # more  

:::

In addition to containing information about the donor tissue, the
samples file contains has a column with a RIN score, which tells us
about the quality of the data. If we wanted to look for interactions
between RIN score (SMRIN) and sequencing facility (SMCENTER), we can use
a box plot.

``` r
ggplot(samples, aes(x = SMCENTER, y = SMRIN)) +
  geom_boxplot() +
  geom_jitter(aes(color = SMRIN))
```

![](./images/boxplot-1.png)<!-- -->

Now you know a handful of R functions for importing, summarizing, and
visualizing data. In the next section, we will tidy and transform our
data so that we can make even better summaries and figures. In the last
section, you will learn ggplot function for making fancier figures.

:::success

#### Key functions

| Function       | Description                                                                                                             |
|----------------|-------------------------------------------------------------------------------------------------------------------------|
| `ggplot2`      | An open-source data visualization package for the statistical programming language R                                    |
| `ggplot()`     | The function used to construct the initial plot object, and is almost always followed by + to add component to the plot |
| `aes()`        | Aesthetic mappings that describe how variables in the data are mapped to visual properties (aesthetics) of geoms        |
| `geom_point()` | A function used to create scatter plots                                                                                 |
| `geom_bar()`   | A function used to create bar plots                                                                                     |
| `coord_flip()` | Flips the x and y axis                                                                                                  |
| `geom_hline()` | Add a horizontal line to plots                                                                                          |

:::

## Tidy and Transform Data

[Data wrangling](https://en.wikipedia.org/wiki/Data_wrangling) is the
process of tidying and transforming data to make it more appropriate and
valuable for a variety of downstream purposes such as analytics. The
goal of data wrangling is to assure quality and useful data. Data
analysts typically spend the majority of their time in the process of
data wrangling compared to the actual analysis of the data.

**Tidying** your data means storing it in a consistent form. When your
data is tidy, each column is a variable, and each row is an observation.
Tidy data is important because the consistent structure lets you focus
your struggle on questions about the data, not fighting to get the data
into the right form for different functions. Some tidying functions
include `pivot_longer()`, `pivot_wider()`, `separate()`, `unite()`,
`drop_na()`, `replace_na()`. The “lubridate” package has a number of
functions for tidying dates. You may also use `mutate()` function to
convert objects from, say, characters or integers to factors or rename
observations and variables.

**Transforming** your data includes narrowing in on observations of
interest (like all people in one city, or all data from the last year),
creating new variables that are functions of existing variables (like
computing speed from distance and time), and calculating a set of
summary statistics (like counts or means). Summary functions such as
`summarize()` and `count()` to create new tables with statistics. Before
summarizing or counting a whole data frame, you can use `group_by()` to
group variables. You can use `filter()` and `select()` to isolate
specific rows or columns, respectively. If you want to sort columns,
`arrange()` and `arrange(desc())` are two functions to familiarize
yourself with.

**Combining tables** can be accomplished in one of two ways. If all the
columns or all the rows have all the same names, you can use `rbind()`
or `cbind()`, respectively, to join the data frames. If however, each
data frame have a column (or multiple columns) that contain unique
identifiers, then you can use the family of join functions
(`inner_join()`, `outter_join()`, `left_join()`, and `right_join()`)

For each downstream analysis, you will likely use a series of tidying
and transforming steps in various order to get your data in the
appropriate format. Interest of creating dozens of intermediate files
after each step, we will use the `%>%` operator to “pipe” the output of
one function to the input of the other.

Instead of going into each function or each process in detail in
isolation, let’s start with some typical research questions and then
piece together R functions to get the desired information

### Question 1: What are the gene names and Ensemble IDs of the top 20 most differentially expressed genes (DEGs) in the heart tissue between 20-29 and 30-29 year olds?\*\*

To answer this question, we need a subset of information from both the
results and genes files. We need, in no particular order, to: 1. create
a column in results with the gene symbols named “Approved.symbol” 1.
filter the results for genes adj.p.value \< 0.05 (or desired alpha) and
logFC \> 1 or \<-1 1. arrange the results by descending adj.p.value 1.
join the results and genes data frames by “Approved.symbol” 1. select
the gene symbol, name, and ensemble id, lfc, and adj.p.val 1. create
lists of ensemble ideas and gene symbols of DEGs

Let’s go deeper into each step.

#### 1.1 Create (mutate) or rename a column in results with the gene symbols named “Approved.symbol”

Currently, we have “results” with gene symbols as the row names and
“results2” has a column called “X” with the gene symbol. Depending on
which data frame we use, e can either use mutate to create a new column
with the name “Approved.symbol”, or we can rename column X.

``` r
results %>% mutate(Approved.symbol = row.names(.))  
```

    ## # A tibble: 15,529 × 7
    ##      logFC AveExpr      t  P.Value adj.P.Val      B Approved.symbol
    ##      <dbl>   <dbl>  <dbl>    <dbl>     <dbl>  <dbl> <chr>          
    ##  1  0.103    1.35   0.322 0.748       0.875  -5.67  A1BG           
    ##  2  0.136   -0.238  0.640 0.524       0.731  -5.35  A1BG-AS1       
    ##  3 -0.0161   9.80  -0.113 0.910       0.956  -5.96  A2M            
    ##  4  0.605    2.54   3.49  0.000813    0.0555 -0.635 A2M-AS1        
    ##  5  0.354   -1.17   1.08  0.284       0.529  -4.95  A2ML1          
    ##  6  0.658   -0.756  3.26  0.00166     0.0607 -1.36  A2MP1          
    ##  7  0.0655   6.54   0.565 0.574       0.767  -6.07  A4GALT         
    ##  8  0.192    5.48   1.99  0.0504      0.214  -4.37  AAAS           
    ##  9  0.0341   4.51   0.441 0.660       0.823  -6.11  AACS           
    ## 10  0.355    1.88   2.94  0.00432     0.0763 -2.04  AADAT          
    ## # … with 15,519 more rows

#### 1.2 Filter the results for genes adj.p.value \< 0.05 (or desired alpha)

Filter is done in a few different ways depending on the type of
variable. You can use `>` and less `<` to filter greater or less than a
number. `==` and `!=` are used to filter by characters or factors that
match or do not match a specific pattern. `%in% c()` is used to filter
by things in a list. Let’s filter by adjusted p-value. You can use `|`
and `&` to mean “or” or “and”

``` r
results %>% filter(adj.P.Val < 0.05,
                   logFC > 1 | logFC < -1)
```

    ##               logFC    AveExpr         t      P.Value  adj.P.Val          B
    ## ANKRD1    -1.189850 11.5066380 -3.832167 2.605709e-04 0.04495879  0.3442151
    ## C4orf54   -2.236262  3.0509899 -3.625726 5.200638e-04 0.04767478 -0.2579115
    ## FN1       -1.021743  9.5528978 -3.665273 4.563675e-04 0.04759268 -0.1398436
    ## IL1R2     -1.703322  0.7638632 -3.913550 1.972401e-04 0.04456995  0.4781060
    ## KRT80     -1.176516 -1.0145047 -3.714169 3.878470e-04 0.04632981 -0.2947158
    ## LINC00310  1.218272 -1.2321395  4.098561 1.034725e-04 0.04456995  0.6526078
    ## LINC02610  1.185186 -1.0647221  3.942760 1.783369e-04 0.04456995  0.2795004
    ## MTHFD2P1   1.616058 -1.7650730  5.015657 3.394989e-06 0.02636039  2.9968710
    ## NAV2-AS2   1.002273  1.0153707  3.822544 2.692335e-04 0.04495879  0.2476898
    ## PLEKHG4B   1.061661 -1.3135604  3.942497 1.784989e-04 0.04456995  0.2317681
    ## RAD9B     -1.140384  0.3431846 -4.018721 1.369645e-04 0.04456995  0.7204587
    ## RANBP3L    1.044263  0.1329902  3.626793 5.182397e-04 0.04767478 -0.3692743
    ## RXRG       1.088903  2.1133650  4.326187 4.577186e-05 0.04456995  1.8528496
    ## SPRED3    -1.006501 -0.1510558 -3.590380 5.840643e-04 0.04857888 -0.4938726
    ## TNC       -1.642206  4.7894623 -3.699919 4.067330e-04 0.04656770 -0.1151009
    ## TNN        1.724698 -1.6035527  3.634121 5.058730e-04 0.04759268 -0.5822258
    ## TSPEAR     2.161166  1.3779887  3.918461 1.939328e-04 0.04456995  0.5533325
    ## TUBA1C    -1.083854  4.5752140 -4.649841 1.381098e-05 0.04456995  2.9939469

#### 1.3 Arrange the results by adj.p.value, from smallest to largest

We can use the arrange function to reorder observations.

``` r
results %>% arrange(adj.P.Val) 
```

    ##               logFC   AveExpr         t      P.Value  adj.P.Val         B
    ## NMRK1     0.6401956  3.797183  5.387450 7.786610e-07 0.01209183 5.6346663
    ## MTHFD2P1  1.6160575 -1.765073  5.015657 3.394989e-06 0.02636039 2.9968710
    ## AAGAB    -0.4180789  4.886796 -3.988491 1.521860e-04 0.04456995 0.7797524
    ## ABHD14A   0.4435404  4.400213  4.028887 1.321830e-04 0.04456995 0.9225181
    ## ADCY10P1  0.6464649  3.621729  3.915168 1.961445e-04 0.04456995 0.5924164
    ## AJUBA-DT  0.9256980 -1.281389  4.331900 4.483107e-05 0.04456995 1.2622196

Let’s combine the three previous steps into one series of commands and
save the this as a temporary file that we will join with.

    ##               logFC    AveExpr         t      P.Value  adj.P.Val          B
    ## MTHFD2P1   1.616058 -1.7650730  5.015657 3.394989e-06 0.02636039  2.9968710
    ## IL1R2     -1.703322  0.7638632 -3.913550 1.972401e-04 0.04456995  0.4781060
    ## LINC00310  1.218272 -1.2321395  4.098561 1.034725e-04 0.04456995  0.6526078
    ## LINC02610  1.185186 -1.0647221  3.942760 1.783369e-04 0.04456995  0.2795004
    ## PLEKHG4B   1.061661 -1.3135604  3.942497 1.784989e-04 0.04456995  0.2317681
    ## RAD9B     -1.140384  0.3431846 -4.018721 1.369645e-04 0.04456995  0.7204587
    ## RXRG       1.088903  2.1133650  4.326187 4.577186e-05 0.04456995  1.8528496
    ## TSPEAR     2.161166  1.3779887  3.918461 1.939328e-04 0.04456995  0.5533325
    ## TUBA1C    -1.083854  4.5752140 -4.649841 1.381098e-05 0.04456995  2.9939469
    ## ANKRD1    -1.189850 11.5066380 -3.832167 2.605709e-04 0.04495879  0.3442151
    ## NAV2-AS2   1.002273  1.0153707  3.822544 2.692335e-04 0.04495879  0.2476898
    ## KRT80     -1.176516 -1.0145047 -3.714169 3.878470e-04 0.04632981 -0.2947158
    ## TNC       -1.642206  4.7894623 -3.699919 4.067330e-04 0.04656770 -0.1151009
    ## FN1       -1.021743  9.5528978 -3.665273 4.563675e-04 0.04759268 -0.1398436
    ## TNN        1.724698 -1.6035527  3.634121 5.058730e-04 0.04759268 -0.5822258
    ## C4orf54   -2.236262  3.0509899 -3.625726 5.200638e-04 0.04767478 -0.2579115
    ## RANBP3L    1.044263  0.1329902  3.626793 5.182397e-04 0.04767478 -0.3692743
    ## SPRED3    -1.006501 -0.1510558 -3.590380 5.840643e-04 0.04857888 -0.4938726
    ##           Approved.symbol
    ## MTHFD2P1         MTHFD2P1
    ## IL1R2               IL1R2
    ## LINC00310       LINC00310
    ## LINC02610       LINC02610
    ## PLEKHG4B         PLEKHG4B
    ## RAD9B               RAD9B
    ## RXRG                 RXRG
    ## TSPEAR             TSPEAR
    ## TUBA1C             TUBA1C
    ## ANKRD1             ANKRD1
    ## NAV2-AS2         NAV2-AS2
    ## KRT80               KRT80
    ## TNC                   TNC
    ## FN1                   FN1
    ## TNN                   TNN
    ## C4orf54           C4orf54
    ## RANBP3L           RANBP3L
    ## SPRED3             SPRED3

#### 1.4 Join the results and genes data frames by “Approved.symbol”

I find it helpful to import a table of gene names and symbols that can
be merged with other tables with gene information or searched for useful
information. This table of gene names was downloaded from
<https://www.genenames.org/download/custom/>.

In this case, we use `fill = T` to fill missing fields with a NULL
value.

``` r
genes <- read.table("./data/genes.txt", sep = "\t",  header = T, fill = T)
head(genes)
```

    ##      HGNC.ID Approved.symbol
    ## 1     HGNC:5            A1BG
    ## 2 HGNC:37133        A1BG-AS1
    ## 3 HGNC:24086            A1CF
    ## 4     HGNC:6           A1S9T
    ## 5     HGNC:7             A2M
    ## 6 HGNC:27057         A2M-AS1
    ##                                                  Approved.name Chromosome
    ## 1                                       alpha-1-B glycoprotein   19q13.43
    ## 2                                         A1BG antisense RNA 1   19q13.43
    ## 3                               APOBEC1 complementation factor   10q11.23
    ## 4 symbol withdrawn, see [HGNC:12469](/data/gene-symbol-report/           
    ## 5                                        alpha-2-macroglobulin   12p13.31
    ## 6                                          A2M antisense RNA 1   12p13.31
    ##          Accession.numbers NCBI.Gene.ID Ensembl.gene.ID
    ## 1                                     1 ENSG00000121410
    ## 2                 BC040926       503538 ENSG00000268895
    ## 3                 AF271790        29974 ENSG00000148584
    ## 4                                    NA                
    ## 5 BX647329, X68728, M11313            2 ENSG00000175899
    ## 6                                144571 ENSG00000245105
    ##   Mouse.genome.database.ID
    ## 1              MGI:2152878
    ## 2                         
    ## 3              MGI:1917115
    ## 4                         
    ## 5              MGI:2449119
    ## 6

``` r
left_join(resultsDEGs, genes, by =  "Approved.symbol")
```

    ## # A tibble: 18 × 14
    ##    logFC AveExpr     t    P.Value adj.P.Val      B Approved.symbol HGNC.ID   
    ##    <dbl>   <dbl> <dbl>      <dbl>     <dbl>  <dbl> <chr>           <chr>     
    ##  1  1.62  -1.77   5.02 0.00000339    0.0264  3.00  MTHFD2P1        <NA>      
    ##  2 -1.70   0.764 -3.91 0.000197      0.0446  0.478 IL1R2           HGNC:5994 
    ##  3  1.22  -1.23   4.10 0.000103      0.0446  0.653 LINC00310       <NA>      
    ##  4  1.19  -1.06   3.94 0.000178      0.0446  0.280 LINC02610       <NA>      
    ##  5  1.06  -1.31   3.94 0.000178      0.0446  0.232 PLEKHG4B        <NA>      
    ##  6 -1.14   0.343 -4.02 0.000137      0.0446  0.720 RAD9B           <NA>      
    ##  7  1.09   2.11   4.33 0.0000458     0.0446  1.85  RXRG            <NA>      
    ##  8  2.16   1.38   3.92 0.000194      0.0446  0.553 TSPEAR          HGNC:1268 
    ##  9 -1.08   4.58  -4.65 0.0000138     0.0446  2.99  TUBA1C          HGNC:20768
    ## 10 -1.19  11.5   -3.83 0.000261      0.0450  0.344 ANKRD1          HGNC:15819
    ## 11  1.00   1.02   3.82 0.000269      0.0450  0.248 NAV2-AS2        <NA>      
    ## 12 -1.18  -1.01  -3.71 0.000388      0.0463 -0.295 KRT80           <NA>      
    ## 13 -1.64   4.79  -3.70 0.000407      0.0466 -0.115 TNC             HGNC:5318 
    ## 14 -1.02   9.55  -3.67 0.000456      0.0476 -0.140 FN1             <NA>      
    ## 15  1.72  -1.60   3.63 0.000506      0.0476 -0.582 TNN             HGNC:22942
    ## 16 -2.24   3.05  -3.63 0.000520      0.0477 -0.258 C4orf54         HGNC:27741
    ## 17  1.04   0.133  3.63 0.000518      0.0477 -0.369 RANBP3L         <NA>      
    ## 18 -1.01  -0.151 -3.59 0.000584      0.0486 -0.494 SPRED3          HGNC:31041
    ## # … with 6 more variables: Approved.name <chr>, Chromosome <chr>,
    ## #   Accession.numbers <chr>, NCBI.Gene.ID <int>, Ensembl.gene.ID <chr>,
    ## #   Mouse.genome.database.ID <chr>

#### 1.5 Select the gene symbol, name, and ensemble id, lfc, and adj.p.val

By now, our results file is getting quite wide. We can use the
`select()` function to subset data frames by specific column names.

``` r
resultsDEGs %>% select(Approved.symbol, logFC, adj.P.Val)
```

    ##           Approved.symbol     logFC  adj.P.Val
    ## MTHFD2P1         MTHFD2P1  1.616058 0.02636039
    ## IL1R2               IL1R2 -1.703322 0.04456995
    ## LINC00310       LINC00310  1.218272 0.04456995
    ## LINC02610       LINC02610  1.185186 0.04456995
    ## PLEKHG4B         PLEKHG4B  1.061661 0.04456995
    ## RAD9B               RAD9B -1.140384 0.04456995
    ## RXRG                 RXRG  1.088903 0.04456995
    ## TSPEAR             TSPEAR  2.161166 0.04456995
    ## TUBA1C             TUBA1C -1.083854 0.04456995
    ## ANKRD1             ANKRD1 -1.189850 0.04495879
    ## NAV2-AS2         NAV2-AS2  1.002273 0.04495879
    ## KRT80               KRT80 -1.176516 0.04632981
    ## TNC                   TNC -1.642206 0.04656770
    ## FN1                   FN1 -1.021743 0.04759268
    ## TNN                   TNN  1.724698 0.04759268
    ## C4orf54           C4orf54 -2.236262 0.04767478
    ## RANBP3L           RANBP3L  1.044263 0.04767478
    ## SPRED3             SPRED3 -1.006501 0.04857888

Now, let’s combine all five steps into one. However, instead of
rearranging by p-value, let’s arrange by gene symbol. Let’s also convert
this object to a tibble with `as_tibble()` for easier viewing.

``` r
resultsDEGs <- results %>% 
  mutate(Approved.symbol = row.names(.))  %>% 
  filter(adj.P.Val < 0.05,
         logFC > 1 | logFC < -1) %>% 
  arrange(Approved.symbol) %>%
  left_join(., genes, by =  "Approved.symbol") %>% 
  select(Approved.symbol, Ensembl.gene.ID, logFC, adj.P.Val, Approved.name ) %>%
  as_tibble()
resultsDEGs
```

    ## # A tibble: 18 × 5
    ##    Approved.symbol Ensembl.gene.ID logFC adj.P.Val Approved.name                
    ##    <chr>           <chr>           <dbl>     <dbl> <chr>                        
    ##  1 ANKRD1          ENSG00000148677 -1.19    0.0450 ankyrin repeat domain 1      
    ##  2 C4orf54         ENSG00000248713 -2.24    0.0477 chromosome 4 open reading fr…
    ##  3 FN1             <NA>            -1.02    0.0476 <NA>                         
    ##  4 IL1R2           ENSG00000115590 -1.70    0.0446 interleukin 1 receptor type 2
    ##  5 KRT80           <NA>            -1.18    0.0463 <NA>                         
    ##  6 LINC00310       <NA>             1.22    0.0446 <NA>                         
    ##  7 LINC02610       <NA>             1.19    0.0446 <NA>                         
    ##  8 MTHFD2P1        <NA>             1.62    0.0264 <NA>                         
    ##  9 NAV2-AS2        <NA>             1.00    0.0450 <NA>                         
    ## 10 PLEKHG4B        <NA>             1.06    0.0446 <NA>                         
    ## 11 RAD9B           <NA>            -1.14    0.0446 <NA>                         
    ## 12 RANBP3L         <NA>             1.04    0.0477 <NA>                         
    ## 13 RXRG            <NA>             1.09    0.0446 <NA>                         
    ## 14 SPRED3          ENSG00000188766 -1.01    0.0486 sprouty related EVH1 domain …
    ## 15 TNC             ENSG00000041982 -1.64    0.0466 tenascin C                   
    ## 16 TNN             ENSG00000120332  1.72    0.0476 tenascin N                   
    ## 17 TSPEAR          ENSG00000175894  2.16    0.0446 thrombospondin type laminin …
    ## 18 TUBA1C          ENSG00000167553 -1.08    0.0446 tubulin alpha 1c

:::warning

#### Challenge

Replace the input results file with a different file, such as the
results of the comparison of 20-29 and 30-39 year old muscle samples.
What are the deferentially expressed genes?

:::spoiler

resultsDEGs \<- results %>% mutate(Approved.symbol = row.names(.)) %>%
filter(adj.P.Val \< 0.05, logFC \> 1 \| logFC \< -1) %>%
arrange(Approved.symbol) %>% left_join(., genes, by = “Approved.symbol”)
%>% select(Approved.symbol, Ensembl.gene.ID, logFC, adj.P.Val,
Approved.name ) %>% filter(grepl(“ENSG”, Ensembl.gene.ID)) %>%
as_tibble() resultsDEGs

:::

``` r
resultsDEGs <- results %>% 
  mutate(Approved.symbol = row.names(.))  %>% 
  filter(adj.P.Val < 0.05,
         logFC > 1 | logFC < -1) %>% 
  arrange(Approved.symbol) %>%
  left_join(., genes, by =  "Approved.symbol") %>% 
  select(Approved.symbol, Ensembl.gene.ID, logFC, adj.P.Val, Approved.name ) %>%
  filter(grepl("ENSG", Ensembl.gene.ID)) %>%
  as_tibble()
resultsDEGs
```

    ## # A tibble: 8 × 5
    ##   Approved.symbol Ensembl.gene.ID logFC adj.P.Val Approved.name                 
    ##   <chr>           <chr>           <dbl>     <dbl> <chr>                         
    ## 1 ANKRD1          ENSG00000148677 -1.19    0.0450 ankyrin repeat domain 1       
    ## 2 C4orf54         ENSG00000248713 -2.24    0.0477 chromosome 4 open reading fra…
    ## 3 IL1R2           ENSG00000115590 -1.70    0.0446 interleukin 1 receptor type 2 
    ## 4 SPRED3          ENSG00000188766 -1.01    0.0486 sprouty related EVH1 domain c…
    ## 5 TNC             ENSG00000041982 -1.64    0.0466 tenascin C                    
    ## 6 TNN             ENSG00000120332  1.72    0.0476 tenascin N                    
    ## 7 TSPEAR          ENSG00000175894  2.16    0.0446 thrombospondin type laminin G…
    ## 8 TUBA1C          ENSG00000167553 -1.08    0.0446 tubulin alpha 1c

With this exercise, you have explored a few functions related to tidying
and transforming data. Let’s try one more exercise

#### 1.6 Create lists of ensemble ids and gene names of DEGs

``` r
DEGsENSG <- resultsDEGs %>% pull(Ensembl.gene.ID)
DEGsENSG
```

    ## [1] "ENSG00000148677" "ENSG00000248713" "ENSG00000115590" "ENSG00000188766"
    ## [5] "ENSG00000041982" "ENSG00000120332" "ENSG00000175894" "ENSG00000167553"

``` r
DEGsSymbol <- resultsDEGs %>% pull(Approved.symbol)
DEGsSymbol
```

    ## [1] "ANKRD1"  "C4orf54" "IL1R2"   "SPRED3"  "TNC"     "TNN"     "TSPEAR" 
    ## [8] "TUBA1C"

### Question 2: What are the raw counts of the differentially expressed genes?

Most RNA-Seq pipelines require that the counts file to be in a matrix
format where each sample is a column and each gene is a row and all the
values are integers or doubles with all the experimental factors in a
separate file. However, many R tools prefer to have these data combined
in a single, tidy data frame or tibble.

To process the counts data using the DESeq2 pipeline, we need a
corresponding file where the row names are the sample id and they match
the column names of the counts file. We confirm this by asking if
`rownames(colData) == colnames(counts)` or by checking the dimensions of
each. Using `head()` is a good way to only print 5 rows.

``` r
colData <- read.csv("./data/colData.HEART.csv", row.names = 1)
head(colData)
```

    ##                                            SAMPID  SMTS
    ## GTEX-12ZZX-0726-SM-5EGKA GTEX-12ZZX-0726-SM-5EGKA Heart
    ## GTEX-13D11-1526-SM-5J2NA GTEX-13D11-1526-SM-5J2NA Heart
    ## GTEX-ZAJG-0826-SM-5PNVA   GTEX-ZAJG-0826-SM-5PNVA Heart
    ## GTEX-11TT1-1426-SM-5EGIA GTEX-11TT1-1426-SM-5EGIA Heart
    ## GTEX-13VXT-1126-SM-5LU3A GTEX-13VXT-1126-SM-5LU3A Heart
    ## GTEX-14ASI-0826-SM-5Q5EB GTEX-14ASI-0826-SM-5Q5EB Heart
    ##                                             SMTSD     SUBJID    SEX   AGE SMRIN
    ## GTEX-12ZZX-0726-SM-5EGKA Heart - Atrial Appendage GTEX-12ZZX Female 40-49   7.1
    ## GTEX-13D11-1526-SM-5J2NA Heart - Atrial Appendage GTEX-13D11 Female 50-59   8.9
    ## GTEX-ZAJG-0826-SM-5PNVA    Heart - Left Ventricle  GTEX-ZAJG Female 50-59   6.4
    ## GTEX-11TT1-1426-SM-5EGIA Heart - Atrial Appendage GTEX-11TT1   Male 20-29   9.0
    ## GTEX-13VXT-1126-SM-5LU3A   Heart - Left Ventricle GTEX-13VXT Female 20-29   8.6
    ## GTEX-14ASI-0826-SM-5Q5EB Heart - Atrial Appendage GTEX-14ASI   Male 60-69   6.4
    ##                                               DTHHRDY        SRA       DATE
    ## GTEX-12ZZX-0726-SM-5EGKA       Violent and fast death SRR1340617 2013-10-22
    ## GTEX-13D11-1526-SM-5J2NA              Ventilator Case SRR1345436 2013-12-04
    ## GTEX-ZAJG-0826-SM-5PNVA            Intermediate death SRR1367456 2013-10-31
    ## GTEX-11TT1-1426-SM-5EGIA              Ventilator Case SRR1378243 2013-10-24
    ## GTEX-13VXT-1126-SM-5LU3A              Ventilator Case SRR1381693 2013-12-17
    ## GTEX-14ASI-0826-SM-5Q5EB Fast death of natural causes SRR1335164 2014-01-17

``` r
head(rownames(colData) == colnames(counts))
```

    ## [1] FALSE FALSE FALSE FALSE FALSE FALSE

``` r
head(colnames(counts))
```

    ## [1] "GTEX.12ZZX.0726.SM.5EGKA" "GTEX.13D11.1526.SM.5J2NA"
    ## [3] "GTEX.ZAJG.0826.SM.5PNVA"  "GTEX.11TT1.1426.SM.5EGIA"
    ## [5] "GTEX.13VXT.1126.SM.5LU3A" "GTEX.14ASI.0826.SM.5Q5EB"

``` r
head(rownames(colData))
```

    ## [1] "GTEX-12ZZX-0726-SM-5EGKA" "GTEX-13D11-1526-SM-5J2NA"
    ## [3] "GTEX-ZAJG-0826-SM-5PNVA"  "GTEX-11TT1-1426-SM-5EGIA"
    ## [5] "GTEX-13VXT-1126-SM-5LU3A" "GTEX-14ASI-0826-SM-5Q5EB"

The row and col names don’t match because the the dashes were replaced
with periods when the data were imported. This is kind of okay because
`DESeq2` would complain if your colnames had dashes.

We can use `gsub()` to replace the dashes with periods. Then, we rename
the row names. We can use `select(all_of())` to make sure that all the
rows in colData are represented at columns in countData. We could modify
the original files, but since they are so large and importing taking a
long time, I like to save “tidy” versions for downstream analyses.

``` r
colData_tidy <-  colData %>%
  mutate(SAMPID = gsub("-", ".", SAMPID))  
rownames(colData_tidy) <- colData_tidy$SAMPID

mycols <- rownames(colData_tidy)

counts_tidy <- counts %>%
  select(all_of(mycols))

head(rownames(colData_tidy) == colnames(counts_tidy))
```

    ## [1] TRUE TRUE TRUE TRUE TRUE TRUE

I also like to create `counts_tidy_long` file that can be easily subset
by variables or genes of interest. To create this, we need to combine
three data frames: genes, colData (or Samples), and counts.

In this section, we will combine tidying, transforming, and visualizing
to answer the question “What are the raw counts of the deferentially
expressed genes?”

``` r
counts_tidy_long <- counts_tidy %>%
  select(all_of(mycols)) %>%
  mutate(Ensembl.gene.ID = rownames(.)) %>%
  separate(Ensembl.gene.ID, into = c("Ensembl.gene.ID", "version"), 
           sep = "\\.") %>%
  filter(Ensembl.gene.ID %in% all_of(DEGsENSG)) %>%
  pivot_longer(cols = all_of(mycols), names_to = "SAMPID", 
               values_to = "counts") %>%
  inner_join(., colData_tidy, by = "SAMPID") %>%
  arrange(desc(counts)) %>%
  inner_join(., genes, by = "Ensembl.gene.ID") %>%
  select(Ensembl.gene.ID, Approved.name, Approved.symbol, counts, 
         SAMPID, SMTSD, AGE, SEX, DTHHRDY)
```

    ## Warning: Expected 2 pieces. Missing pieces filled with `NA` in 31771 rows [1, 2,
    ## 3, 4, 5, 6, 7, 8, 10, 11, 12, 15, 18, 20, 21, 23, 24, 25, 26, 27, ...].

``` r
head(counts_tidy_long)
```

    ## # A tibble: 6 × 9
    ##   Ensembl.gene.ID Approved.name  Approved.symbol counts SAMPID SMTSD AGE   SEX  
    ##   <chr>           <chr>          <chr>            <dbl> <chr>  <chr> <chr> <chr>
    ## 1 ENSG00000148677 ankyrin repea… ANKRD1          5.54e7 GTEX.… Hear… 20-29 Fema…
    ## 2 ENSG00000148677 ankyrin repea… ANKRD1          5.51e7 GTEX.… Hear… 40-49 Fema…
    ## 3 ENSG00000148677 ankyrin repea… ANKRD1          5.47e7 GTEX.… Hear… 50-59 Male 
    ## 4 ENSG00000148677 ankyrin repea… ANKRD1          5.35e7 GTEX.… Hear… 60-69 Fema…
    ## 5 ENSG00000148677 ankyrin repea… ANKRD1          4.88e7 GTEX.… Hear… 60-69 Fema…
    ## 6 ENSG00000148677 ankyrin repea… ANKRD1          4.87e7 GTEX.… Hear… 40-49 Fema…
    ## # … with 1 more variable: DTHHRDY <chr>

``` r
library(scales)

counts_tidy_long %>%
  ggplot(aes(x = AGE, y = counts)) +
  geom_boxplot() +
  geom_point() +
  facet_wrap(~Approved.symbol, scales = "free_y") +
  scale_y_log10(labels = label_number_si())
```

    ## Warning: Transformation introduced infinite values in continuous y-axis

    ## Warning: Transformation introduced infinite values in continuous y-axis

    ## Warning: Removed 4 rows containing non-finite values (stat_boxplot).

![](./images/boxplot2-1.png)<!-- -->

![](https://i.imgur.com/jvhRnUy.png)

:::warning

#### Challenge

Plot the gene expression of your five favorite genes.

:::spoiler

*Hint: Create a list of your favorite genes. Use the gene Ensemble ides
to get the counts and use the colData or sample information to explore
how age, sex, tissue, and other variable may influence gene expression.*

:::

:::success

#### Key functions: Tidy and Transform

| Function         | Description |
|------------------|-------------|
| `pivot_wider()`  |             |
| `pivot_longer()` |             |
| `separate()`     |             |
| `drop_na()`      |             |
| `select()`       |             |
| `arrange()`      |             |
| `summarize()`    |             |
| `arrange()`      |             |
| `mutate()`       |             |
| `full_join()`    |             |
| `left_join()`    |             |
| `inner_join()`   |             |

:::

## Communicate

### R Markdown

The workshop notes for using this repository to teach an Introduction to
R for RNA-seq are crated with the file `r4rnaseq-workshop.Rmd`.

### References

-   [R for Data Science by Hadley Wickham and Garrett
    Grolemund](https://r4ds.had.co.nz/index.html)
-   [Rouillard et al. 2016. The Harmonizome: a collection of processed
    datasets gathered to serve and mine knowledge about genes and
    proteins. Database
    (Oxford).](http://database.oxfordjournals.org/content/2016/baw100.short)

### Additional Resources

-   [RStudio cheatsheet for
    readr](https://raw.githubusercontent.com/rstudio/cheatsheets/master/data-import.pdf)
-   [RStudio cheatsheet for
    dplyr](https://raw.githubusercontent.com/rstudio/cheatsheets/master/data-transformation.pdf)
-   [RStudio cheatsheet for data Wrangling with
    dplyr](https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf)
-   [ggplot point
    shapes](http://www.sthda.com/english/wiki/ggplot2-point-shapes)
-   [Angus 2019 Intro to R
    Lesson](https://angus.readthedocs.io/en/2019/R_Intro_Lesson.html)
-   [Angus 2019 Differential Gene Expression in R
    Lesson](https://angus.readthedocs.io/en/2019/diff-ex-and-viz.html)
-   [Software Carpentry R
    Lesson](http://swcarpentry.github.io/r-novice-inflammation/)

*Note: the source document
[r4rnaseq-workshop.Rmd](https://github.com/nih-cfde/training-rstudio-binder/blob/data/GTEx/r4rnaseq-workshop.Rmd)
was last modified 14 March, 2022.*

------------------------------------------------------------------------
