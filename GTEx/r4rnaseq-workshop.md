r4rnaseq-workshop
================
Rayna M Harris

# Introduction to R for RNA-Seq Workshop

<!---

_Even though you can [![hackmd-github-sync-badge](https://hackmd.io/2ArmQGwGT0uUyL5Ehqy0hQ/badge)](https://hackmd.io/2ArmQGwGT0uUyL5Ehqy0hQ), please make changes by editing [this .Rmd file](https://github.com/nih-cfde/training-rstudio-binder/blob/data/GTEx/r4rnaseq-workshop.Rmd)._

--->

**Description**

This free two-hour workshop will provide an overview of the R
programming language and the user-friendly RStudio environment for
exploratory RNA-sequencing analysis. You will be introduced to R syntax,
variables, functions, packages, and data structures. You will learn the
basics of data wrangling including importing data from files,
sub-setting, joining, filtering, and more. You will gain hands-on
practice calculating and visualizing differential gene expression using
popular open-source packages and public RNA-Seq data from the
Gene-Tissue Expression Project (GTEx). *Please fill out the pre- and
post-workshop surveys to help us keep these workshops free.*

**When:** Wednesday, April 27, 2022 from 10 am - 12 pm PDT. [Check your
current time
here.](https://www.timeanddate.com/worldclock/fixedtime.html?msg=+Introduction+to+R+for+RNA-Sequencing+Analysis&iso=20220427T10&p1=3736&ah=2)  
**Where:**
[Zoom](https://zoom.us/j/7575820324?pwd=d2UyMEhYZGNiV3kyUFpUL1EwQmthQT09)  
**Instructors:** Dr. Rayna Harris  
**Organizer: The Common Fund Data Ecosystem **

Click
[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/nih-cfde/training-rstudio-binder/data?urlpath=rstudio)
to generate a computing environment for this workshop.

### Overview

:::info

#### Learning Objectives

In this workshop, you will learn how to use R and RStudio to

-   Import, tidy, transform, and visualize data structures commonly
    associated with RNA-sequencing experiments
-   Explore public RNA-Seq data from the Gene-Tissue Expression Project
-   Select variables and observations that are relevant to research
    questions
-   Rename variables and experimental factors for data joining and
    plotting
-   Visualize raw and summarized data using bar graphs, scatter plots,
    and box plots

:::

\[TOC\]

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

![](https://hackmd.io/_uploads/SkkxxSHeq.png =300x)
![](https://hackmd.io/_uploads/H1a8-HHx5.png =300x)

For today’s lesson, we will focus on data from the [Gene-Tissue
Expression (GTEx) Project](https://commonfund.nih.gov/gtex). The GTEx is
an ongoing effort to build a comprehensive public resource to study
tissue-specific gene expression and regulation. Samples were collected
from 54 non-diseased tissue sites across nearly 1000 individuals,
primarily for molecular assays including WGS, WES, and RNA-Seq.

By the end of today’s workshop, you create tables and plots like the
ones below that give an overview of the samples collected and the
variables that can be used for differential gene expression analysis.
More importantly, you will learn the basics of importing, tidying,
transforming, and visualizing data, which are the key component of an R
workflow.

### Some motivating questions

-   How many RNA-sequencing samples are in the GTEx project?
-   What is the age and sex of each donor?
-   What was the cause of death?
-   What is the effect of age on gene expression in the heart?
-   Do you have enough samples to test the effects of sex, age, hardy
    scale, and their interactions for all tissues?
-   How do I combine, clean, modify, separate, etc. data sets and
    variables?
-   How is my gene of interest affected by age in the heart and muscle?

![](https://hackmd.io/_uploads/SJSIB76b9.png =300x)
![](https://hackmd.io/_uploads/Sk6IrQaZc.png =300x)

![](https://hackmd.io/_uploads/r1mwBQaW5.png =300x)
![](https://hackmd.io/_uploads/HJ5BrXp-c.png =300x)

### Getting Started

1.  Click the
    [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/nih-cfde/training-rstudio-binder/data?urlpath=rstudio)
    button to generate a computing environment for this workshop.
2.  Navigate to the GTEx folder.
3.  Click `GTEx.Rproj` and click “Yes” to open up an Rproject. This will
    set the working directory to `~/GTEx/`.
4.  Open the `r4rnaseq-workshop.R` file which contains all the commands
    for today’s workshop. This contains all the commands we will build
    today. This is your reference.
5.  Open a new R Script by clicking **File > New File > R Script**. You
    will type most commands for today’s lesson here and click “Run” to
    send them to the console.

### R packages

[**Tidyverse**](https://www.tidyverse.org/) is a collection of R
packages that include functions, data, and documentation that provide
more tools and capabilities when using R. There are many packages for R,
but we are using this set because the packages are designed to work well
together -and they are especially useful (and popular!) for doing data
science.

You can install the complete tidyverse with a single line of code:
`install.packages("tidyverse")`, or you can install packages
individually (e.g. `install.packages("ggplot2")`). It is a good idea to
“comment out” this line of code by adding a `#` at the beginning so that
you don’t re-install the package every time you run the script. For this
workshop, the packages listed in the `.binder/environment.yml` file were
pre-installed with Conda. For some reason, the tidyverse package doesn’t
always install properly, so we installed each package individually.

``` r
#install.packages("tidyverse")
#install.packages("ggplot2")
#install.packages("tidyr")
```

After installing packages, we need to load the functions and tools we
want to use from the package with the `library()` command. Let’s load
the following packages: `ggplot2, tidyr, dplyr, readr, and tibble` by
copying and pasting or typing these commands into your new script.

``` r
library(ggplot2)
library(tidyr)
library(dplyr)
library(readr)
library(tibble)
```

:::warning

#### Challenge

We will also use `cowplot` and `scales` to make pretty visualizations,
`forcats.` for working with factors, and `stringr` for parsing text.
What commands do you need to add to your script to load these packages?

:::spoiler

`library(cowplot)`  
`library(scales)`  
`library(forcats)`  
`library(stringr)`

:::

You can also navigate to the “Packages” tab in the bottom right pane of
RStudio to view a list of available packages. Packages with a checked
box next to them have been successfully loaded. You can click a box to
load installed packages. Clicking the “Help” Tab will provide a quick
description of the package and its functions.

:::success

#### Key functions

| Function             | Description                                 |
|----------------------|---------------------------------------------|
| `install.packages()` | An R function to install packages           |
| `library()`          | The command used to load installed packages |

:::

## Import

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

1.  data/GTExPortal.csv
2.  data/GTExHeart_20-29_vs_70-79.tsv
3.  data/colData.HEART.csv
4.  data/countData.HEART.csv.gz

Then, you will practice on your own using the following files:

1.  data/GTExMuscle_20-29_vs_70-79.tsv
2.  data/colData.MUSCLE.csv
3.  data/countData.MUSCLE.csv.gz

The `GTExPortal.csv` file in `./data/` contains information about all
the samples in the GTEx portal. Let’s import this file using
`read.csv()`.

``` r
samples <- read.csv("./data/GTExPortal.csv")
```

After importing a file, there are multiple ways to view the data.
`head()` to view the first few lines of each file. `names()` will print
just the column names.

``` r
head(samples)
```

    ##   Tissue.Sample.ID                         Tissue Subject.ID    Sex Age.Bracket
    ## 1  GTEX-1117F-0126 Skin - Sun Exposed (Lower leg) GTEX-1117F female       60-69
    ## 2  GTEX-1117F-0226         Adipose - Subcutaneous GTEX-1117F female       60-69
    ## 3  GTEX-1117F-0326                 Nerve - Tibial GTEX-1117F female       60-69
    ## 4  GTEX-1117F-0426              Muscle - Skeletal GTEX-1117F female       60-69
    ## 5  GTEX-1117F-0526                Artery - Tibial GTEX-1117F female       60-69
    ## 6  GTEX-1117F-0626              Artery - Coronary GTEX-1117F female       60-69
    ##   Hardy.Scale  Pathology.Categories
    ## 1  Slow death                      
    ## 2  Slow death                      
    ## 3  Slow death       clean_specimens
    ## 4  Slow death                      
    ## 5  Slow death monckeberg, sclerotic
    ## 6  Slow death                      
    ##                                                Pathology.Notes
    ## 1 6 pieces, minimal fat, squamous epithelium is ~50-70 microns
    ## 2                 2 pieces, ~15% vessel stroma, rep delineated
    ## 3                                    2 pieces, clean specimens
    ## 4    2 pieces, !5% fibrous connective tissue, delineated (rep)
    ## 5  2 pieces, clean, Monckebeg medial sclerosis, rep delineated
    ## 6     2 pieces, up to 4mm aderent fat/nerve/vessel, delineated

``` r
names(samples)
```

    ## [1] "Tissue.Sample.ID"     "Tissue"               "Subject.ID"          
    ## [4] "Sex"                  "Age.Bracket"          "Hardy.Scale"         
    ## [7] "Pathology.Categories" "Pathology.Notes"

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

``` r
# without row.names
results2 <- read.table("./data/GTEx_Heart_20-29_vs_30-39.tsv",  sep = "\t", header = TRUE )
head(results2)
```

    ##          X       logFC    AveExpr          t      P.Value  adj.P.Val         B
    ## 1     A1BG  0.10332788  1.3459363  0.3221575 0.7482217611 0.87480317 -5.672644
    ## 2 A1BG-AS1  0.13609230 -0.2381928  0.6395041 0.5244264675 0.73078056 -5.345563
    ## 3      A2M -0.01605178  9.7981987 -0.1132389 0.9101410387 0.95645802 -5.956689
    ## 4  A2M-AS1  0.60505571  2.5392220  3.4884410 0.0008131523 0.05545654 -0.635100
    ## 5    A2ML1  0.35413535 -1.1667406  1.0788316 0.2840898578 0.52922642 -4.948617
    ## 6    A2MP1  0.65764737 -0.7564399  3.2615528 0.0016630789 0.06067003 -1.358971

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

:::info Using the Terminal to uncompress files

Very large data files, such as files with RNA-Seq counts are often
compressed before they are shared. To uncompress a file, click on the
Terminal tab and run the following command.

gunzip -k ./data/countData.HEART.csv.gz

:::

Once that file is uncompressed, it can be imported. Count files can be
very long and wide, so it is a good idea to only view the first (or
last) few rows and columns. Typically, a gene identifier (like an
ensemble id) will be used as the row names. We can use `dim` to see how
many rows and columns are in the file.

``` r
counts <- read.csv("./data/countData.HEART.csv", 
                   header = TRUE, row.names = 1)
dim(counts)
```

    ## [1] 63856   306

``` r
head(counts)[1:5]
```

    ##                   GTEX.12ZZX.0726.SM.5EGKA.1 GTEX.13D11.1526.SM.5J2NA.1
    ## ENSG00000278704.1                          0                          0
    ## ENSG00000277400.1                          0                          0
    ## ENSG00000274847.1                          0                          0
    ## ENSG00000277428.1                          0                          0
    ## ENSG00000276256.1                          0                          0
    ## ENSG00000278198.1                          0                          0
    ##                   GTEX.ZAJG.0826.SM.5PNVA.1 GTEX.11TT1.1426.SM.5EGIA.1
    ## ENSG00000278704.1                         0                          0
    ## ENSG00000277400.1                         0                          0
    ## ENSG00000274847.1                         0                          0
    ## ENSG00000277428.1                         0                          0
    ## ENSG00000276256.1                         0                          0
    ## ENSG00000278198.1                         0                          0
    ##                   GTEX.13VXT.1126.SM.5LU3A.1
    ## ENSG00000278704.1                          0
    ## ENSG00000277400.1                          0
    ## ENSG00000274847.1                          0
    ## ENSG00000277428.1                          0
    ## ENSG00000276256.1                          0
    ## ENSG00000278198.1                          0

This “countData” was generated by using `recount3` as described in the
file `scripts/recount3.Rmd`. It comes from a Ranged Summarized
Experiment (rse) which contains quantitative information about read
counts as well as quality control information and sample descriptions.
The “colData” from an rse can also be obtained. This information
*should* match the information in our samples file, but there can be
subtle differences in formatting Let’s read the colData file for the
heart samples.

``` r
colData <- read.csv("./data/colData.HEART.csv")
head(colData)
```

    ##                            X                external_id
    ## 1 GTEX-12ZZX-0726-SM-5EGKA.1 GTEX-12ZZX-0726-SM-5EGKA.1
    ## 2 GTEX-13D11-1526-SM-5J2NA.1 GTEX-13D11-1526-SM-5J2NA.1
    ## 3  GTEX-ZAJG-0826-SM-5PNVA.1  GTEX-ZAJG-0826-SM-5PNVA.1
    ## 4 GTEX-11TT1-1426-SM-5EGIA.1 GTEX-11TT1-1426-SM-5EGIA.1
    ## 5 GTEX-13VXT-1126-SM-5LU3A.1 GTEX-13VXT-1126-SM-5LU3A.1
    ## 6 GTEX-14ASI-0826-SM-5Q5EB.1 GTEX-14ASI-0826-SM-5Q5EB.1
    ##                 gtex.smtsd study gtex.smts gtex.subjid              gtex.sampid
    ## 1 Heart - Atrial Appendage HEART     Heart  GTEX-12ZZX GTEX-12ZZX-0726-SM-5EGKA
    ## 2 Heart - Atrial Appendage HEART     Heart  GTEX-13D11 GTEX-13D11-1526-SM-5J2NA
    ## 3   Heart - Left Ventricle HEART     Heart   GTEX-ZAJG  GTEX-ZAJG-0826-SM-5PNVA
    ## 4 Heart - Atrial Appendage HEART     Heart  GTEX-11TT1 GTEX-11TT1-1426-SM-5EGIA
    ## 5   Heart - Left Ventricle HEART     Heart  GTEX-13VXT GTEX-13VXT-1126-SM-5LU3A
    ## 6 Heart - Atrial Appendage HEART     Heart  GTEX-14ASI GTEX-14ASI-0826-SM-5Q5EB
    ##   gtex.run_acc gtex.sex gtex.age gtex.dthhrdy gtex.smrin gtex.smcenter
    ## 1   SRR1340617        2    40-49            1        7.1            C1
    ## 2   SRR1345436        2    50-59            0        8.9            B1
    ## 3   SRR1367456        2    50-59            3        6.4            C1
    ## 4   SRR1378243        1    20-29            0        9.0            B1
    ## 5   SRR1381693        2    20-29            0        8.6            B1
    ## 6   SRR1335164        1    60-69            2        6.4            C1
    ##                                                          gtex.smpthnts
    ## 1             2 pieces, adherent/interstitial fat is ~40% of specimens
    ## 2                     2 pieces, no abnormalities, ~25% fat, delineated
    ## 3 2 pieces, mild-moderate interstitial fibrosis, mild ischemic changes
    ## 4                                       2 pieces, one piece is 40% fat
    ## 5                          2 pieces; 1 piece contains 30% external fat
    ## 6                                                             2 pieces
    ##   gtex.smnabtchd recount_qc.aligned_reads..chrm recount_qc.aligned_reads..chrx
    ## 1     10/22/2013                          21.68                           1.95
    ## 2     12/04/2013                          22.77                           1.82
    ## 3     10/31/2013                          27.67                           1.76
    ## 4     10/24/2013                          23.99                           1.98
    ## 5     12/17/2013                          33.66                           1.52
    ## 6     01/17/2014                          15.45                           1.99
    ##   recount_qc.aligned_reads..chry recount_qc.bc_auc.all_reads_all_bases
    ## 1                           0.00                            5121146510
    ## 2                           0.00                            6606164884
    ## 3                           0.01                            5307211837
    ## 4                           0.05                            4433076550
    ## 5                           0.00                            7188560773
    ## 6                           0.08                            7130421400
    ##         Date
    ## 1 2013-10-22
    ## 2 2013-12-04
    ## 3 2013-10-31
    ## 4 2013-10-24
    ## 5 2013-12-17
    ## 6 2014-01-17

:::warning

#### Challenge

What commands could you use to read the following files: 1. GTEx results
comparing the muscles of 20-29 year old to 70-79 year olds? 1. The csv
file information describing the muscle samples?

:::spoiler

1.  `read.table("./data/GTEx_Muscle_20-29_vs_70-79.tsv")`
2.  `read.csv("./data/colData.MUSCLE.csv")`

:::

#### Quick summary statistics and sample size

You have now seen a variety of options for importing files. You may use
many more in your R-based RNA-seq workflow, but these basics will get
you started. Let’s now explore the functions `summary()`, `length()`,
`dim()`, and `count()` us to quickly summarize and compare data frames
to answer the following questions.

How many transcripts were counted in the Heart tissues? Over 63,000.

``` r
dim(counts)
```

    ## [1] 63856   306

``` r
length(row.names(counts))
```

    ## [1] 63856

How many genes are in this version of the human transcriptome? Over
15,000.

``` r
dim(genes)
```

    ## [1] 15659     8

``` r
length(genes$Approved.symbol)
```

    ## [1] 15659

How many samples are there in the GTEx portal (as of this version)? Over
25,000!

``` r
dim(samples)
```

    ## [1] 25713     8

``` r
length(samples$Tissue.Sample.ID)
```

    ## [1] 25713

How many samples are there per tissue?

``` r
dplyr::count(samples, Tissue) 
```

    ##                                   Tissue    n
    ## 1                 Adipose - Subcutaneous  978
    ## 2           Adipose - Visceral (Omentum)  815
    ## 3                          Adrenal Gland  717
    ## 4                         Artery - Aorta  858
    ## 5                      Artery - Coronary  662
    ## 6                        Artery - Tibial  979
    ## 7                                Bladder  130
    ## 8                     Brain - Cerebellum  426
    ## 9                         Brain - Cortex  428
    ## 10               Breast - Mammary Tissue  894
    ## 11                   Cervix - Ectocervix   38
    ## 12                   Cervix - Endocervix   42
    ## 13                       Colon - Sigmoid  800
    ## 14                    Colon - Transverse  937
    ## 15 Esophagus - Gastroesophageal Junction  787
    ## 16                    Esophagus - Mucosa  963
    ## 17                Esophagus - Muscularis  958
    ## 18                        Fallopian Tube   43
    ## 19              Heart - Atrial Appendage  614
    ## 20                Heart - Left Ventricle  761
    ## 21                       Kidney - Cortex  557
    ## 22                      Kidney - Medulla   49
    ## 23                                 Liver  610
    ## 24                                  Lung  860
    ## 25                  Minor Salivary Gland  247
    ## 26                     Muscle - Skeletal 1001
    ## 27                        Nerve - Tibial  975
    ## 28                                 Ovary  255
    ## 29                              Pancreas  865
    ## 30                             Pituitary  428
    ## 31                              Prostate  599
    ## 32   Skin - Not Sun Exposed (Suprapubic)  818
    ## 33        Skin - Sun Exposed (Lower leg) 1001
    ## 34      Small Intestine - Terminal Ileum  798
    ## 35                                Spleen  874
    ## 36                               Stomach  939
    ## 37                                Testis  592
    ## 38                               Thyroid  902
    ## 39                                Uterus  237
    ## 40                                Vagina  276

How many samples are there per tissue and sex? Can we test the effect of
sex on gene expression in all tissues? For many samples, yes, but not
all tissues were samples from both males and females.

``` r
dplyr::count(samples, Tissue, Sex) 
```

    ##                                   Tissue    Sex   n
    ## 1                 Adipose - Subcutaneous female 325
    ## 2                 Adipose - Subcutaneous   male 653
    ## 3           Adipose - Visceral (Omentum) female 269
    ## 4           Adipose - Visceral (Omentum)   male 546
    ## 5                          Adrenal Gland female 232
    ## 6                          Adrenal Gland   male 485
    ## 7                         Artery - Aorta female 281
    ## 8                         Artery - Aorta   male 577
    ## 9                      Artery - Coronary female 227
    ## 10                     Artery - Coronary   male 435
    ## 11                       Artery - Tibial female 324
    ## 12                       Artery - Tibial   male 655
    ## 13                               Bladder female  51
    ## 14                               Bladder   male  79
    ## 15                    Brain - Cerebellum female 121
    ## 16                    Brain - Cerebellum   male 305
    ## 17                        Brain - Cortex female 121
    ## 18                        Brain - Cortex   male 307
    ## 19               Breast - Mammary Tissue female 306
    ## 20               Breast - Mammary Tissue   male 588
    ## 21                   Cervix - Ectocervix female  38
    ## 22                   Cervix - Endocervix female  42
    ## 23                       Colon - Sigmoid female 261
    ## 24                       Colon - Sigmoid   male 539
    ## 25                    Colon - Transverse female 313
    ## 26                    Colon - Transverse   male 624
    ## 27 Esophagus - Gastroesophageal Junction female 256
    ## 28 Esophagus - Gastroesophageal Junction   male 531
    ## 29                    Esophagus - Mucosa female 327
    ## 30                    Esophagus - Mucosa   male 636
    ## 31                Esophagus - Muscularis female 325
    ## 32                Esophagus - Muscularis   male 633
    ## 33                        Fallopian Tube female  43
    ## 34              Heart - Atrial Appendage female 198
    ## 35              Heart - Atrial Appendage   male 416
    ## 36                Heart - Left Ventricle female 252
    ## 37                Heart - Left Ventricle   male 509
    ## 38                       Kidney - Cortex female 167
    ## 39                       Kidney - Cortex   male 390
    ## 40                      Kidney - Medulla female  16
    ## 41                      Kidney - Medulla   male  33
    ## 42                                 Liver female 192
    ## 43                                 Liver   male 418
    ## 44                                  Lung female 282
    ## 45                                  Lung   male 578
    ## 46                  Minor Salivary Gland female  74
    ## 47                  Minor Salivary Gland   male 173
    ## 48                     Muscle - Skeletal female 335
    ## 49                     Muscle - Skeletal   male 666
    ## 50                        Nerve - Tibial female 325
    ## 51                        Nerve - Tibial   male 650
    ## 52                                 Ovary female 255
    ## 53                              Pancreas female 287
    ## 54                              Pancreas   male 578
    ## 55                             Pituitary female 121
    ## 56                             Pituitary   male 307
    ## 57                              Prostate   male 599
    ## 58   Skin - Not Sun Exposed (Suprapubic) female 267
    ## 59   Skin - Not Sun Exposed (Suprapubic)   male 551
    ## 60        Skin - Sun Exposed (Lower leg) female 335
    ## 61        Skin - Sun Exposed (Lower leg)   male 666
    ## 62      Small Intestine - Terminal Ileum female 261
    ## 63      Small Intestine - Terminal Ileum   male 537
    ## 64                                Spleen female 289
    ## 65                                Spleen   male 585
    ## 66                               Stomach female 317
    ## 67                               Stomach   male 622
    ## 68                                Testis   male 592
    ## 69                               Thyroid female 308
    ## 70                               Thyroid   male 594
    ## 71                                Uterus female 237
    ## 72                                Vagina female 276

How many samples are there per sex, age, and hardy scale in the HEART
tissues? Do you have enough samples to test the effects of Sex, Age, and
Hardy Scale in the Heart?

*Note: Let’s use the colData data frame for this since it is specific to
Heart. Later we will talk about subsetting.*

``` r
#names(colData)
dplyr::count(colData, gtex.smts, gtex.sex, gtex.age, gtex.dthhrdy) 
```

    ##    gtex.smts gtex.sex gtex.age gtex.dthhrdy  n
    ## 1      Heart        1    20-29            0  2
    ## 2      Heart        1    20-29            2  1
    ## 3      Heart        1    30-39            0 12
    ## 4      Heart        1    30-39            1  4
    ## 5      Heart        1    40-49            0 15
    ## 6      Heart        1    40-49            2  7
    ## 7      Heart        1    40-49            3  2
    ## 8      Heart        1    40-49            4  3
    ## 9      Heart        1    50-59            0 32
    ## 10     Heart        1    50-59            2 24
    ## 11     Heart        1    50-59            3  5
    ## 12     Heart        1    50-59            4  7
    ## 13     Heart        1    60-69            0 18
    ## 14     Heart        1    60-69            1  4
    ## 15     Heart        1    60-69            2 36
    ## 16     Heart        1    60-69            3 12
    ## 17     Heart        1    60-69            4  9
    ## 18     Heart        1    70-79            0  2
    ## 19     Heart        1    70-79            2  3
    ## 20     Heart        2    20-29            0  6
    ## 21     Heart        2    30-39            0  3
    ## 22     Heart        2    40-49            0 15
    ## 23     Heart        2    40-49            1  3
    ## 24     Heart        2    40-49            3  1
    ## 25     Heart        2    50-59            0 27
    ## 26     Heart        2    50-59            2  7
    ## 27     Heart        2    50-59            3  4
    ## 28     Heart        2    50-59            4  2
    ## 29     Heart        2    60-69            0 24
    ## 30     Heart        2    60-69            1  1
    ## 31     Heart        2    60-69            2  9
    ## 32     Heart        2    60-69            3  3
    ## 33     Heart        2    60-69            4  3

:::warning

#### Challenge

What series commands would you use to import the
`data/colData.MUSCLE.csv` and count the number of muscles samples per
sex, age?

How many female muscles samples are there from age group 30-39?

*Hint: use head() or names() after importing a file to verify the
variable names.*

:::spoiler

df \<- read.csv(“./data/colData.MUSCLE.csv”) dplyr::count(df, gtex.smts,
gtex.sex, gtex.age) # 3 samples are in the female group age 30-39

:::

Finally, the `str()` and `summary()` commands are also quite useful for
summarizing every variable in a data frame. These let you know if R has
imported columns properly as integers, characters or factors.

``` r
str(samples)
```

    ## 'data.frame':    25713 obs. of  8 variables:
    ##  $ Tissue.Sample.ID    : chr  "GTEX-1117F-0126" "GTEX-1117F-0226" "GTEX-1117F-0326" "GTEX-1117F-0426" ...
    ##  $ Tissue              : chr  "Skin - Sun Exposed (Lower leg)" "Adipose - Subcutaneous" "Nerve - Tibial" "Muscle - Skeletal" ...
    ##  $ Subject.ID          : chr  "GTEX-1117F" "GTEX-1117F" "GTEX-1117F" "GTEX-1117F" ...
    ##  $ Sex                 : chr  "female" "female" "female" "female" ...
    ##  $ Age.Bracket         : chr  "60-69" "60-69" "60-69" "60-69" ...
    ##  $ Hardy.Scale         : chr  "Slow death" "Slow death" "Slow death" "Slow death" ...
    ##  $ Pathology.Categories: chr  "" "" "clean_specimens" "" ...
    ##  $ Pathology.Notes     : chr  "6 pieces, minimal fat, squamous epithelium is ~50-70 microns" "2 pieces, ~15% vessel stroma, rep delineated" "2 pieces, clean specimens" "2 pieces, !5% fibrous connective tissue, delineated (rep)" ...

``` r
summary(samples)
```

    ##  Tissue.Sample.ID      Tissue           Subject.ID            Sex           
    ##  Length:25713       Length:25713       Length:25713       Length:25713      
    ##  Class :character   Class :character   Class :character   Class :character  
    ##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
    ##  Age.Bracket        Hardy.Scale        Pathology.Categories Pathology.Notes   
    ##  Length:25713       Length:25713       Length:25713         Length:25713      
    ##  Class :character   Class :character   Class :character     Class :character  
    ##  Mode  :character   Mode  :character   Mode  :character     Mode  :character

``` r
str(results2)
```

    ## 'data.frame':    15529 obs. of  7 variables:
    ##  $ X        : chr  "A1BG" "A1BG-AS1" "A2M" "A2M-AS1" ...
    ##  $ logFC    : num  0.1033 0.1361 -0.0161 0.6051 0.3541 ...
    ##  $ AveExpr  : num  1.346 -0.238 9.798 2.539 -1.167 ...
    ##  $ t        : num  0.322 0.64 -0.113 3.488 1.079 ...
    ##  $ P.Value  : num  0.748222 0.524426 0.910141 0.000813 0.28409 ...
    ##  $ adj.P.Val: num  0.8748 0.7308 0.9565 0.0555 0.5292 ...
    ##  $ B        : num  -5.673 -5.346 -5.957 -0.635 -4.949 ...

``` r
summary(results2)
```

    ##       X                 logFC              AveExpr             t           
    ##  Length:15529       Min.   :-2.917546   Min.   :-2.303   Min.   :-4.64984  
    ##  Class :character   1st Qu.:-0.131376   1st Qu.: 2.108   1st Qu.:-1.12926  
    ##  Mode  :character   Median : 0.009261   Median : 4.171   Median : 0.07798  
    ##                     Mean   : 0.026300   Mean   : 3.806   Mean   : 0.03410  
    ##                     3rd Qu.: 0.170189   3rd Qu.: 5.586   3rd Qu.: 1.21902  
    ##                     Max.   : 2.659235   Max.   :13.593   Max.   : 5.38745  
    ##     P.Value            adj.P.Val             B         
    ##  Min.   :0.0000008   Min.   :0.01209   Min.   :-6.250  
    ##  1st Qu.:0.0568327   1st Qu.:0.22729   1st Qu.:-5.839  
    ##  Median :0.2412433   Median :0.48246   Median :-5.306  
    ##  Mean   :0.3345941   Mean   :0.49944   Mean   :-4.852  
    ##  3rd Qu.:0.5772327   3rd Qu.:0.76952   3rd Qu.:-4.282  
    ##  Max.   :0.9999816   Max.   :0.99998   Max.   : 5.635

``` r
str(counts[1:5])
```

    ## 'data.frame':    63856 obs. of  5 variables:
    ##  $ GTEX.12ZZX.0726.SM.5EGKA.1: int  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ GTEX.13D11.1526.SM.5J2NA.1: int  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ GTEX.ZAJG.0826.SM.5PNVA.1 : int  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ GTEX.11TT1.1426.SM.5EGIA.1: int  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ GTEX.13VXT.1126.SM.5LU3A.1: int  0 0 0 0 0 0 0 0 0 0 ...

``` r
summary(counts[1:5])
```

    ##  GTEX.12ZZX.0726.SM.5EGKA.1 GTEX.13D11.1526.SM.5J2NA.1
    ##  Min.   :        0          Min.   :        0         
    ##  1st Qu.:        0          1st Qu.:        0         
    ##  Median :       95          Median :       76         
    ##  Mean   :    75254          Mean   :   103343         
    ##  3rd Qu.:     9058          3rd Qu.:     9584         
    ##  Max.   :164409376          Max.   :407066080         
    ##  GTEX.ZAJG.0826.SM.5PNVA.1 GTEX.11TT1.1426.SM.5EGIA.1
    ##  Min.   :        0         Min.   :        0         
    ##  1st Qu.:        0         1st Qu.:        0         
    ##  Median :       70         Median :       38         
    ##  Mean   :    80789         Mean   :    69070         
    ##  3rd Qu.:     8988         3rd Qu.:     7366         
    ##  Max.   :338010074         Max.   :263027953         
    ##  GTEX.13VXT.1126.SM.5LU3A.1
    ##  Min.   :        0         
    ##  1st Qu.:        0         
    ##  Median :       47         
    ##  Mean   :   111238         
    ##  3rd Qu.:     6710         
    ##  Max.   :602494565

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

## Visualize (Part 1)

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
ggplot(samples, aes(x = Tissue)) +
  geom_bar(stat = "count")
```

![](./images/bar1-1.png)<!-- -->

In the last section, we will discuss how to modify the `themes()` to
adjust the axes, legends, and more. For now, let’s flip the x and y
coordinates so that we can read the sample names. We do this by adding a
layer and the function `coord_flip()`

``` r
ggplot(samples, aes(x = Tissue)) +
  geom_bar(stat = "count") + 
  coord_flip()
```

![](./images/bar2-1.png)<!-- -->

Now, there are two ways we can visualize another variable in addition to
tissue. We can add color or we can add facets.

Let’s first color the data by age bracket. Color is an aesthetic, so it
must go inside the `aes()`. If you include `aes(color = Age.Bracket)`
inside `ggplot()`, the color will be applied to every layer in your
plot. If you add `aes(color = Age.Bracket)` inside `geom_bar()`, it will
only be applied to that layer (which is important later when you layer
multiple geoms.

head(samples)

``` r
ggplot(samples, aes(x = Tissue, color = Age.Bracket)) +
  geom_bar(stat = "count") + 
  coord_flip()
```

![](./images/bar3-1.png)<!-- -->

Note that the bars are outlined in a color according to hardy scale. If
instead, you would the bars “filled” with color, use the aesthetic
`aes(fill = Hardy.Scale)`

``` r
ggplot(samples, aes(x = Tissue, fill = Age.Bracket)) +
  geom_bar(stat = "count") + 
  coord_flip()
```

![](./images/bar4-1.png)<!-- -->

Now, let’s use `facet_wrap(~Sex)` to break the data into two groups
based on the variable sex.

``` r
ggplot(samples, aes(x = Tissue, fill = Age.Bracket)) +
  geom_bar(stat = "count") + 
  coord_flip() +
  facet_wrap(~Sex)
```

![](./images/bar5-1.png)<!-- --> With this graph, we have an excellent
overview of the total numbers of RNA-Seq samples in the GTEx project,
and we can see where we are missing data (for good biological reasons).
However, this plot doesn’t show us Hardy Scale. It’s hard to layer 4
variables, so let’s remove Tissue as a variable by focusing just on one
Tissue.

:::warning

#### Challenge

Create a plot showing the total number of samples per Sex, Age Bracket,
and Hardy Scale for *just* the Heart samples. Paste the code you used in
the chat.

:::spoiler

There are many options. Here are a few.

ggplot(colData, aes(x = gtex.dthhrdy, fill = gtex.age)) + geom_bar(stat
= “count”) + facet_wrap(\~gtex.sex)

ggplot(colData, aes(x = gtex.age, fill = as.factor(gtex.dthhrdy))) +
geom_bar(stat = “count”) + facet_wrap(\~gtex.sex)

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

:::warning #### Challenge

Create a volcano plot for the results comparing the heart tissue of
20-29 year olds to that of 70-70 year olds? Are there more or less
differential expressed gene between 20 and 30 year olds or 20 and 70
year olds?

:::spoiler

df \<- read.table(“./data/GTEx_Heart_20-29_vs_70-79.tsv”)

ggplot(df, aes(x = logFC, y = -log10(adj.P.Val))) + geom_point() +
geom_hline(yintercept = -log10(0.05))

# more

:::

In addition to containing information about the donor tissue, the
“colData” file contains has a column with a RIN score, which tells us
about the quality of the data, and the facility where the RNA was
processed. If we wanted to confirm visually that were negligible
technical differences in RNA quality due to sequencing location, we
could use a box plot.

``` r
  ggplot(colData, aes(x = gtex.smcenter, y = gtex.smrin)) +
    geom_boxplot() +
    geom_jitter(aes(color = gtex.smrin))
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
| `geom_point()` | A function used to create scatterplots                                                                                  |
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
results2 %>% rename(Approved.symbol = X)   
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

    ## # A tibble: 15,529 × 7
    ##    Approved.symbol   logFC AveExpr      t  P.Value adj.P.Val      B
    ##    <chr>             <dbl>   <dbl>  <dbl>    <dbl>     <dbl>  <dbl>
    ##  1 A1BG             0.103    1.35   0.322 0.748       0.875  -5.67 
    ##  2 A1BG-AS1         0.136   -0.238  0.640 0.524       0.731  -5.35 
    ##  3 A2M             -0.0161   9.80  -0.113 0.910       0.956  -5.96 
    ##  4 A2M-AS1          0.605    2.54   3.49  0.000813    0.0555 -0.635
    ##  5 A2ML1            0.354   -1.17   1.08  0.284       0.529  -4.95 
    ##  6 A2MP1            0.658   -0.756  3.26  0.00166     0.0607 -1.36 
    ##  7 A4GALT           0.0655   6.54   0.565 0.574       0.767  -6.07 
    ##  8 AAAS             0.192    5.48   1.99  0.0504      0.214  -4.37 
    ##  9 AACS             0.0341   4.51   0.441 0.660       0.823  -6.11 
    ## 10 AADAT            0.355    1.88   2.94  0.00432     0.0763 -2.04 
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
rearranging by p-value, let’s arrange by gene symbol. LEt’s also convert
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
What are the differentially expressed genes?

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
in a single, tidy data frameor tibble. To process the counts data using
the DESeq2 pipeline, we need a corresponding file where the row names
are the sample id and they match the column names of the counts file. We
confirm this by asking if `rownames(colData) == colnames(counts)` or by
checking the dimensions of each. Using `head()` is a good way to only
print 5 rows. Using `[1:5]` is a good way to only print 5 columns.

I also like to create `counts_tidy_long` file that can be easily subset
by variables or genes of interest. To create this, we need to combine
three data frames: genes, colData (or Samples), and counts.

In this section, we will combine tidying, transforming, and visualizing
to answer the question “What are the raw counts of the differentially
expressed genes?”

``` r
head(rownames(colData) == colnames(counts))
```

    ## [1] FALSE FALSE FALSE FALSE FALSE FALSE

``` r
head(colnames(counts))
```

    ## [1] "GTEX.12ZZX.0726.SM.5EGKA.1" "GTEX.13D11.1526.SM.5J2NA.1"
    ## [3] "GTEX.ZAJG.0826.SM.5PNVA.1"  "GTEX.11TT1.1426.SM.5EGIA.1"
    ## [5] "GTEX.13VXT.1126.SM.5LU3A.1" "GTEX.14ASI.0826.SM.5Q5EB.1"

``` r
head(rownames(colData))
```

    ## [1] "1" "2" "3" "4" "5" "6"

``` r
head(colData$X)
```

    ## [1] "GTEX-12ZZX-0726-SM-5EGKA.1" "GTEX-13D11-1526-SM-5J2NA.1"
    ## [3] "GTEX-ZAJG-0826-SM-5PNVA.1"  "GTEX-11TT1-1426-SM-5EGIA.1"
    ## [5] "GTEX-13VXT-1126-SM-5LU3A.1" "GTEX-14ASI-0826-SM-5Q5EB.1"

``` r
colData_tidy <-  colData %>%
  mutate(X = gsub("-", ".", X))  %>%
  filter(gtex.age %in% c("20-29", "70-79")) %>%
  mutate(gtex.age = factor(gtex.age))
rownames(colData_tidy) <- colData_tidy$X

head(rownames(colData_tidy) == colnames(counts))
```

    ## Warning in rownames(colData_tidy) == colnames(counts): longer object length is
    ## not a multiple of shorter object length

    ## [1] FALSE FALSE FALSE FALSE FALSE FALSE

``` r
mycols <- colData_tidy %>% dplyr::pull(X)

counts_tidy <- counts %>%
  select(all_of(mycols))

head(rownames(colData_tidy) == colnames(counts_tidy))
```

    ## [1] TRUE TRUE TRUE TRUE TRUE TRUE

``` r
counts_tidy_long <- counts %>%
  select(all_of(mycols)) %>%
  mutate(Ensembl.gene.ID = rownames(.)) %>%
  separate(Ensembl.gene.ID, into = c("Ensembl.gene.ID", "version"), 
           sep = "\\.") %>%
  filter(Ensembl.gene.ID %in% all_of(DEGsENSG)) %>%
  pivot_longer(cols = all_of(mycols), names_to = "X", 
               values_to = "counts") %>%
  inner_join(., colData_tidy, by = "X") %>%
  arrange(desc(counts)) %>%
  inner_join(., genes, by = "Ensembl.gene.ID") %>%
  select(Ensembl.gene.ID, Approved.name, Approved.symbol, counts, 
         X, gtex.smtsd, study, gtex.age, gtex.sex, gtex.dthhrdy, 
         gtex.smcenter)
head(counts_tidy_long)
```

    ## # A tibble: 6 × 11
    ##   Ensembl.gene.ID Approved.name  Approved.symbol  counts X      gtex.smtsd study
    ##   <chr>           <chr>          <chr>             <dbl> <chr>  <chr>      <chr>
    ## 1 ENSG00000148677 ankyrin repea… ANKRD1           5.54e7 GTEX.… Heart - L… HEART
    ## 2 ENSG00000148677 ankyrin repea… ANKRD1           4.65e7 GTEX.… Heart - L… HEART
    ## 3 ENSG00000148677 ankyrin repea… ANKRD1           1.84e7 GTEX.… Heart - A… HEART
    ## 4 ENSG00000148677 ankyrin repea… ANKRD1           1.58e7 GTEX.… Heart - A… HEART
    ## 5 ENSG00000148677 ankyrin repea… ANKRD1           1.22e7 GTEX.… Heart - L… HEART
    ## 6 ENSG00000148677 ankyrin repea… ANKRD1           1.12e7 GTEX.… Heart - L… HEART
    ## # … with 4 more variables: gtex.age <fct>, gtex.sex <int>, gtex.dthhrdy <int>,
    ## #   gtex.smcenter <chr>

``` r
counts_tidy_long %>%
  ggplot(aes(x = gtex.age, y = counts)) +
  geom_boxplot() +
  geom_point() +
  facet_wrap(~Approved.symbol, scales = "free_y") +
  scale_y_log10(labels = label_number_si())
```

    ## Warning: Transformation introduced infinite values in continuous y-axis

    ## Warning: Transformation introduced infinite values in continuous y-axis

    ## Warning: Removed 1 rows containing non-finite values (stat_boxplot).

![](./images/boxplot2-1.png)<!-- -->

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

### Appendix

``` r
library(ggplot2)
library(tidyr)
library(dplyr)
library(readr)
library(tibble)
library(cowplot)
library(scales)
library(forcats)
library(stringr)

samples <- read.csv("./data/GTExPortal.csv")


head(samples)
names(samples)


# with row.names
results <- read.table("./data/GTEx_Heart_20-29_vs_30-39.tsv")
head(results)

# without row.names
results2 <- read.table("./data/GTEx_Heart_20-29_vs_30-39.tsv",  sep = "\t", header = TRUE )
head(results2)


genes <- read.table("./data/genes.txt", sep = "\t",  header = T, fill = T)
head(genes)


# Open the Terminal and type the command (after the $) to uznip
# $ gunzip -k ./data/countData.*.gz


counts <- read.csv("./data/countData.HEART.csv", 
                   header = TRUE, row.names = 1)
dim(counts)
head(counts)[1:5]


colData <- read.csv("./data/colData.HEART.csv")
head(colData)


dim(counts)
length(row.names(counts))


dim(genes)
length(genes$Approved.symbol)


dim(samples)
length(samples$Tissue.Sample.ID)


dplyr::count(samples, Tissue) 


dplyr::count(samples, Tissue, Sex) 


#names(colData)
dplyr::count(colData, gtex.smts, gtex.sex, gtex.age, gtex.dthhrdy) 


str(samples)
summary(samples)

str(results2)
summary(results2)

str(counts[1:5])
summary(counts[1:5])


ggplot(samples, aes(x = Tissue)) +
  geom_bar(stat = "count")


ggplot(samples, aes(x = Tissue)) +
  geom_bar(stat = "count") + 
  coord_flip()


ggplot(samples, aes(x = Tissue, color = Age.Bracket)) +
  geom_bar(stat = "count") + 
  coord_flip()


ggplot(samples, aes(x = Tissue, fill = Age.Bracket)) +
  geom_bar(stat = "count") + 
  coord_flip()


ggplot(samples, aes(x = Tissue, fill = Age.Bracket)) +
  geom_bar(stat = "count") + 
  coord_flip() +
  facet_wrap(~Sex)


ggplot(results, aes(x = logFC, y = -log10(adj.P.Val))) +
  geom_point() 


ggplot(results, aes(x = logFC, y = -log10(adj.P.Val))) +
  geom_point() +
  geom_hline(yintercept = -log10(0.05))


  ggplot(colData, aes(x = gtex.smcenter, y = gtex.smrin)) +
    geom_boxplot() +
    geom_jitter(aes(color = gtex.smrin))


results %>% mutate(Approved.symbol = row.names(.))  
results2 %>% rename(Approved.symbol = X)   


results %>% filter(adj.P.Val < 0.05,
                   logFC > 1 | logFC < -1)


results %>% arrange(adj.P.Val) 


resultsDEGs <- results %>% 
  mutate(Approved.symbol = row.names(.))  %>% 
  filter(adj.P.Val < 0.05,
         logFC > 1 | logFC < -1) %>%
  arrange(adj.P.Val) 
resultsDEGs


left_join(resultsDEGs, genes, by =  "Approved.symbol")


resultsDEGs %>% select(Approved.symbol, logFC, adj.P.Val)


resultsDEGs <- results %>% 
  mutate(Approved.symbol = row.names(.))  %>% 
  filter(adj.P.Val < 0.05,
         logFC > 1 | logFC < -1) %>% 
  arrange(Approved.symbol) %>%
  left_join(., genes, by =  "Approved.symbol") %>% 
  select(Approved.symbol, Ensembl.gene.ID, logFC, adj.P.Val, Approved.name ) %>%
  as_tibble()
resultsDEGs

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
DEGsENSG <- resultsDEGs %>% pull(Ensembl.gene.ID)
DEGsENSG
DEGsSymbol <- resultsDEGs %>% pull(Approved.symbol)
DEGsSymbol

head(rownames(colData) == colnames(counts))
head(colnames(counts))
head(rownames(colData))
head(colData$X)


colData_tidy <-  colData %>%
  mutate(X = gsub("-", ".", X))  %>%
  filter(gtex.age %in% c("20-29", "70-79")) %>%
  mutate(gtex.age = factor(gtex.age))
rownames(colData_tidy) <- colData_tidy$X

head(rownames(colData_tidy) == colnames(counts))

mycols <- colData_tidy %>% dplyr::pull(X)

counts_tidy <- counts %>%
  select(all_of(mycols))

head(rownames(colData_tidy) == colnames(counts_tidy))


counts_tidy_long <- counts %>%
  select(all_of(mycols)) %>%
  mutate(Ensembl.gene.ID = rownames(.)) %>%
  separate(Ensembl.gene.ID, into = c("Ensembl.gene.ID", "version"), 
           sep = "\\.") %>%
  filter(Ensembl.gene.ID %in% all_of(DEGsENSG)) %>%
  pivot_longer(cols = all_of(mycols), names_to = "X", 
               values_to = "counts") %>%
  inner_join(., colData_tidy, by = "X") %>%
  arrange(desc(counts)) %>%
  inner_join(., genes, by = "Ensembl.gene.ID") %>%
  select(Ensembl.gene.ID, Approved.name, Approved.symbol, counts, 
         X, gtex.smtsd, study, gtex.age, gtex.sex, gtex.dthhrdy, 
         gtex.smcenter)
head(counts_tidy_long)


counts_tidy_long %>%
  ggplot(aes(x = gtex.age, y = counts)) +
  geom_boxplot() +
  geom_point() +
  facet_wrap(~Approved.symbol, scales = "free_y") +
  scale_y_log10(labels = label_number_si())
```
