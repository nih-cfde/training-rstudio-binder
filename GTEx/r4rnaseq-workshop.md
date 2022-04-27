
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

For today’s lesson, wef will focus on data from the [Gene-Tissue
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
favorite_genes <- c("BRCA1", "JUN",  "GNRH1", "TH", "AR")
favorite_genes
```

    ## [1] "BRCA1" "JUN"   "GNRH1" "TH"    "AR"

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
results <- read.table("./data/GTEx_Heart_20-29_vs_50-59.tsv")
head(results)
```

    ##               logFC    AveExpr         t    P.Value adj.P.Val         B
    ## A1BG     0.67408600  1.6404652 2.1740238 0.03283291 0.1536518 -3.617093
    ## A1BG-AS1 0.23168690 -0.1864802 1.0403316 0.30150123 0.5316030 -4.984225
    ## A2M      0.02453974  9.8251848 0.1948624 0.84602333 0.9215696 -5.783835
    ## A2M-AS1  0.38115436  2.4535892 2.4839630 0.01520646 0.1033370 -3.067127
    ## A2ML1    0.58865741 -1.0412696 1.8263856 0.07173966 0.2328150 -4.065276
    ## A2MP1    0.31631081 -0.8994146 1.4061454 0.16377753 0.3730822 -4.583435

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
  labs(color = "20-29 vs 50-59 year olds", 
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

### Filtering Data

Filter is done in a few different ways depending on the type of
variable. You can use `>` and less `<` to filter greater or less than a
number. `==` and `!=` are used to filter by characters or factors that
match or do not match a specific pattern. `%in% c()` is used to filter
by things in a list. Let’s filter by adjusted p-value. You can use `|`
and `&` to mean “or” or “and”

To explore filtering data, let’s answer the following question: What are
the approved names and symbols of the differentially expressed genes
(DEGs) in the heart tissue between 20-29 and 30-29 year olds? To answer
this question, we need a subset of information from both the results and
genes files. We need, in no particular order, to:

1.  filter by adj.p.value \< 0.05 (or desired alpha)
2.  filter by results by logFC > 1 or \<-1
3.  filter by a list of gene symbols

``` r
results %>% filter(adj.P.Val < 0.05) %>% head()
```

    ##            logFC  AveExpr         t      P.Value  adj.P.Val          B
    ## AAGAB -0.4011097 4.904460 -4.013690 0.0001394737 0.02151260  0.8922610
    ## ABCA6  0.7016965 5.597551  3.502285 0.0007779680 0.03216746 -0.6657214
    ## ABCA9  0.6970969 6.237353  3.114336 0.0026040559 0.04866231 -1.7334759
    ## ABCB7 -0.3708764 5.088921 -3.134484 0.0024510401 0.04755891 -1.6840509
    ## ABCD3 -0.6082187 6.190704 -3.966022 0.0001646305 0.02282632  0.7409476
    ## ABCE1 -0.3764537 5.332213 -3.336582 0.0013173889 0.03802552 -1.1360534

``` r
results %>% filter(logFC > 1 | logFC < -1) %>% head()
```

    ##              logFC   AveExpr         t     P.Value  adj.P.Val          B
    ## ACTA1    -1.358451 10.437939 -2.446102 0.016765666 0.10888918 -3.1289828
    ## ADAMTSL2  1.338257  5.208146  2.900833 0.004871530 0.06245142 -2.2916348
    ## ADH1B     1.259668  7.381462  3.382176 0.001141426 0.03624785 -0.9658612
    ## ADIPOQ   -1.119484  1.117207 -1.720643 0.089405972 0.26371302 -4.3157948
    ## AJAP1     1.010117 -1.212201  2.790425 0.006659281 0.07018819 -2.4766685
    ## ALAS2     1.122494 -1.039829  1.840601 0.069603628 0.22901993 -4.0459220

Sometimes its nice to arrange by pvalue.

``` r
results %>% filter(adj.P.Val < 0.05,
                   logFC > 1 | logFC < -1) %>%
  arrange(adj.P.Val) %>%
  head()
```

    ##                  logFC    AveExpr         t      P.Value    adj.P.Val         B
    ## EDA2R         1.253278  1.0260046  6.019187 5.853141e-08 0.0004544671 6.8806284
    ## PTCHD4        1.962957 -1.7174066  6.067597 4.781186e-08 0.0004544671 5.4766844
    ## BTBD11       -1.194207  0.4506981 -5.289726 1.153068e-06 0.0044764970 4.2906292
    ## MTHFD2P1      1.825674 -1.6578790  5.341073 9.392086e-07 0.0044764970 3.5204863
    ## C4orf54      -2.824211  2.7276196 -4.502382 2.398852e-05 0.0159674585 2.4089730
    ## LOC101929331  1.129013 -1.6306733  4.312543 4.813231e-05 0.0175055847 0.8558573

``` r
resultsDEGs <- results %>% filter(adj.P.Val < 0.05,
                   logFC > 1 | logFC < -1) %>%
  arrange(adj.P.Val) %>% 
  rownames(.)
resultsDEGs
```

    ##  [1] "EDA2R"        "PTCHD4"       "BTBD11"       "MTHFD2P1"     "C4orf54"     
    ##  [6] "LOC101929331" "FMO3"         "KLHL41"       "ETNPPL"       "HOPX"        
    ## [11] "PDIA2"        "RPL10P7"      "FCMR"         "RAD9B"        "LMO3"        
    ## [16] "NXF3"         "FHL1"         "EREG"         "CHMP1B2P"     "MYPN"        
    ## [21] "VIT"          "XIRP1"        "DNASE1L3"     "LIPH"         "PRELP"       
    ## [26] "CSRP3"        "FZD10-AS1"    "LINC02268"    "GDF15"        "PHF21B"      
    ## [31] "CPXM1"        "IL24"         "ADH1B"        "MCF2"         "WWC1"        
    ## [36] "SGPP2"        "COL24A1"      "SEC24AP1"     "ANKRD1"       "CDO1"        
    ## [41] "CCL28"        "SLC5A10"      "XIRP2"

:::warning

#### Challenge

Replace the input results file with a different file, such as the
results of the comparison of 20-29 and 50-59 year old heart samples.
What are the deferentially expressed genes?

:::spoiler

You could use the following code to get this result below


    resultsDEGs2 <- read.table("./data/GTEx_Heart_20-29_vs_50-59.tsv") %>% 
      filter(adj.P.Val < 0.05,
                       logFC > 1 | logFC < -1) %>%
      arrange(adj.P.Val) %>% 
      rownames(.)
    resultsDEGs2

    [1] "EDA2R"        "PTCHD4"       "BTBD11"       "MTHFD2P1"     "C4orf54"      "LOC101929331"
    [7] "FMO3"         "KLHL41"       "ETNPPL"       "HOPX"         "PDIA2"        "RPL10P7"     
    [13] "FCMR"         "RAD9B"        "LMO3"         "NXF3"         "FHL1"         "EREG"        
    [19] "CHMP1B2P"     "MYPN"         "VIT"          "XIRP1"        "DNASE1L3"     "LIPH"        
    [25] "PRELP"        "CSRP3"        "FZD10-AS1"    "LINC02268"    "GDF15"        "PHF21B"      
    [31] "CPXM1"        "IL24"         "ADH1B"        "MCF2"         "WWC1"         "SGPP2"       
    [37] "COL24A1"      "SEC24AP1"     "ANKRD1"       "CDO1"         "CCL28"        "SLC5A10"     
    [43] "XIRP2" 

:::

### Mutating Data

Most RNA-Seq pipelines require that the counts file to be in a matrix
format where each sample is a column and each gene is a row and all the
values are integers or doubles with all the experimental factors in a
separate file. More over, we need a corresponding file where the row
names are the sample id and they match the column names of the counts
file.

When you type `rownames(colData) == colnames(counts)` you should see
many TRUE statments. If the answer if FALSE your data cannot be
processed by downstream tools.

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
`DESeq2` would complain if your colnames had dashes. We can use `gsub()`
to replace the dashes with periods.

``` r
colData_tidy <-  colData %>%
  mutate(SAMPID = gsub("-", ".", SAMPID))  
rownames(colData_tidy) <- colData_tidy$SAMPID

mycols <- rownames(colData_tidy)
head(mycols)
```

    ## [1] "GTEX.12ZZX.0726.SM.5EGKA" "GTEX.13D11.1526.SM.5J2NA"
    ## [3] "GTEX.ZAJG.0826.SM.5PNVA"  "GTEX.11TT1.1426.SM.5EGIA"
    ## [5] "GTEX.13VXT.1126.SM.5LU3A" "GTEX.14ASI.0826.SM.5Q5EB"

Then, we rename the row names. We can use `select(all_of())` to make
sure that all the rows in colData are represented at columns in
countData. We could modify the original files, but since they are so
large and importing taking a long time, I like to save “tidy” versions
for downstream analyses.

``` r
counts_tidy <- counts %>%
  select(all_of(mycols))

head(rownames(colData_tidy) == colnames(counts_tidy))
```

    ## [1] TRUE TRUE TRUE TRUE TRUE TRUE

### Joining Data

Genes can be identified by their name, their symbol, an Ensemble ID, or
any number of other identifiers. Our results file uses gene symbols, but
our counts file uses Ensemble IDs.

Let’s read a file called “genes.txt” and combine this with our results
file so that we have gene symbols, names, and ids, alongside with the
p-values and other statistics.

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

The column with genes symbols is called `Approved.symbol`. To combine
this data frame without results. We can use the mutate function to
create a new column based off the row names. Let’s save this as
`resultsSymbol`.

``` r
resultsSymbol <- results %>%
  mutate(Approved.symbol = row.names(.))
head(resultsSymbol)
```

    ##               logFC    AveExpr         t    P.Value adj.P.Val         B
    ## A1BG     0.67408600  1.6404652 2.1740238 0.03283291 0.1536518 -3.617093
    ## A1BG-AS1 0.23168690 -0.1864802 1.0403316 0.30150123 0.5316030 -4.984225
    ## A2M      0.02453974  9.8251848 0.1948624 0.84602333 0.9215696 -5.783835
    ## A2M-AS1  0.38115436  2.4535892 2.4839630 0.01520646 0.1033370 -3.067127
    ## A2ML1    0.58865741 -1.0412696 1.8263856 0.07173966 0.2328150 -4.065276
    ## A2MP1    0.31631081 -0.8994146 1.4061454 0.16377753 0.3730822 -4.583435
    ##          Approved.symbol
    ## A1BG                A1BG
    ## A1BG-AS1        A1BG-AS1
    ## A2M                  A2M
    ## A2M-AS1          A2M-AS1
    ## A2ML1              A2ML1
    ## A2MP1              A2MP1

Now, we can use one of the join functions to combine two data frames.
`left_join` will return all records from the left table and any matching
values from the right. `right_join` will return all values from the
right table and any matching values from the left. `inner_join` will
return records that have values in both tables. `full_join` will return
everything.

``` r
resultsName <- left_join(resultsSymbol, genes, by = "Approved.symbol")
head(resultsName)
```

    ##        logFC    AveExpr         t    P.Value adj.P.Val         B
    ## 1 0.67408600  1.6404652 2.1740238 0.03283291 0.1536518 -3.617093
    ## 2 0.23168690 -0.1864802 1.0403316 0.30150123 0.5316030 -4.984225
    ## 3 0.02453974  9.8251848 0.1948624 0.84602333 0.9215696 -5.783835
    ## 4 0.38115436  2.4535892 2.4839630 0.01520646 0.1033370 -3.067127
    ## 5 0.58865741 -1.0412696 1.8263856 0.07173966 0.2328150 -4.065276
    ## 6 0.31631081 -0.8994146 1.4061454 0.16377753 0.3730822 -4.583435
    ##   Approved.symbol    HGNC.ID                      Approved.name Chromosome
    ## 1            A1BG     HGNC:5             alpha-1-B glycoprotein   19q13.43
    ## 2        A1BG-AS1 HGNC:37133               A1BG antisense RNA 1   19q13.43
    ## 3             A2M     HGNC:7              alpha-2-macroglobulin   12p13.31
    ## 4         A2M-AS1 HGNC:27057                A2M antisense RNA 1   12p13.31
    ## 5           A2ML1 HGNC:23336       alpha-2-macroglobulin like 1   12p13.31
    ## 6           A2MP1     HGNC:8 alpha-2-macroglobulin pseudogene 1   12p13.31
    ##          Accession.numbers NCBI.Gene.ID Ensembl.gene.ID
    ## 1                                     1 ENSG00000121410
    ## 2                 BC040926       503538 ENSG00000268895
    ## 3 BX647329, X68728, M11313            2 ENSG00000175899
    ## 4                                144571 ENSG00000245105
    ## 5                 AK057908       144568 ENSG00000166535
    ## 6                   M24415            3 ENSG00000256069
    ##   Mouse.genome.database.ID
    ## 1              MGI:2152878
    ## 2                         
    ## 3              MGI:2449119
    ## 4                         
    ## 5                         
    ## 6

Congratulations! You have successfully joined two tables. Now, you can
filter and select columsn to make a pretty table of the DEGS.

.

``` r
resultsNameTidy <- resultsName %>%
  filter(adj.P.Val < 0.05,
                   logFC > 1 | logFC < -1) %>%
  arrange(adj.P.Val) %>%
  select(Approved.symbol, Approved.name, Ensembl.gene.ID, logFC, AveExpr, adj.P.Val)
head(resultsNameTidy)
```

    ##   Approved.symbol                      Approved.name Ensembl.gene.ID     logFC
    ## 1           EDA2R                               <NA>            <NA>  1.253278
    ## 2          PTCHD4                               <NA>            <NA>  1.962957
    ## 3          BTBD11           BTB domain containing 11 ENSG00000151136 -1.194207
    ## 4        MTHFD2P1                               <NA>            <NA>  1.825674
    ## 5         C4orf54 chromosome 4 open reading frame 54 ENSG00000248713 -2.824211
    ## 6    LOC101929331                               <NA>            <NA>  1.129013
    ##      AveExpr    adj.P.Val
    ## 1  1.0260046 0.0004544671
    ## 2 -1.7174066 0.0004544671
    ## 3  0.4506981 0.0044764970
    ## 4 -1.6578790 0.0044764970
    ## 5  2.7276196 0.0159674585
    ## 6 -1.6306733 0.0175055847

### Lengthen data

The matrix form of the count data is required for some pipelines, but
many R programs are better suited to data in a long format where each
row is an observation. I like to create `counts_tidy_long` file that can
be easily subset by variables or genes of interest.

Because the count files are so large, it is good to filter the counts
first. I’ll filter by `rowSums(.) > 0` and then take the top 6 with
`head()`. Then crate a column for lengthening.

``` r
counts_tidy_slim <- counts_tidy %>%
  filter(rowSums(.) >0 ) %>%
  head() %>%
  mutate(Ensembl.gene.ID = row.names(.) )
head(counts_tidy_slim)
```

    ##                   GTEX.12ZZX.0726.SM.5EGKA GTEX.13D11.1526.SM.5J2NA
    ## ENSG00000223972.5                      630                      877
    ## ENSG00000278267                       1686                     1467
    ## ENSG00000227232.5                    60803                    59166
    ## ENSG00000284332                          0                        0
    ## ENSG00000243485.5                      459                      356
    ## ENSG00000237613.2                      717                        0
    ##                   GTEX.ZAJG.0826.SM.5PNVA GTEX.11TT1.1426.SM.5EGIA
    ## ENSG00000223972.5                    1211                      344
    ## ENSG00000278267                      3369                      675
    ## ENSG00000227232.5                   71878                    37289
    ## ENSG00000284332                         0                        0
    ## ENSG00000243485.5                     192                      237
    ## ENSG00000237613.2                     303                        0
    ##                   GTEX.13VXT.1126.SM.5LU3A GTEX.14ASI.0826.SM.5Q5EB
    ## ENSG00000223972.5                       76                      895
    ## ENSG00000278267                       1198                     4366
    ## ENSG00000227232.5                    43725                   132414
    ## ENSG00000284332                         76                        0
    ## ENSG00000243485.5                      288                      321
    ## ENSG00000237613.2                      252                      197
    ##                   GTEX.ZF3C.1226.SM.4WWCB GTEX.Y8E4.0426.SM.4V6GB
    ## ENSG00000223972.5                     410                    1537
    ## ENSG00000278267                      1118                    1890
    ## ENSG00000227232.5                   23798                   85542
    ## ENSG00000284332                         0                      26
    ## ENSG00000243485.5                       0                    1092
    ## ENSG00000237613.2                     442                     893
    ##                   GTEX.13PVR.0926.SM.5S2RB GTEX.12BJ1.0326.SM.5FQUB
    ## ENSG00000223972.5                      141                      641
    ## ENSG00000278267                        491                      898
    ## ENSG00000227232.5                    26076                    41829
    ## ENSG00000284332                          0                        0
    ## ENSG00000243485.5                        0                      640
    ## ENSG00000237613.2                        0                       72
    ##                   GTEX.131XH.0226.SM.5LZVB GTEX.11O72.1026.SM.5986B
    ## ENSG00000223972.5                       96                     1042
    ## ENSG00000278267                        528                     1364
    ## ENSG00000227232.5                    28702                    54898
    ## ENSG00000284332                          0                       72
    ## ENSG00000243485.5                        0                      193
    ## ENSG00000237613.2                      152                      152
    ##                   GTEX.12WSG.1226.SM.5EQ4C GTEX.13PVQ.1226.SM.5IJDC
    ## ENSG00000223972.5                     1388                      488
    ## ENSG00000278267                       1251                      928
    ## ENSG00000227232.5                    52926                    37577
    ## ENSG00000284332                          0                        0
    ## ENSG00000243485.5                      296                       97
    ## ENSG00000237613.2                      121                      123
    ##                   GTEX.13112.0426.SM.5PNVC GTEX.139TU.1926.SM.5J2OC
    ## ENSG00000223972.5                      482                      272
    ## ENSG00000278267                        878                     2244
    ## ENSG00000227232.5                    41619                    66069
    ## ENSG00000284332                          0                        0
    ## ENSG00000243485.5                      580                        0
    ## ENSG00000237613.2                      423                        0
    ##                   GTEX.1399U.0726.SM.5KM1D GTEX.ZE7O.0626.SM.57WCD
    ## ENSG00000223972.5                      353                     513
    ## ENSG00000278267                       1007                    3521
    ## ENSG00000227232.5                    37741                   93746
    ## ENSG00000284332                          0                       0
    ## ENSG00000243485.5                      427                     422
    ## ENSG00000237613.2                      172                     548
    ##                   GTEX.13OVG.0526.SM.5K7YD GTEX.11LCK.0826.SM.5PNYD
    ## ENSG00000223972.5                      441                      269
    ## ENSG00000278267                       1908                      714
    ## ENSG00000227232.5                    52511                    54655
    ## ENSG00000284332                          0                        0
    ## ENSG00000243485.5                      559                      767
    ## ENSG00000237613.2                      293                        0
    ##                   GTEX.11ZVC.0426.SM.5CVLD GTEX.13W3W.0426.SM.5SI9D
    ## ENSG00000223972.5                      720                      659
    ## ENSG00000278267                       2032                     1398
    ## ENSG00000227232.5                    53362                    54876
    ## ENSG00000284332                          0                        0
    ## ENSG00000243485.5                      143                        0
    ## ENSG00000237613.2                      347                        0
    ##                   GTEX.146FR.0926.SM.5QGPE GTEX.ZVT2.0926.SM.5GICE
    ## ENSG00000223972.5                     2194                     334
    ## ENSG00000278267                        893                     991
    ## ENSG00000227232.5                    51118                   35589
    ## ENSG00000284332                          0                       0
    ## ENSG00000243485.5                      187                     252
    ## ENSG00000237613.2                      152                       0
    ##                   GTEX.13O3Q.0326.SM.5L3FE GTEX.14E6C.0326.SM.5Q5EE
    ## ENSG00000223972.5                      107                      573
    ## ENSG00000278267                       2047                      998
    ## ENSG00000227232.5                    66816                    56020
    ## ENSG00000284332                          0                        0
    ## ENSG00000243485.5                        0                      188
    ## ENSG00000237613.2                        0                        0
    ##                   GTEX.131XG.0526.SM.5DUWF GTEX.1445S.1226.SM.5O9BF
    ## ENSG00000223972.5                     1674                     2611
    ## ENSG00000278267                        738                     2498
    ## ENSG00000227232.5                    27318                    92360
    ## ENSG00000284332                          0                      131
    ## ENSG00000243485.5                      444                      284
    ## ENSG00000237613.2                      152                      448
    ##                   GTEX.13FHO.1226.SM.5L3EF GTEX.YEC4.0226.SM.4W1YG
    ## ENSG00000223972.5                       80                    1066
    ## ENSG00000278267                       1369                    1168
    ## ENSG00000227232.5                    47183                   63275
    ## ENSG00000284332                          0                     124
    ## ENSG00000243485.5                      133                     601
    ## ENSG00000237613.2                      304                       0
    ##                   GTEX.ZF3C.1126.SM.57WEG GTEX.12WSC.1126.SM.5EQ4G
    ## ENSG00000223972.5                    1442                      603
    ## ENSG00000278267                      2488                     1946
    ## ENSG00000227232.5                   63045                    68070
    ## ENSG00000284332                        76                        0
    ## ENSG00000243485.5                     152                      116
    ## ENSG00000237613.2                     304                      510
    ##                   GTEX.YECK.1226.SM.4W21G GTEX.ZAB5.0226.SM.5CVMH
    ## ENSG00000223972.5                    3423                    1073
    ## ENSG00000278267                      3908                     994
    ## ENSG00000227232.5                   82557                   40959
    ## ENSG00000284332                         0                      76
    ## ENSG00000243485.5                     411                     150
    ## ENSG00000237613.2                     304                       0
    ##                   GTEX.12WSN.0226.SM.5DUXH GTEX.ZF2S.0826.SM.4WWBI
    ## ENSG00000223972.5                      597                     644
    ## ENSG00000278267                        717                    1548
    ## ENSG00000227232.5                    32841                   57455
    ## ENSG00000284332                          0                       0
    ## ENSG00000243485.5                      393                    1068
    ## ENSG00000237613.2                        0                     409
    ##                   GTEX.ZYWO.0526.SM.5E45I GTEX.12696.1126.SM.5FQTI
    ## ENSG00000223972.5                    1222                      874
    ## ENSG00000278267                      1556                      780
    ## ENSG00000227232.5                   48237                    32904
    ## ENSG00000284332                         0                        0
    ## ENSG00000243485.5                     152                      392
    ## ENSG00000237613.2                     152                        0
    ##                   GTEX.ZPIC.0826.SM.4WWFJ GTEX.132NY.1426.SM.5J1MJ
    ## ENSG00000223972.5                    1443                     1856
    ## ENSG00000278267                      1694                     2416
    ## ENSG00000227232.5                   55941                    80085
    ## ENSG00000284332                         0                        0
    ## ENSG00000243485.5                     152                      117
    ## ENSG00000237613.2                       0                     1282
    ##                   GTEX.12WSI.0426.SM.5EQ5J GTEX.14C39.0726.SM.5RQIK
    ## ENSG00000223972.5                      255                       21
    ## ENSG00000278267                       1042                     1275
    ## ENSG00000227232.5                    39516                    51074
    ## ENSG00000284332                          0                        0
    ## ENSG00000243485.5                      152                      420
    ## ENSG00000237613.2                        0                        0
    ##                   GTEX.12ZZY.1226.SM.5GCNK GTEX.13S86.0326.SM.5SI6K
    ## ENSG00000223972.5                      839                        7
    ## ENSG00000278267                       1329                     2616
    ## ENSG00000227232.5                    50740                    64818
    ## ENSG00000284332                          0                       76
    ## ENSG00000243485.5                      497                      556
    ## ENSG00000237613.2                      268                      117
    ##                   GTEX.ZDYS.0226.SM.5HL4K GTEX.ZUA1.0826.SM.4YCDL
    ## ENSG00000223972.5                     822                     698
    ## ENSG00000278267                       723                    1474
    ## ENSG00000227232.5                   41605                   29677
    ## ENSG00000284332                         0                       0
    ## ENSG00000243485.5                     328                       0
    ## ENSG00000237613.2                       0                      61
    ##                   GTEX.1497J.1226.SM.5Q5BL GTEX.13OW6.1126.SM.5L3HL
    ## ENSG00000223972.5                      299                     1204
    ## ENSG00000278267                       1605                     1405
    ## ENSG00000227232.5                    49739                    34011
    ## ENSG00000284332                          0                        0
    ## ENSG00000243485.5                      115                      297
    ## ENSG00000237613.2                        0                      507
    ##                   GTEX.13OW6.0926.SM.5L3GM GTEX.1269C.0826.SM.5N9EM
    ## ENSG00000223972.5                      786                      854
    ## ENSG00000278267                        786                     1334
    ## ENSG00000227232.5                    41270                    41473
    ## ENSG00000284332                          0                        0
    ## ENSG00000243485.5                        0                        0
    ## ENSG00000237613.2                      304                      152
    ##                   GTEX.12ZZW.1026.SM.5GCMM GTEX.11GSP.1226.SM.5985M
    ## ENSG00000223972.5                      627                      815
    ## ENSG00000278267                       2370                      520
    ## ENSG00000227232.5                    69777                    41110
    ## ENSG00000284332                          0                        0
    ## ENSG00000243485.5                        0                        0
    ## ENSG00000237613.2                     1012                      152
    ##                   GTEX.ZPU1.0626.SM.4YCDM GTEX.11TT1.1326.SM.5PNYM
    ## ENSG00000223972.5                    1400                       50
    ## ENSG00000278267                       977                      748
    ## ENSG00000227232.5                   35600                    40391
    ## ENSG00000284332                         0                        0
    ## ENSG00000243485.5                       0                      138
    ## ENSG00000237613.2                       0                        0
    ##                   GTEX.12696.1226.SM.5FQSM GTEX.1117F.0726.SM.5GIEN
    ## ENSG00000223972.5                     1145                      467
    ## ENSG00000278267                       2190                     2311
    ## ENSG00000227232.5                    67394                    79496
    ## ENSG00000284332                          0                        0
    ## ENSG00000243485.5                      330                        0
    ## ENSG00000237613.2                        0                      281
    ##                   GTEX.ZEX8.0426.SM.4WWEN GTEX.YF7O.0526.SM.5P9IO
    ## ENSG00000223972.5                     578                     548
    ## ENSG00000278267                      1148                     696
    ## ENSG00000227232.5                   32639                   42418
    ## ENSG00000284332                         0                       0
    ## ENSG00000243485.5                     372                     388
    ## ENSG00000237613.2                     152                       0
    ##                   GTEX.11EMC.0726.SM.5EGJO GTEX.13NYB.0326.SM.5IJDP
    ## ENSG00000223972.5                      537                      284
    ## ENSG00000278267                       2830                     2018
    ## ENSG00000227232.5                    71061                    70303
    ## ENSG00000284332                          0                        0
    ## ENSG00000243485.5                        0                      132
    ## ENSG00000237613.2                        0                        0
    ##                   GTEX.11DYG.1026.SM.5A5JQ GTEX.117XS.0726.SM.5H131
    ## ENSG00000223972.5                      691                     1051
    ## ENSG00000278267                       1973                     1883
    ## ENSG00000227232.5                    82730                    64754
    ## ENSG00000284332                          0                       32
    ## ENSG00000243485.5                      469                      243
    ## ENSG00000237613.2                      783                      799
    ##                   GTEX.13OVL.0526.SM.5KLZQ GTEX.13FTZ.0326.SM.5J1O1
    ## ENSG00000223972.5                     2616                     1394
    ## ENSG00000278267                       1151                     4069
    ## ENSG00000227232.5                    56298                   136022
    ## ENSG00000284332                          0                        0
    ## ENSG00000243485.5                      197                      396
    ## ENSG00000237613.2                      830                      666
    ##                   GTEX.11DXY.0826.SM.5EGGR GTEX.11O72.1126.SM.5N9E2
    ## ENSG00000223972.5                      358                     1814
    ## ENSG00000278267                        770                     3041
    ## ENSG00000227232.5                    26706                    94534
    ## ENSG00000284332                          0                        0
    ## ENSG00000243485.5                      406                        0
    ## ENSG00000237613.2                      359                        0
    ##                   GTEX.111YS.0326.SM.5GZZ3 GTEX.11P81.0526.SM.59873
    ## ENSG00000223972.5                      138                     1087
    ## ENSG00000278267                        554                     1261
    ## ENSG00000227232.5                    29851                    42401
    ## ENSG00000284332                          0                        0
    ## ENSG00000243485.5                        0                      540
    ## ENSG00000237613.2                        0                        0
    ##                   GTEX.YF7O.0426.SM.5P9FS GTEX.1192W.0226.SM.5EGGT
    ## ENSG00000223972.5                    1580                      539
    ## ENSG00000278267                       855                     1795
    ## ENSG00000227232.5                   47181                    53698
    ## ENSG00000284332                         0                        0
    ## ENSG00000243485.5                     106                      147
    ## ENSG00000237613.2                     347                      304
    ##                   GTEX.13NZB.0226.SM.5KM1T GTEX.13OVG.0426.SM.5KM2T
    ## ENSG00000223972.5                     1080                      996
    ## ENSG00000278267                       2583                     1359
    ## ENSG00000227232.5                    56972                    76616
    ## ENSG00000284332                          0                        0
    ## ENSG00000243485.5                        0                      277
    ## ENSG00000237613.2                      304                      130
    ##                   GTEX.11I78.0826.SM.5A5K4 GTEX.13O3P.1426.SM.5L3DT
    ## ENSG00000223972.5                      762                      301
    ## ENSG00000278267                       1001                     1189
    ## ENSG00000227232.5                    39841                    44451
    ## ENSG00000284332                          0                        0
    ## ENSG00000243485.5                        0                      103
    ## ENSG00000237613.2                        0                        0
    ##                   GTEX.13N1W.1026.SM.5IJC5 GTEX.13O1R.1226.SM.5J1NU
    ## ENSG00000223972.5                      165                      375
    ## ENSG00000278267                        734                      679
    ## ENSG00000227232.5                    36791                    48960
    ## ENSG00000284332                          0                        0
    ## ENSG00000243485.5                      271                      317
    ## ENSG00000237613.2                        0                        0
    ##                   GTEX.13CF2.0226.SM.5L3DV GTEX.1122O.0826.SM.5GICV
    ## ENSG00000223972.5                      991                     1172
    ## ENSG00000278267                       2781                      730
    ## ENSG00000227232.5                    73185                    28461
    ## ENSG00000284332                        150                       17
    ## ENSG00000243485.5                      645                      373
    ## ENSG00000237613.2                      162                      149
    ##                   GTEX.14C5O.1326.SM.5S2UW GTEX.12WS9.0826.SM.59HJX
    ## ENSG00000223972.5                      405                     2288
    ## ENSG00000278267                       1472                     4110
    ## ENSG00000227232.5                    26667                    99074
    ## ENSG00000284332                          0                        0
    ## ENSG00000243485.5                      254                      226
    ## ENSG00000237613.2                        0                      284
    ##                   GTEX.11GSP.1326.SM.5A5KY GTEX.1399S.1026.SM.5KLZ9
    ## ENSG00000223972.5                      712                      904
    ## ENSG00000278267                        858                     1356
    ## ENSG00000227232.5                    29090                    35492
    ## ENSG00000284332                          0                        0
    ## ENSG00000243485.5                      304                      422
    ## ENSG00000237613.2                      822                        0
    ##                   GTEX.1339X.0426.SM.5KLZY GTEX.Y5V5.0726.SM.4VBPY
    ## ENSG00000223972.5                      131                     863
    ## ENSG00000278267                        399                    2764
    ## ENSG00000227232.5                    26397                   67715
    ## ENSG00000284332                          0                       0
    ## ENSG00000243485.5                        0                     124
    ## ENSG00000237613.2                        0                     172
    ##                   GTEX.13FLV.0926.SM.5L3DZ GTEX.14C38.1426.SM.5RQHZ
    ## ENSG00000223972.5                      431                      932
    ## ENSG00000278267                       2505                     1249
    ## ENSG00000227232.5                    84335                    47728
    ## ENSG00000284332                          0                        0
    ## ENSG00000243485.5                      322                      107
    ## ENSG00000237613.2                      288                        0
    ##                   GTEX.117YW.0426.SM.5GZZZ GTEX.ZZPT.0926.SM.5GICZ
    ## ENSG00000223972.5                      320                    2225
    ## ENSG00000278267                       1515                    4750
    ## ENSG00000227232.5                    39929                   83412
    ## ENSG00000284332                          0                       0
    ## ENSG00000243485.5                      145                     259
    ## ENSG00000237613.2                      151                     408
    ##                   GTEX.11ZTT.0526.SM.5EQLA GTEX.12WSK.0526.SM.5CVNA
    ## ENSG00000223972.5                      719                        0
    ## ENSG00000278267                       1031                      574
    ## ENSG00000227232.5                    55059                    43612
    ## ENSG00000284332                          4                        0
    ## ENSG00000243485.5                      297                        0
    ## ENSG00000237613.2                      123                        0
    ##                   GTEX.1212Z.0626.SM.5FQTB GTEX.ZAJG.0926.SM.5Q5AB
    ## ENSG00000223972.5                     1082                     292
    ## ENSG00000278267                       1529                    2844
    ## ENSG00000227232.5                    42642                   79330
    ## ENSG00000284332                          0                       0
    ## ENSG00000243485.5                        0                     122
    ## ENSG00000237613.2                      103                     215
    ##                   GTEX.13NYS.1926.SM.5IJCB GTEX.ZV7C.0526.SM.51MRB
    ## ENSG00000223972.5                      860                     279
    ## ENSG00000278267                       2537                     698
    ## ENSG00000227232.5                    64717                   33257
    ## ENSG00000284332                          0                       0
    ## ENSG00000243485.5                      152                     328
    ## ENSG00000237613.2                      383                       0
    ##                   GTEX.13JUV.0226.SM.5IJCC GTEX.11DXX.0326.SM.5PNWC
    ## ENSG00000223972.5                      317                      478
    ## ENSG00000278267                       2172                      425
    ## ENSG00000227232.5                    76096                    27975
    ## ENSG00000284332                         25                        0
    ## ENSG00000243485.5                      148                        0
    ## ENSG00000237613.2                      233                        0
    ##                   GTEX.13O3O.1526.SM.5KM1C GTEX.11TUW.1026.SM.5GU7D
    ## ENSG00000223972.5                      409                      607
    ## ENSG00000278267                       1315                     1661
    ## ENSG00000227232.5                    39152                    79496
    ## ENSG00000284332                          0                        0
    ## ENSG00000243485.5                       37                      106
    ## ENSG00000237613.2                        0                        0
    ##                   GTEX.13U4I.0826.SM.5SIBD GTEX.13VXT.0726.SM.5SIAD
    ## ENSG00000223972.5                      235                      571
    ## ENSG00000278267                       1251                     2409
    ## ENSG00000227232.5                    46598                    68250
    ## ENSG00000284332                          0                        0
    ## ENSG00000243485.5                       57                      136
    ## ENSG00000237613.2                      247                      337
    ##                   GTEX.11GS4.0426.SM.5N9CD GTEX.13X6H.0426.SM.5LU4E
    ## ENSG00000223972.5                      782                      826
    ## ENSG00000278267                       3242                     1423
    ## ENSG00000227232.5                    60899                    40303
    ## ENSG00000284332                          0                        0
    ## ENSG00000243485.5                        0                        0
    ## ENSG00000237613.2                     1443                      301
    ##                   GTEX.YB5K.0226.SM.5IFJE GTEX.ZVT4.1326.SM.5NQ8E
    ## ENSG00000223972.5                    1519                    1285
    ## ENSG00000278267                      1751                    2432
    ## ENSG00000227232.5                   56198                   68233
    ## ENSG00000284332                        74                       0
    ## ENSG00000243485.5                     879                       0
    ## ENSG00000237613.2                       0                     816
    ##                   GTEX.ZYVF.1826.SM.5E44F GTEX.146FH.1026.SM.5RQIF
    ## ENSG00000223972.5                     576                      873
    ## ENSG00000278267                      2273                     1881
    ## ENSG00000227232.5                   80997                    60689
    ## ENSG00000284332                         0                       76
    ## ENSG00000243485.5                     199                      539
    ## ENSG00000237613.2                     420                      415
    ##                   GTEX.ZT9W.0526.SM.57WFG GTEX.139YR.0526.SM.5L3DG
    ## ENSG00000223972.5                      68                      938
    ## ENSG00000278267                      1412                     1052
    ## ENSG00000227232.5                   44735                    35541
    ## ENSG00000284332                         0                        0
    ## ENSG00000243485.5                      76                       61
    ## ENSG00000237613.2                       0                      271
    ##                   GTEX.14BIM.2726.SM.5Q5EG GTEX.145LV.0226.SM.5S2QG
    ## ENSG00000223972.5                      433                      272
    ## ENSG00000278267                       2310                     1377
    ## ENSG00000227232.5                    75531                    29140
    ## ENSG00000284332                          0                        0
    ## ENSG00000243485.5                       11                      116
    ## ENSG00000237613.2                      408                        0
    ##                   GTEX.145MN.0626.SM.5QGRH GTEX.12WSG.0526.SM.5FQTH
    ## ENSG00000223972.5                      148                     1832
    ## ENSG00000278267                        906                     1872
    ## ENSG00000227232.5                    33014                    64898
    ## ENSG00000284332                         32                        0
    ## ENSG00000243485.5                      335                      381
    ## ENSG00000237613.2                      152                      152
    ##                   GTEX.13CF2.0426.SM.5KM1H GTEX.13OW7.1626.SM.5IJDH
    ## ENSG00000223972.5                      624                      720
    ## ENSG00000278267                       1448                     1425
    ## ENSG00000227232.5                    42110                    55313
    ## ENSG00000284332                          0                       71
    ## ENSG00000243485.5                      174                      281
    ## ENSG00000237613.2                      349                      204
    ##                   GTEX.117YX.0626.SM.5EGJI GTEX.13PL6.0826.SM.5IJBI
    ## ENSG00000223972.5                      239                     1041
    ## ENSG00000278267                       1377                     3171
    ## ENSG00000227232.5                    37951                    83566
    ## ENSG00000284332                         57                        0
    ## ENSG00000243485.5                      402                      239
    ## ENSG00000237613.2                      245                      652
    ##                   GTEX.11WQK.0226.SM.5EQLI GTEX.11TUW.1126.SM.5EQKJ
    ## ENSG00000223972.5                     1931                     1374
    ## ENSG00000278267                       2041                     2696
    ## ENSG00000227232.5                    62125                    76962
    ## ENSG00000284332                          0                        0
    ## ENSG00000243485.5                      129                      300
    ## ENSG00000237613.2                        0                       65
    ##                   GTEX.12WSK.0626.SM.5LZUJ GTEX.13S86.0226.SM.5S2PJ
    ## ENSG00000223972.5                      186                      157
    ## ENSG00000278267                       1325                      819
    ## ENSG00000227232.5                    54080                    26069
    ## ENSG00000284332                          0                        0
    ## ENSG00000243485.5                      278                       15
    ## ENSG00000237613.2                      152                      334
    ##                   GTEX.YFC4.0426.SM.4TT3J GTEX.13PVQ.1326.SM.5LU4J
    ## ENSG00000223972.5                     185                      550
    ## ENSG00000278267                      2965                     1015
    ## ENSG00000227232.5                  108293                    50445
    ## ENSG00000284332                         0                        0
    ## ENSG00000243485.5                     109                      105
    ## ENSG00000237613.2                     274                       76
    ##                   GTEX.1399R.1726.SM.5K7YJ GTEX.132NY.1726.SM.5EGKK
    ## ENSG00000223972.5                      346                     2362
    ## ENSG00000278267                       1621                     1510
    ## ENSG00000227232.5                    37309                    56336
    ## ENSG00000284332                         33                       76
    ## ENSG00000243485.5                      111                      645
    ## ENSG00000237613.2                      255                        0
    ##                   GTEX.ZYWO.0626.SM.5E45K GTEX.ZLFU.0326.SM.4WWBK
    ## ENSG00000223972.5                    1258                    1225
    ## ENSG00000278267                      1726                    1890
    ## ENSG00000227232.5                   55290                   43783
    ## ENSG00000284332                         0                       7
    ## ENSG00000243485.5                     165                     631
    ## ENSG00000237613.2                     152                     152
    ##                   GTEX.ZDTT.0726.SM.4WKFK GTEX.1314G.0126.SM.5LZUL
    ## ENSG00000223972.5                    1205                      912
    ## ENSG00000278267                      1177                     3985
    ## ENSG00000227232.5                   38733                    84652
    ## ENSG00000284332                         0                        0
    ## ENSG00000243485.5                       0                        9
    ## ENSG00000237613.2                     129                      152
    ##                   GTEX.13U4I.0626.SM.5LU5L GTEX.ZDTS.1226.SM.4WKGL
    ## ENSG00000223972.5                      613                     365
    ## ENSG00000278267                       2356                    1810
    ## ENSG00000227232.5                    70474                   50551
    ## ENSG00000284332                         17                       0
    ## ENSG00000243485.5                      304                     214
    ## ENSG00000237613.2                      304                       0
    ##                   GTEX.ZGAY.0226.SM.4WWAL GTEX.ZYT6.0926.SM.5GIEM
    ## ENSG00000223972.5                    1970                     401
    ## ENSG00000278267                      2306                    1397
    ## ENSG00000227232.5                   86416                   61247
    ## ENSG00000284332                       152                       8
    ## ENSG00000243485.5                    1148                     548
    ## ENSG00000237613.2                     261                     152
    ##                   GTEX.13JVG.1126.SM.5KM2M GTEX.ZG7Y.1426.SM.4WWBM
    ## ENSG00000223972.5                      309                     759
    ## ENSG00000278267                       1834                    1630
    ## ENSG00000227232.5                    48366                   88649
    ## ENSG00000284332                          0                       2
    ## ENSG00000243485.5                      383                     629
    ## ENSG00000237613.2                        0                       0
    ##                   GTEX.1399U.0526.SM.5K7YM GTEX.ZYFG.0426.SM.5E43M
    ## ENSG00000223972.5                      172                     313
    ## ENSG00000278267                        583                    1444
    ## ENSG00000227232.5                    29383                   41183
    ## ENSG00000284332                          0                       0
    ## ENSG00000243485.5                      300                     249
    ## ENSG00000237613.2                        0                     152
    ##                   GTEX.12584.0926.SM.5FQTN GTEX.ZF29.0426.SM.4WKFN
    ## ENSG00000223972.5                      416                     134
    ## ENSG00000278267                       1395                     560
    ## ENSG00000227232.5                    51442                   34700
    ## ENSG00000284332                          0                      98
    ## ENSG00000243485.5                      183                     112
    ## ENSG00000237613.2                        0                       0
    ##                   GTEX.13RTJ.0726.SM.5QGQN GTEX.ZG7Y.0926.SM.5EQ6O
    ## ENSG00000223972.5                     1177                     785
    ## ENSG00000278267                       1474                    2497
    ## ENSG00000227232.5                    44752                   55289
    ## ENSG00000284332                          0                       0
    ## ENSG00000243485.5                      122                     144
    ## ENSG00000237613.2                      134                     130
    ##                   GTEX.111FC.0826.SM.5GZWO GTEX.ZTPG.1226.SM.4YCDO
    ## ENSG00000223972.5                      486                     646
    ## ENSG00000278267                       1335                    1865
    ## ENSG00000227232.5                    58880                   55190
    ## ENSG00000284332                          0                       0
    ## ENSG00000243485.5                      134                       0
    ## ENSG00000237613.2                      833                       0
    ##                   GTEX.ZF29.0226.SM.4WKHO GTEX.ZPU1.0726.SM.5HL6O
    ## ENSG00000223972.5                     316                    1014
    ## ENSG00000278267                       368                    1052
    ## ENSG00000227232.5                   23749                   39997
    ## ENSG00000284332                         0                       0
    ## ENSG00000243485.5                     577                     432
    ## ENSG00000237613.2                       0                       0
    ##                   GTEX.145LS.1326.SM.5Q5EP GTEX.ZYT6.1726.SM.5E44P
    ## ENSG00000223972.5                      275                     358
    ## ENSG00000278267                       1397                     760
    ## ENSG00000227232.5                    56326                   30894
    ## ENSG00000284332                          0                       0
    ## ENSG00000243485.5                      244                       0
    ## ENSG00000237613.2                      152                     240
    ##                   GTEX.13N11.0726.SM.5L3DP GTEX.ZV7C.0326.SM.57WB1
    ## ENSG00000223972.5                      111                     185
    ## ENSG00000278267                        966                     885
    ## ENSG00000227232.5                    37795                   34769
    ## ENSG00000284332                          0                       0
    ## ENSG00000243485.5                      553                     236
    ## ENSG00000237613.2                      348                     127
    ##                   GTEX.12ZZY.1126.SM.5DUWQ GTEX.13D11.1726.SM.5IFGQ
    ## ENSG00000223972.5                     1170                      788
    ## ENSG00000278267                       1624                      855
    ## ENSG00000227232.5                    36844                    32175
    ## ENSG00000284332                         52                        0
    ## ENSG00000243485.5                      452                      185
    ## ENSG00000237613.2                      698                        0
    ##                   GTEX.YEC3.0726.SM.4YCD1 GTEX.YEC3.0426.SM.5IFK1
    ## ENSG00000223972.5                    4262                    3208
    ## ENSG00000278267                      1141                    1489
    ## ENSG00000227232.5                   39046                   42980
    ## ENSG00000284332                         0                       0
    ## ENSG00000243485.5                     792                     220
    ## ENSG00000237613.2                       0                     128
    ##                   GTEX.11EQ8.1326.SM.5EGJQ GTEX.13OVI.0326.SM.5K7X1
    ## ENSG00000223972.5                      349                      155
    ## ENSG00000278267                       2028                      997
    ## ENSG00000227232.5                    67154                    47503
    ## ENSG00000284332                          0                        0
    ## ENSG00000243485.5                        0                      593
    ## ENSG00000237613.2                      409                      118
    ##                   GTEX.ZF2S.1026.SM.4WWB1 GTEX.11ZVC.0526.SM.5N9G1
    ## ENSG00000223972.5                     639                      252
    ## ENSG00000278267                      1896                     3879
    ## ENSG00000227232.5                   52460                    95183
    ## ENSG00000284332                       139                       56
    ## ENSG00000243485.5                     549                      940
    ## ENSG00000237613.2                     152                      349
    ##                   GTEX.12WSD.1226.SM.5HL9Q GTEX.11DXZ.0326.SM.5EGH1
    ## ENSG00000223972.5                      653                      273
    ## ENSG00000278267                       1256                      601
    ## ENSG00000227232.5                    57580                    34557
    ## ENSG00000284332                          0                      130
    ## ENSG00000243485.5                      662                      729
    ## ENSG00000237613.2                      152                      152
    ##                   GTEX.13FH7.0926.SM.5J2MR GTEX.1192X.0726.SM.5987R
    ## ENSG00000223972.5                       56                      254
    ## ENSG00000278267                        871                     1279
    ## ENSG00000227232.5                    35709                    53673
    ## ENSG00000284332                          0                      123
    ## ENSG00000243485.5                       76                      672
    ## ENSG00000237613.2                        0                      117
    ##                   GTEX.13FHP.1026.SM.5K7Y2 GTEX.11DXX.0526.SM.5PNVR
    ## ENSG00000223972.5                      754                      309
    ## ENSG00000278267                        612                      786
    ## ENSG00000227232.5                    25423                    31597
    ## ENSG00000284332                          0                        0
    ## ENSG00000243485.5                        0                      152
    ## ENSG00000237613.2                      435                        0
    ##                   GTEX.Y8E4.0326.SM.4VBRR GTEX.13X6K.1826.SM.5O9CR
    ## ENSG00000223972.5                    1985                     1090
    ## ENSG00000278267                      1749                     3356
    ## ENSG00000227232.5                   55592                    81033
    ## ENSG00000284332                         0                        0
    ## ENSG00000243485.5                      24                        0
    ## ENSG00000237613.2                    1216                        0
    ##                   GTEX.13112.0526.SM.5EQ4S GTEX.14A5I.1026.SM.5Q5E3
    ## ENSG00000223972.5                      423                       63
    ## ENSG00000278267                       2175                     1998
    ## ENSG00000227232.5                    53575                    91112
    ## ENSG00000284332                          0                        0
    ## ENSG00000243485.5                      152                      132
    ## ENSG00000237613.2                      456                        0
    ##                   GTEX.YJ8O.0826.SM.5CVM3 GTEX.ZVZP.0226.SM.5NQ73
    ## ENSG00000223972.5                      66                     434
    ## ENSG00000278267                      1041                     671
    ## ENSG00000227232.5                   41396                   37023
    ## ENSG00000284332                         0                      36
    ## ENSG00000243485.5                     241                     718
    ## ENSG00000237613.2                       0                     152
    ##                   GTEX.12584.1026.SM.59HK3 GTEX.11NV4.0826.SM.5BC4S
    ## ENSG00000223972.5                      726                      513
    ## ENSG00000278267                       2443                     2291
    ## ENSG00000227232.5                    94555                    81037
    ## ENSG00000284332                          0                        0
    ## ENSG00000243485.5                      253                      262
    ## ENSG00000237613.2                      719                      152
    ##                   GTEX.13NZA.0826.SM.5K7WS GTEX.ZDXO.0726.SM.57WBT
    ## ENSG00000223972.5                      293                     545
    ## ENSG00000278267                       1766                     894
    ## ENSG00000227232.5                    59778                   50648
    ## ENSG00000284332                          0                       0
    ## ENSG00000243485.5                      491                     281
    ## ENSG00000237613.2                        0                     297
    ##                   GTEX.13QBU.0426.SM.5J2O4 GTEX.132AR.2026.SM.5IJG4
    ## ENSG00000223972.5                      777                     1665
    ## ENSG00000278267                        797                     1802
    ## ENSG00000227232.5                    40361                    72680
    ## ENSG00000284332                          0                        0
    ## ENSG00000243485.5                     1058                        0
    ## ENSG00000237613.2                        0                      141
    ##                   GTEX.146FH.1126.SM.5NQAT GTEX.12WSA.1126.SM.5EGKU
    ## ENSG00000223972.5                      662                     1093
    ## ENSG00000278267                       2099                     4228
    ## ENSG00000227232.5                    66171                    94445
    ## ENSG00000284332                          0                        0
    ## ENSG00000243485.5                      240                      517
    ## ENSG00000237613.2                        0                      668
    ##                   GTEX.ZVT2.1026.SM.5GU55 GTEX.14E7W.1226.SM.5RQIU
    ## ENSG00000223972.5                     414                      152
    ## ENSG00000278267                      1091                      480
    ## ENSG00000227232.5                   36079                    20131
    ## ENSG00000284332                         0                        0
    ## ENSG00000243485.5                     103                        0
    ## ENSG00000237613.2                       0                      118
    ##                   GTEX.148VJ.1526.SM.5Q5DU GTEX.ZGAY.0326.SM.57WF5
    ## ENSG00000223972.5                      645                    1289
    ## ENSG00000278267                        644                    1046
    ## ENSG00000227232.5                    21486                   45453
    ## ENSG00000284332                          0                       0
    ## ENSG00000243485.5                        0                     386
    ## ENSG00000237613.2                        0                       0
    ##                   GTEX.132AR.1926.SM.5EGK5 GTEX.13FTZ.0226.SM.5K7X6
    ## ENSG00000223972.5                     1185                     1133
    ## ENSG00000278267                       1218                     2665
    ## ENSG00000227232.5                    57124                    51352
    ## ENSG00000284332                         32                        0
    ## ENSG00000243485.5                      218                      116
    ## ENSG00000237613.2                      152                      702
    ##                   GTEX.132QS.0426.SM.5KLZ6 GTEX.14E6D.0926.SM.5S2QV
    ## ENSG00000223972.5                      220                      289
    ## ENSG00000278267                       1125                      362
    ## ENSG00000227232.5                    33669                    17352
    ## ENSG00000284332                          0                        0
    ## ENSG00000243485.5                      429                      222
    ## ENSG00000237613.2                        0                        0
    ##                   GTEX.ZDXO.0426.SM.4WKF6 GTEX.11DXY.1026.SM.5987V
    ## ENSG00000223972.5                     133                     1014
    ## ENSG00000278267                      2270                     1772
    ## ENSG00000227232.5                   80598                    37688
    ## ENSG00000284332                         0                        0
    ## ENSG00000243485.5                     214                      149
    ## ENSG00000237613.2                     418                      372
    ##                   GTEX.131YS.0826.SM.5PNYV GTEX.148VI.0326.SM.5RQK7
    ## ENSG00000223972.5                      350                      374
    ## ENSG00000278267                       1624                     1535
    ## ENSG00000227232.5                    82515                    33846
    ## ENSG00000284332                          0                        0
    ## ENSG00000243485.5                       76                      250
    ## ENSG00000237613.2                        0                        0
    ##                   GTEX.11NUK.0926.SM.5HL57 GTEX.145LV.0326.SM.5Q5BW
    ## ENSG00000223972.5                      733                      595
    ## ENSG00000278267                       2099                     1234
    ## ENSG00000227232.5                    82958                    31673
    ## ENSG00000284332                          0                        0
    ## ENSG00000243485.5                      152                      329
    ## ENSG00000237613.2                      557                        0
    ##                   GTEX.13PVR.1026.SM.5QGQW GTEX.11ZUS.0326.SM.5EQ4W
    ## ENSG00000223972.5                        0                     1964
    ## ENSG00000278267                        346                     2593
    ## ENSG00000227232.5                    17853                    83416
    ## ENSG00000284332                          0                        0
    ## ENSG00000243485.5                      127                      276
    ## ENSG00000237613.2                        0                      276
    ##                   GTEX.ZZPU.1126.SM.5N9CW GTEX.117YX.1126.SM.5H128
    ## ENSG00000223972.5                    2897                      191
    ## ENSG00000278267                      1728                      713
    ## ENSG00000227232.5                   59531                    23623
    ## ENSG00000284332                        76                        9
    ## ENSG00000243485.5                     589                      228
    ## ENSG00000237613.2                       0                        0
    ##                   GTEX.11ZUS.0226.SM.5FQT8 GTEX.ZYFG.0526.SM.5GZXX
    ## ENSG00000223972.5                     1999                     154
    ## ENSG00000278267                       1450                     783
    ## ENSG00000227232.5                    52210                   33751
    ## ENSG00000284332                        100                       0
    ## ENSG00000243485.5                      515                     194
    ## ENSG00000237613.2                      587                       0
    ##                   GTEX.1399R.1926.SM.5K7X8 GTEX.145MO.1126.SM.5NQBX
    ## ENSG00000223972.5                      142                      444
    ## ENSG00000278267                        806                     1329
    ## ENSG00000227232.5                    26625                    38851
    ## ENSG00000284332                          0                        0
    ## ENSG00000243485.5                       28                        0
    ## ENSG00000237613.2                        0                      152
    ##                   GTEX.1339X.0326.SM.5K7Z8 GTEX.13QBU.0226.SM.5LU48
    ## ENSG00000223972.5                      520                      594
    ## ENSG00000278267                        796                     1301
    ## ENSG00000227232.5                    26317                    46001
    ## ENSG00000284332                          0                        0
    ## ENSG00000243485.5                        0                        0
    ## ENSG00000237613.2                        0                        0
    ##                   GTEX.14A6H.0226.SM.5Q5DX GTEX.147F4.1226.SM.5NQAY
    ## ENSG00000223972.5                     1812                      839
    ## ENSG00000278267                       3689                      880
    ## ENSG00000227232.5                    91618                    31726
    ## ENSG00000284332                          0                        0
    ## ENSG00000243485.5                      267                        0
    ## ENSG00000237613.2                      698                        0
    ##                   GTEX.13CF3.0726.SM.5J2MY GTEX.13PDP.1326.SM.5K7U9
    ## ENSG00000223972.5                      811                      218
    ## ENSG00000278267                       1107                     1552
    ## ENSG00000227232.5                    46582                    58519
    ## ENSG00000284332                          0                        0
    ## ENSG00000243485.5                        0                        0
    ## ENSG00000237613.2                        0                      303
    ##                   GTEX.13OW5.0926.SM.5L3GZ GTEX.13X6I.1426.SM.5SI9Z
    ## ENSG00000223972.5                      158                     1688
    ## ENSG00000278267                       1527                     2943
    ## ENSG00000227232.5                    49343                    72552
    ## ENSG00000284332                          0                        0
    ## ENSG00000243485.5                        0                        0
    ## ENSG00000237613.2                        0                      152
    ##                   GTEX.13CF3.0826.SM.5LZYZ GTEX.11EM3.0426.SM.5N9BZ
    ## ENSG00000223972.5                      725                      569
    ## ENSG00000278267                       1540                     1225
    ## ENSG00000227232.5                    52555                    64959
    ## ENSG00000284332                          0                        0
    ## ENSG00000243485.5                        0                      435
    ## ENSG00000237613.2                        0                        0
    ##                   GTEX.1211K.0626.SM.5FQUZ GTEX.11GS4.0526.SM.5A5KQ
    ## ENSG00000223972.5                      751                      373
    ## ENSG00000278267                        882                     1326
    ## ENSG00000227232.5                    32467                    33933
    ## ENSG00000284332                          0                        0
    ## ENSG00000243485.5                      166                        0
    ## ENSG00000237613.2                      151                       97
    ##                   GTEX.ZTPG.1326.SM.51MSQ GTEX.146FR.0626.SM.5RQJ1
    ## ENSG00000223972.5                      51                     1642
    ## ENSG00000278267                       321                     1023
    ## ENSG00000227232.5                   38055                    37357
    ## ENSG00000284332                         0                        0
    ## ENSG00000243485.5                       0                       91
    ## ENSG00000237613.2                       0                      544
    ##                   GTEX.13YAN.1326.SM.5Q5F1 GTEX.13O61.0526.SM.5J2M1
    ## ENSG00000223972.5                       67                      474
    ## ENSG00000278267                        754                     1156
    ## ENSG00000227232.5                    24091                    45928
    ## ENSG00000284332                          0                        0
    ## ENSG00000243485.5                      238                      231
    ## ENSG00000237613.2                        0                        0
    ##                   GTEX.11ILO.2526.SM.5A5LQ GTEX.12BJ1.0226.SM.5LUA2
    ## ENSG00000223972.5                     1418                      528
    ## ENSG00000278267                       5084                      837
    ## ENSG00000227232.5                    93527                    25894
    ## ENSG00000284332                          0                        0
    ## ENSG00000243485.5                      400                      151
    ## ENSG00000237613.2                      148                      152
    ##                   GTEX.144GL.1026.SM.5O99R GTEX.13FTW.0826.SM.5K7XR
    ## ENSG00000223972.5                     1015                      249
    ## ENSG00000278267                       2044                      441
    ## ENSG00000227232.5                    66285                    30455
    ## ENSG00000284332                         57                        0
    ## ENSG00000243485.5                      152                      158
    ## ENSG00000237613.2                      241                        0
    ##                   GTEX.139UC.0426.SM.5K7UR GTEX.13OW5.1126.SM.5J1NR
    ## ENSG00000223972.5                     1558                        0
    ## ENSG00000278267                       1206                      762
    ## ENSG00000227232.5                    41537                    27458
    ## ENSG00000284332                          0                        0
    ## ENSG00000243485.5                        0                      104
    ## ENSG00000237613.2                      435                        0
    ##                   GTEX.YB5K.0126.SM.5IFJ2 GTEX.11EMC.0826.SM.59862
    ## ENSG00000223972.5                     350                      969
    ## ENSG00000278267                       823                     4109
    ## ENSG00000227232.5                   34995                    79158
    ## ENSG00000284332                         0                       14
    ## ENSG00000243485.5                     265                      293
    ## ENSG00000237613.2                       0                      676
    ##                   GTEX.131XF.0326.SM.5DUVR GTEX.132Q8.1126.SM.5K7XS
    ## ENSG00000223972.5                      711                      849
    ## ENSG00000278267                        872                     1414
    ## ENSG00000227232.5                    30498                    55659
    ## ENSG00000284332                          0                        0
    ## ENSG00000243485.5                      223                       21
    ## ENSG00000237613.2                      240                      232
    ##                   GTEX.13FTW.1026.SM.5L3E3 GTEX.13PL7.0726.SM.5KM1S
    ## ENSG00000223972.5                      781                     1290
    ## ENSG00000278267                        753                      966
    ## ENSG00000227232.5                    24422                    58610
    ## ENSG00000284332                          0                        0
    ## ENSG00000243485.5                       73                      308
    ## ENSG00000237613.2                        0                        0
    ##                   GTEX.ZEX8.0326.SM.4WKGS GTEX.1399S.0826.SM.5KM23
    ## ENSG00000223972.5                     299                      110
    ## ENSG00000278267                       608                     1467
    ## ENSG00000227232.5                   33432                    45462
    ## ENSG00000284332                       119                        0
    ## ENSG00000243485.5                     848                      152
    ## ENSG00000237613.2                     266                        0
    ##                   GTEX.ZVZQ.0726.SM.51MR3 GTEX.13O3P.1626.SM.5K7X3
    ## ENSG00000223972.5                    2195                      528
    ## ENSG00000278267                      3958                     1754
    ## ENSG00000227232.5                   97872                    41109
    ## ENSG00000284332                         0                        0
    ## ENSG00000243485.5                      46                        0
    ## ENSG00000237613.2                     601                      331
    ##                   GTEX.13OW8.2126.SM.5J1OS GTEX.13O1R.0926.SM.5L3DS
    ## ENSG00000223972.5                     1375                       61
    ## ENSG00000278267                       1256                      377
    ## ENSG00000227232.5                    38726                    29562
    ## ENSG00000284332                          0                      117
    ## ENSG00000243485.5                        0                      506
    ## ENSG00000237613.2                      434                        0
    ##                   GTEX.ZYW4.0926.SM.59HJS GTEX.13O3O.1426.SM.5KM2S
    ## ENSG00000223972.5                     745                      601
    ## ENSG00000278267                      2795                     2224
    ## ENSG00000227232.5                   57676                    67526
    ## ENSG00000284332                       114                        0
    ## ENSG00000243485.5                     274                        0
    ## ENSG00000237613.2                       0                        0
    ##                   GTEX.13O61.0426.SM.5L3ET GTEX.Z93S.0326.SM.5HL84
    ## ENSG00000223972.5                      279                     258
    ## ENSG00000278267                        530                    1237
    ## ENSG00000227232.5                    32573                   66171
    ## ENSG00000284332                          0                       0
    ## ENSG00000243485.5                        0                     134
    ## ENSG00000237613.2                        0                     123
    ##                   GTEX.11ONC.1026.SM.5GU64 GTEX.ZAB4.1026.SM.5HL7T
    ## ENSG00000223972.5                       75                    1279
    ## ENSG00000278267                        922                    3829
    ## ENSG00000227232.5                    25145                   81198
    ## ENSG00000284332                          0                       0
    ## ENSG00000243485.5                        0                     487
    ## ENSG00000237613.2                      152                       0
    ##                   GTEX.ZAB4.0926.SM.5CVN4 GTEX.ZZPU.0926.SM.5GZYT
    ## ENSG00000223972.5                     867                    1584
    ## ENSG00000278267                      2199                     901
    ## ENSG00000227232.5                   57781                   43582
    ## ENSG00000284332                        76                       0
    ## ENSG00000243485.5                     396                     144
    ## ENSG00000237613.2                       0                     112
    ##                   GTEX.131XE.0526.SM.5K7YT GTEX.ZAB5.0126.SM.5CVMT
    ## ENSG00000223972.5                      313                    1249
    ## ENSG00000278267                        943                    2026
    ## ENSG00000227232.5                    46359                   42354
    ## ENSG00000284332                          0                       0
    ## ENSG00000243485.5                      152                     363
    ## ENSG00000237613.2                        0                     527
    ##                   GTEX.13NYB.0226.SM.5N9G4 GTEX.1313W.1426.SM.5KLZU
    ## ENSG00000223972.5                      129                      835
    ## ENSG00000278267                        706                     4916
    ## ENSG00000227232.5                    26700                   127732
    ## ENSG00000284332                          0                       26
    ## ENSG00000243485.5                       66                     1037
    ## ENSG00000237613.2                        0                      439
    ##                   GTEX.12ZZZ.1726.SM.59HK5 GTEX.ZAK1.1126.SM.5PNXU
    ## ENSG00000223972.5                      217                     604
    ## ENSG00000278267                       1182                    2779
    ## ENSG00000227232.5                    41277                   91720
    ## ENSG00000284332                          0                       0
    ## ENSG00000243485.5                      152                     383
    ## ENSG00000237613.2                      659                       0
    ##                   GTEX.1313W.1126.SM.5EQ5U GTEX.1212Z.0726.SM.5EGI5
    ## ENSG00000223972.5                      458                      903
    ## ENSG00000278267                       1382                     1004
    ## ENSG00000227232.5                    71496                    38365
    ## ENSG00000284332                        129                        0
    ## ENSG00000243485.5                      661                      137
    ## ENSG00000237613.2                      139                      329
    ##                   GTEX.13FHP.0826.SM.5K7V5 GTEX.111FC.0626.SM.5N9CU
    ## ENSG00000223972.5                     1630                      232
    ## ENSG00000278267                       2367                     1778
    ## ENSG00000227232.5                    92398                    60075
    ## ENSG00000284332                         73                       74
    ## ENSG00000243485.5                      258                      267
    ## ENSG00000237613.2                      527                      241
    ##                   GTEX.Y5V6.0826.SM.4VBRU GTEX.131XF.0426.SM.5HL7U
    ## ENSG00000223972.5                     478                      258
    ## ENSG00000278267                      1504                     1179
    ## ENSG00000227232.5                   44889                    40878
    ## ENSG00000284332                         0                        0
    ## ENSG00000243485.5                     261                      273
    ## ENSG00000237613.2                       0                        0
    ##                   GTEX.ZXG5.0626.SM.5NQ85 GTEX.ZTTD.0526.SM.57WDV
    ## ENSG00000223972.5                     728                    1210
    ## ENSG00000278267                      2077                    2629
    ## ENSG00000227232.5                   66637                   79455
    ## ENSG00000284332                        40                       0
    ## ENSG00000243485.5                     438                       0
    ## ENSG00000237613.2                     994                       0
    ##                   GTEX.11UD2.0926.SM.5CVL6 GTEX.13NZ9.0126.SM.5K7XV
    ## ENSG00000223972.5                      314                      988
    ## ENSG00000278267                       1477                     1670
    ## ENSG00000227232.5                    45463                    41426
    ## ENSG00000284332                          0                        0
    ## ENSG00000243485.5                       34                      454
    ## ENSG00000237613.2                        0                      419
    ##                   GTEX.13N1W.0926.SM.5MR36 GTEX.13NZB.0426.SM.5KM26
    ## ENSG00000223972.5                      442                      470
    ## ENSG00000278267                       2341                     1245
    ## ENSG00000227232.5                    73247                    44558
    ## ENSG00000284332                          0                        0
    ## ENSG00000243485.5                        0                      355
    ## ENSG00000237613.2                        0                      235
    ##                   GTEX.11ONC.0126.SM.5PNW6 GTEX.YEC4.0326.SM.4W216
    ## ENSG00000223972.5                      469                    1425
    ## ENSG00000278267                        862                    1522
    ## ENSG00000227232.5                    38169                   49529
    ## ENSG00000284332                          0                       0
    ## ENSG00000243485.5                        0                     430
    ## ENSG00000237613.2                      142                     143
    ##                   GTEX.132QS.0526.SM.5IJC7 GTEX.13FH7.0826.SM.5J2NW
    ## ENSG00000223972.5                      468                       45
    ## ENSG00000278267                        967                     1098
    ## ENSG00000227232.5                    40060                    32168
    ## ENSG00000284332                          0                        0
    ## ENSG00000243485.5                      130                        0
    ## ENSG00000237613.2                      151                      250
    ##                   GTEX.14A5I.1226.SM.5NQBW GTEX.111VG.0326.SM.5GZX7
    ## ENSG00000223972.5                      168                      440
    ## ENSG00000278267                        358                     1926
    ## ENSG00000227232.5                    17528                    49719
    ## ENSG00000284332                          0                        0
    ## ENSG00000243485.5                        0                      436
    ## ENSG00000237613.2                        0                      612
    ##                   GTEX.ZYW4.1026.SM.5SI8W GTEX.YEC3.0726.SM.5IFIW
    ## ENSG00000223972.5                    1044                    2549
    ## ENSG00000278267                      2107                     476
    ## ENSG00000227232.5                   62770                   31776
    ## ENSG00000284332                         0                       0
    ## ENSG00000243485.5                      97                     429
    ## ENSG00000237613.2                     152                     533
    ##                   GTEX.13SLW.0826.SM.5QGP7 GTEX.ZYFC.1126.SM.5E44W
    ## ENSG00000223972.5                      561                     338
    ## ENSG00000278267                        682                    1978
    ## ENSG00000227232.5                    35201                   57084
    ## ENSG00000284332                          0                      87
    ## ENSG00000243485.5                        0                     541
    ## ENSG00000237613.2                        0                     152
    ##                   GTEX.11DXZ.0626.SM.5GU77 GTEX.ZDYS.0326.SM.5HL4W
    ## ENSG00000223972.5                      181                     493
    ## ENSG00000278267                       2133                     713
    ## ENSG00000227232.5                    44660                   36114
    ## ENSG00000284332                         72                      76
    ## ENSG00000243485.5                      478                     527
    ## ENSG00000237613.2                      225                       0
    ##                   GTEX.ZVT3.0826.SM.5GIC8 GTEX.131XE.0626.SM.5HL98
    ## ENSG00000223972.5                     779                       89
    ## ENSG00000278267                      1520                     1326
    ## ENSG00000227232.5                   55543                    48010
    ## ENSG00000284332                         0                        0
    ## ENSG00000243485.5                     376                        0
    ## ENSG00000237613.2                     124                      304
    ##                   GTEX.12WSE.0926.SM.5S2VX GTEX.13JVG.1326.SM.5N9F8
    ## ENSG00000223972.5                      724                      329
    ## ENSG00000278267                       1379                      946
    ## ENSG00000227232.5                    72948                    17925
    ## ENSG00000284332                         76                        0
    ## ENSG00000243485.5                      570                        0
    ## ENSG00000237613.2                      211                        0
    ##                   GTEX.Y5V5.0626.SM.4VBPX GTEX.13W3W.0526.SM.5LU3X
    ## ENSG00000223972.5                    2089                      417
    ## ENSG00000278267                      2735                     1102
    ## ENSG00000227232.5                   59590                    43851
    ## ENSG00000284332                         0                       60
    ## ENSG00000243485.5                      29                      335
    ## ENSG00000237613.2                     742                        0
    ##                   GTEX.ZDTS.1326.SM.4WKGX GTEX.13O21.2326.SM.5MR3X
    ## ENSG00000223972.5                     361                      604
    ## ENSG00000278267                      2006                      915
    ## ENSG00000227232.5                   50857                    35879
    ## ENSG00000284332                         0                        0
    ## ENSG00000243485.5                      14                      429
    ## ENSG00000237613.2                     107                        0
    ##                   GTEX.ZYFD.2026.SM.5E459 GTEX.13O21.0326.SM.5J1N9
    ## ENSG00000223972.5                     595                      102
    ## ENSG00000278267                      2067                     1020
    ## ENSG00000227232.5                   55409                    74009
    ## ENSG00000284332                         0                        0
    ## ENSG00000243485.5                     176                      406
    ## ENSG00000237613.2                       0                      184
    ##                   GTEX.1211K.0226.SM.59HJY GTEX.ZUA1.0726.SM.4YCD9
    ## ENSG00000223972.5                      774                     967
    ## ENSG00000278267                        590                    2523
    ## ENSG00000227232.5                    37952                   76001
    ## ENSG00000284332                          0                       0
    ## ENSG00000243485.5                       87                     717
    ## ENSG00000237613.2                        0                     403
    ##                   GTEX.139YR.0826.SM.5LZXY GTEX.117YW.0326.SM.5N9CY
    ## ENSG00000223972.5                      708                      692
    ## ENSG00000278267                        701                     1680
    ## ENSG00000227232.5                    27289                    50559
    ## ENSG00000284332                          0                        0
    ## ENSG00000243485.5                        0                        0
    ## ENSG00000237613.2                      122                      677
    ##                   GTEX.ZYFC.1026.SM.5GZX9 GTEX.1122O.0626.SM.5N9B9
    ## ENSG00000223972.5                     175                     1344
    ## ENSG00000278267                       882                     1308
    ## ENSG00000227232.5                   83893                    43942
    ## ENSG00000284332                        38                        0
    ## ENSG00000243485.5                     261                      643
    ## ENSG00000237613.2                       0                        0
    ##                   GTEX.ZTTD.0626.SM.4YCCY GTEX.ZDTT.0326.SM.4WKF9
    ## ENSG00000223972.5                     559                     920
    ## ENSG00000278267                      1036                    1201
    ## ENSG00000227232.5                   48239                   40999
    ## ENSG00000284332                         0                      72
    ## ENSG00000243485.5                     301                     263
    ## ENSG00000237613.2                       0                       0
    ##                   GTEX.12WSC.1026.SM.5EQ5Y GTEX.11LCK.0926.SM.5A5KA
    ## ENSG00000223972.5                      447                      219
    ## ENSG00000278267                       2930                      692
    ## ENSG00000227232.5                    75918                    34247
    ## ENSG00000284332                          0                        0
    ## ENSG00000243485.5                      502                      499
    ## ENSG00000237613.2                       76                      388
    ##                   GTEX.14BMV.1026.SM.5SI6B GTEX.12WSD.1126.SM.5EGJD
    ## ENSG00000223972.5                      827                     1490
    ## ENSG00000278267                        641                     1561
    ## ENSG00000227232.5                    42034                    66300
    ## ENSG00000284332                          0                       72
    ## ENSG00000243485.5                      843                      766
    ## ENSG00000237613.2                        0                      272
    ##                   GTEX.147JS.1326.SM.5SI6D GTEX.ZQUD.1526.SM.51MRE
    ## ENSG00000223972.5                     1053                     264
    ## ENSG00000278267                       3031                    1280
    ## ENSG00000227232.5                    87933                   50292
    ## ENSG00000284332                          0                       0
    ## ENSG00000243485.5                      274                      32
    ## ENSG00000237613.2                        0                     304
    ##                   GTEX.1399T.0726.SM.5J1MH GTEX.145MN.0726.SM.5NQBH
    ## ENSG00000223972.5                     1656                      209
    ## ENSG00000278267                       2327                     1639
    ## ENSG00000227232.5                    79349                    44409
    ## ENSG00000284332                          0                        0
    ## ENSG00000243485.5                      236                        0
    ## ENSG00000237613.2                        0                     1046
    ##                   GTEX.ZLFU.0226.SM.4WWFH GTEX.1399T.0426.SM.5PNVJ
    ## ENSG00000223972.5                    1234                       48
    ## ENSG00000278267                      1140                      401
    ## ENSG00000227232.5                   43528                    12615
    ## ENSG00000284332                         0                        0
    ## ENSG00000243485.5                       0                        0
    ## ENSG00000237613.2                     233                      152
    ##                   GTEX.1477Z.1126.SM.5P9GK GTEX.13SLX.0926.SM.5S2NM
    ## ENSG00000223972.5                     1955                       17
    ## ENSG00000278267                       3619                      704
    ## ENSG00000227232.5                    88892                    48712
    ## ENSG00000284332                          0                       50
    ## ENSG00000243485.5                      133                      380
    ## ENSG00000237613.2                     1131                        0
    ##                   GTEX.14A6H.0326.SM.5NQAN GTEX.111YS.0426.SM.5987O
    ## ENSG00000223972.5                      366                      327
    ## ENSG00000278267                       2529                     1170
    ## ENSG00000227232.5                    86839                    35516
    ## ENSG00000284332                          0                        0
    ## ENSG00000243485.5                      509                       99
    ## ENSG00000237613.2                      250                      152
    ##                   GTEX.13N11.0426.SM.5KM3O GTEX.131XG.0626.SM.5GCMP
    ## ENSG00000223972.5                      556                     1305
    ## ENSG00000278267                       1516                      516
    ## ENSG00000227232.5                    42126                    24297
    ## ENSG00000284332                          0                        0
    ## ENSG00000243485.5                      611                      252
    ## ENSG00000237613.2                       94                        0
    ##                   GTEX.YEC3.0426.SM.4YCEP GTEX.11EM3.0626.SM.5H12Z
    ## ENSG00000223972.5                    2836                     1149
    ## ENSG00000278267                      1449                      659
    ## ENSG00000227232.5                   48590                    41335
    ## ENSG00000284332                         0                        0
    ## ENSG00000243485.5                     927                      203
    ## ENSG00000237613.2                     281                        0
    ##                     Ensembl.gene.ID
    ## ENSG00000223972.5 ENSG00000223972.5
    ## ENSG00000278267     ENSG00000278267
    ## ENSG00000227232.5 ENSG00000227232.5
    ## ENSG00000284332     ENSG00000284332
    ## ENSG00000243485.5 ENSG00000243485.5
    ## ENSG00000237613.2 ENSG00000237613.2

Now we can pivot longer. We use `cols` to specify with column names will
be turned into observations and we use `names_to` to specify the name of
the new column that contains those observations. We use `values_to` to
name the column with the corresonding value, in this case we will call
the new columns, `SAMPID` and `counts`.

``` r
counts_tidy_long <- counts_tidy_slim %>%
  pivot_longer(cols = all_of(mycols), names_to = "SAMPID", 
               values_to = "counts") 
head(counts_tidy_long)
```

    ## # A tibble: 6 × 3
    ##   Ensembl.gene.ID   SAMPID                   counts
    ##   <chr>             <chr>                     <dbl>
    ## 1 ENSG00000223972.5 GTEX.12ZZX.0726.SM.5EGKA    630
    ## 2 ENSG00000223972.5 GTEX.13D11.1526.SM.5J2NA    877
    ## 3 ENSG00000223972.5 GTEX.ZAJG.0826.SM.5PNVA    1211
    ## 4 ENSG00000223972.5 GTEX.11TT1.1426.SM.5EGIA    344
    ## 5 ENSG00000223972.5 GTEX.13VXT.1126.SM.5LU3A     76
    ## 6 ENSG00000223972.5 GTEX.14ASI.0826.SM.5Q5EB    895

Now, that we have a `SAMPID` column, we can join this with our
colData_tidy and then make some pretty plots.

``` r
counts_tidy_long_joined <- counts_tidy_long%>%
  inner_join(., colData_tidy, by = "SAMPID") %>%
  arrange(desc(counts))
head(counts_tidy_long_joined)
```

    ## # A tibble: 6 × 12
    ##   Ensembl.gene.ID   SAMPID  counts SMTS  SMTSD  SUBJID SEX   AGE   SMRIN DTHHRDY
    ##   <chr>             <chr>    <dbl> <chr> <chr>  <chr>  <chr> <chr> <dbl> <chr>  
    ## 1 ENSG00000227232.5 GTEX.1… 136022 Heart Heart… GTEX-… Male  60-69   6.1 Fast d…
    ## 2 ENSG00000227232.5 GTEX.1… 132414 Heart Heart… GTEX-… Male  60-69   6.4 Fast d…
    ## 3 ENSG00000227232.5 GTEX.1… 127732 Heart Heart… GTEX-… Fema… 50-59   6.3 Fast d…
    ## 4 ENSG00000227232.5 GTEX.Y… 108293 Heart Heart… GTEX-… Fema… 40-49   7.4 Violen…
    ## 5 ENSG00000227232.5 GTEX.1…  99074 Heart Heart… GTEX-… Fema… 50-59   6.5 Interm…
    ## 6 ENSG00000227232.5 GTEX.Z…  97872 Heart Heart… GTEX-… Fema… 60-69   6.3 Violen…
    ## # … with 2 more variables: SRA <chr>, DATE <chr>

``` r
library(scales)

counts_tidy_long_joined %>%
  ggplot(aes(x = AGE, y = counts)) +
  geom_boxplot() +
  geom_point() +
  facet_wrap(~Ensembl.gene.ID, scales = "free_y") +
  scale_y_log10(labels = label_number_si())
```

    ## Warning: Transformation introduced infinite values in continuous y-axis

    ## Warning: Transformation introduced infinite values in continuous y-axis

    ## Warning: Removed 442 rows containing non-finite values (stat_boxplot).

![](./images/boxplot2-1.png)<!-- -->

That completes our section on tidying and transforming data.

:::success

#### Key functions: Tidy and Transform

| Function         | Description |
|------------------|-------------|
| `filter()`       |             |
| `mutate()`       |             |
| `select()`       |             |
| `arrange()`      |             |
| `full_join()`    |             |
| `left_join()`    |             |
| `inner_join()`   |             |
| `pivot_wider()`  |             |
| `pivot_longer()` |             |
| `drop_na()`      |             |
| `separate()`     |             |

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

