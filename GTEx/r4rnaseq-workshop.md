# Introduction to R for RNA-Seq Workshop

------------------------------------------------------------------------

*Even though you can
[![hackmd-github-sync-badge](https://hackmd.io/2ArmQGwGT0uUyL5Ehqy0hQ/badge)](https://hackmd.io/2ArmQGwGT0uUyL5Ehqy0hQ),
please make changes by editing [this .Rmd
file](https://github.com/nih-cfde/training-rstudio-binder/blob/data/GTEx/r4rnaseq-workshop.Rmd).*

------------------------------------------------------------------------

**Description**

This free two-hour workshop will provide an overview of the R
programming language and the user-friendly RStudio environment for
exploratory RNA-sequencing analysis. You will be introduced to R syntax,
variables, functions, packages, and data structures. You will learn the
basics of data wrangling including importing data from files,
sub-setting, joining, filtering, and more. You will gain hands-on
practice calculating and visualizing differential gene expression using
popular open-source packages and public RNA-Seq data from the Gene
Expression Tissue Project (GTEx). *Please fill out the pre- and
post-workshop surveys to help us keep these workshops free.*

**When:** Wednesday, March 23, 10 am - 12 pm PT  
**Where:**
[Zoom](https://zoom.us/j/7575820324?pwd=d2UyMEhYZGNiV3kyUFpUL1EwQmthQT09)  
**Instructors:** Dr. Rayna Harris  
**Helpers:** Dr. Amanda Charbonneau, Jessica Lumian, Jeremy Walter

Click
[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/nih-cfde/training-rstudio-binder/data?urlpath=rstudio)
to generate a computing environnment for this workshop.

### Overview

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

For today’s lesson, we will focus on data from the [Gene Expression
Tissue (GTEx) Project](https://commonfund.nih.gov/gtex). The GTEx is an
ongoing effort to build a comprehensive public resource to study
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
-   How is my gene of interest affected by age in the heart and brain?

![](https://hackmd.io/_uploads/SJSIB76b9.png =300x)
![](https://hackmd.io/_uploads/Sk6IrQaZc.png =300x)

![](https://hackmd.io/_uploads/r1mwBQaW5.png =300x)
![](https://hackmd.io/_uploads/HJ5BrXp-c.png =300x)

### Getting Started

1.  Click the
    [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/nih-cfde/training-rstudio-binder/data?urlpath=rstudio)
    button to generate a computing environment for this workshop.
2.  Navigate to the GTEX folder.
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

[Bioconductor](https://www.bioconductor.org) is an open-source software
project developed for the analysis and comprehension of high-throughput
data in genomics and molecular biology. The project aims to enable
interdisciplinary research, collaboration, and rapid development of
scientific software. It is based on the statistical programming language
R. We will not be using these packages in this class, but they are worth
getting to know. This is how you would install and load 3 different
Bioconductor packages.

``` r
#if (!require("BiocManager", quietly = TRUE))
#    install.packages("BiocManager")
#BiocManager::install()

#BiocManager::install(c("recount3", "biomaRt", "DESeq2"))

#library(recount3)
#library(biomaRt)
#library(DESeq2)
```

You can also navigate to “Packages” Tab in the bottom right pane of
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

Data can be imported using packages from base R or the tidyverse.

What are some differences between the data objects imported by
`read.csv()` and `read_csv()`?

1.  Periods versus spaces in column names
2.  Data frame versus tibble
3.  Row names allowed versus not allowed.

The `GTExPortal.csv` file in `./data/` contains information about all
the samples in the GTEx portal. Let’s import this file using
`read.csv()`. Then use `head()` to view the first few lines of each
file.

``` r
samples <- read.csv("./data/GTExPortal.csv")
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

Very large tabular files are often saved as .tsv files. These can be
imported with `read.table()` or `read_tsv()`. You can also specify the
tab delimiter as well as the row and column names.

``` r
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
results2 <- read.table("./data/GTEx_Heart_20-29_vs_30-39.tsv", 
                      sep = "\t", header = TRUE )
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
genes <- read.table("./data/genes.txt", sep = "\t", 
                    header = T, fill = T)
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
dim(genes)
```

    ## [1] 15659     8

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

To process the counts data using the DESEq2 pipeline, we need a
corresponding file where the row names are the sample id and they match
the column names of the counts file. We confirm this by asking if
`rownames(colData) == colnames(counts)` or by checking the dimensions of
each.

Using `head()` is a good way to only print 5 rows. Using `[1:5]` is a
good way to only print 5 columns.

``` r
colData <- read.csv("./data/colData.HEART.csv", 
                    header = TRUE, row.names = 1)
head(colData)[1:5]
```

    ##                                           external_id study gtex.subjid
    ## GTEX_12ZZX_0726_SM_5EGKA.1 GTEX-12ZZX-0726-SM-5EGKA.1 HEART  GTEX-12ZZX
    ## GTEX_13D11_1526_SM_5J2NA.1 GTEX-13D11-1526-SM-5J2NA.1 HEART  GTEX-13D11
    ## GTEX_ZAJG_0826_SM_5PNVA.1   GTEX-ZAJG-0826-SM-5PNVA.1 HEART   GTEX-ZAJG
    ## GTEX_11TT1_1426_SM_5EGIA.1 GTEX-11TT1-1426-SM-5EGIA.1 HEART  GTEX-11TT1
    ## GTEX_13VXT_1126_SM_5LU3A.1 GTEX-13VXT-1126-SM-5LU3A.1 HEART  GTEX-13VXT
    ## GTEX_14ASI_0826_SM_5Q5EB.1 GTEX-14ASI-0826-SM-5Q5EB.1 HEART  GTEX-14ASI
    ##                            gtex.run_acc gtex.sex
    ## GTEX_12ZZX_0726_SM_5EGKA.1   SRR1340617        2
    ## GTEX_13D11_1526_SM_5J2NA.1   SRR1345436        2
    ## GTEX_ZAJG_0826_SM_5PNVA.1    SRR1367456        2
    ## GTEX_11TT1_1426_SM_5EGIA.1   SRR1378243        1
    ## GTEX_13VXT_1126_SM_5LU3A.1   SRR1381693        2
    ## GTEX_14ASI_0826_SM_5Q5EB.1   SRR1335164        1

``` r
head(rownames(colData) == colnames(counts))
```

    ## [1] TRUE TRUE TRUE TRUE TRUE TRUE

:::warning

#### Challenge

What command would you use to read the GTEx results comparing the brains
of 20-29 year old to 70-79 year olds?

:::spoiler

There any multiple solutions to this question. One solution is:

`read.table("./data/GTEx_Brain_20-29_vs_70-79.tsv")`

:::

You have now seen a variety of options for importing files. You may use
many more in your R-based RNA-seq workflow, but these basics will get
you started.

:::success

#### Key functions

| Function              | Description                                                     |
|-----------------------|-----------------------------------------------------------------|
| `read.csv()`          | A base R function for importing comma separated tabular data    |
| `read_csv()`          | A tidyR function for importing .csv files as tibbles            |
| `read.table()`        | A base R function for importing tabular data with any delimiter |
| `read_tsv()`          | A tidyR function for importing .tsv files as tibbles            |
| `head()` and `tail()` | Print the first or last 6 lines of an object                    |
| `dim()`               | A function that prints the dimensions of an object              |
| `as_tibble()`         | Convert dataframes to tibbles                                   |

:::

## Tidy and Transform

Let’s look at the structure of our data frames. The `str()` and
`summary()` commands quickly summarize every variable in a data frame.

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
str(genes)
```

    ## 'data.frame':    15659 obs. of  8 variables:
    ##  $ HGNC.ID                 : chr  "HGNC:5" "HGNC:37133" "HGNC:24086" "HGNC:6" ...
    ##  $ Approved.symbol         : chr  "A1BG" "A1BG-AS1" "A1CF" "A1S9T" ...
    ##  $ Approved.name           : chr  "alpha-1-B glycoprotein" "A1BG antisense RNA 1" "APOBEC1 complementation factor" "symbol withdrawn, see [HGNC:12469](/data/gene-symbol-report/" ...
    ##  $ Chromosome              : chr  "19q13.43" "19q13.43" "10q11.23" "" ...
    ##  $ Accession.numbers       : chr  "" "BC040926" "AF271790" "" ...
    ##  $ NCBI.Gene.ID            : int  1 503538 29974 NA 2 144571 144568 NA NA 3 ...
    ##  $ Ensembl.gene.ID         : chr  "ENSG00000121410" "ENSG00000268895" "ENSG00000148584" "" ...
    ##  $ Mouse.genome.database.ID: chr  "MGI:2152878" "" "MGI:1917115" "" ...

``` r
summary(genes)
```

    ##    HGNC.ID          Approved.symbol    Approved.name       Chromosome       
    ##  Length:15659       Length:15659       Length:15659       Length:15659      
    ##  Class :character   Class :character   Class :character   Class :character  
    ##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
    ##                                                                             
    ##                                                                             
    ##                                                                             
    ##                                                                             
    ##  Accession.numbers   NCBI.Gene.ID       Ensembl.gene.ID   
    ##  Length:15659       Min.   :        1   Length:15659      
    ##  Class :character   1st Qu.:    10557   Class :character  
    ##  Mode  :character   Median :    84280   Mode  :character  
    ##                     Mean   : 21735231                     
    ##                     3rd Qu.:   645433                     
    ##                     Max.   :124188214                     
    ##                     NA's   :2423                          
    ##  Mouse.genome.database.ID
    ##  Length:15659            
    ##  Class :character        
    ##  Mode  :character        
    ##                          
    ##                          
    ##                          
    ## 

``` r
summary(counts[1:5])
```

    ##  GTEX_12ZZX_0726_SM_5EGKA.1 GTEX_13D11_1526_SM_5J2NA.1
    ##  Min.   :        0          Min.   :        0         
    ##  1st Qu.:        0          1st Qu.:        0         
    ##  Median :       95          Median :       76         
    ##  Mean   :    75254          Mean   :   103343         
    ##  3rd Qu.:     9058          3rd Qu.:     9584         
    ##  Max.   :164409376          Max.   :407066080         
    ##  GTEX_ZAJG_0826_SM_5PNVA.1 GTEX_11TT1_1426_SM_5EGIA.1
    ##  Min.   :        0         Min.   :        0         
    ##  1st Qu.:        0         1st Qu.:        0         
    ##  Median :       70         Median :       38         
    ##  Mean   :    80789         Mean   :    69070         
    ##  3rd Qu.:     8988         3rd Qu.:     7366         
    ##  Max.   :338010074         Max.   :263027953         
    ##  GTEX_13VXT_1126_SM_5LU3A.1
    ##  Min.   :        0         
    ##  1st Qu.:        0         
    ##  Median :       47         
    ##  Mean   :   111238         
    ##  3rd Qu.:     6710         
    ##  Max.   :602494565

The defult classification for each variable may or may not be
appropriate for you analysis. In this section, we will discuss all the
ways to tidy and transform your data.

### Renameing variables to join data frames

In the next section, we will join two data frames by a shared column.
Both the results file and the genes file have a column with gene
symbols, but they do not have the same name.

We can use the `rename` function to rename columns. The first value is
the new name and the second value is the old name. Just in case we get
it wrong, let’s save this as a new object.

``` r
head(results2)
```

    ##          X       logFC    AveExpr          t      P.Value  adj.P.Val         B
    ## 1     A1BG  0.10332788  1.3459363  0.3221575 0.7482217611 0.87480317 -5.672644
    ## 2 A1BG-AS1  0.13609230 -0.2381928  0.6395041 0.5244264675 0.73078056 -5.345563
    ## 3      A2M -0.01605178  9.7981987 -0.1132389 0.9101410387 0.95645802 -5.956689
    ## 4  A2M-AS1  0.60505571  2.5392220  3.4884410 0.0008131523 0.05545654 -0.635100
    ## 5    A2ML1  0.35413535 -1.1667406  1.0788316 0.2840898578 0.52922642 -4.948617
    ## 6    A2MP1  0.65764737 -0.7564399  3.2615528 0.0016630789 0.06067003 -1.358971

``` r
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
head(results2$X)
```

    ## [1] "A1BG"     "A1BG-AS1" "A2M"      "A2M-AS1"  "A2ML1"    "A2MP1"

``` r
head(genes$Approved.symbol)
```

    ## [1] "A1BG"     "A1BG-AS1" "A1CF"     "A1S9T"    "A2M"      "A2M-AS1"

``` r
results_new <- results2 %>%
  dplyr::rename("Approved.symbol" = "X")
head(results_new)
```

    ##   Approved.symbol       logFC    AveExpr          t      P.Value  adj.P.Val
    ## 1            A1BG  0.10332788  1.3459363  0.3221575 0.7482217611 0.87480317
    ## 2        A1BG-AS1  0.13609230 -0.2381928  0.6395041 0.5244264675 0.73078056
    ## 3             A2M -0.01605178  9.7981987 -0.1132389 0.9101410387 0.95645802
    ## 4         A2M-AS1  0.60505571  2.5392220  3.4884410 0.0008131523 0.05545654
    ## 5           A2ML1  0.35413535 -1.1667406  1.0788316 0.2840898578 0.52922642
    ## 6           A2MP1  0.65764737 -0.7564399  3.2615528 0.0016630789 0.06067003
    ##           B
    ## 1 -5.672644
    ## 2 -5.345563
    ## 3 -5.956689
    ## 4 -0.635100
    ## 5 -4.948617
    ## 6 -1.358971

Now that the results and the genes objects both have a column called
`Approved.symbol` they can be joined. The command `full_join()` will
keep all rows of both objects. `left_join` will keep all the rows in the
first object but will drop any rows in the second object that don’t map
onto the first.

``` r
results_genes <- left_join(results_new, genes, by = "Approved.symbol")
head(results_genes)
```

    ##   Approved.symbol       logFC    AveExpr          t      P.Value  adj.P.Val
    ## 1            A1BG  0.10332788  1.3459363  0.3221575 0.7482217611 0.87480317
    ## 2        A1BG-AS1  0.13609230 -0.2381928  0.6395041 0.5244264675 0.73078056
    ## 3             A2M -0.01605178  9.7981987 -0.1132389 0.9101410387 0.95645802
    ## 4         A2M-AS1  0.60505571  2.5392220  3.4884410 0.0008131523 0.05545654
    ## 5           A2ML1  0.35413535 -1.1667406  1.0788316 0.2840898578 0.52922642
    ## 6           A2MP1  0.65764737 -0.7564399  3.2615528 0.0016630789 0.06067003
    ##           B    HGNC.ID                      Approved.name Chromosome
    ## 1 -5.672644     HGNC:5             alpha-1-B glycoprotein   19q13.43
    ## 2 -5.345563 HGNC:37133               A1BG antisense RNA 1   19q13.43
    ## 3 -5.956689     HGNC:7              alpha-2-macroglobulin   12p13.31
    ## 4 -0.635100 HGNC:27057                A2M antisense RNA 1   12p13.31
    ## 5 -4.948617 HGNC:23336       alpha-2-macroglobulin like 1   12p13.31
    ## 6 -1.358971     HGNC:8 alpha-2-macroglobulin pseudogene 1   12p13.31
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

### Creating and columns and lengthening or widening data frames

Most RNA-Seq pipelines require that the counts be in a “wide” format
where each sample is a column and each gene is a row. However, many R
tools prefer data in the long format. I like to create a counts_long
file that can be easily subset by variables or genes of interest.

For this, we must introduce the pipe, `%>%`. This symbol is used to
redirect the output from standard out to another function.

``` r
head(counts)[1:5]
```

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

``` r
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
genes2 <- genes %>%
  mutate(Ensembl.gene.ID = paste(Ensembl.gene.ID, "1", sep = "."))
  

counts_long <-counts %>%
  mutate(Ensembl.gene.ID = row.names(.)) %>%
  pivot_longer(-Ensembl.gene.ID, names_to = "Tissue.Sample.ID", values_to = "counts") %>%
  inner_join(., genes2, by = "Ensembl.gene.ID") %>%
  arrange(desc(counts))
head(counts_long)
```

    ## # A tibble: 6 × 10
    ##   Ensembl.gene.ID  Tissue.Sample.ID counts HGNC.ID Approved.symbol Approved.name
    ##   <chr>            <chr>             <dbl> <chr>   <chr>           <chr>        
    ## 1 ENSG00000163217… GTEX_13D11_1526… 8.28e6 HGNC:2… BMP10           bone morphog…
    ## 2 ENSG00000270641… GTEX_1313W_1426… 7.69e6 HGNC:1… TSIX            TSIX transcr…
    ## 3 ENSG00000163217… GTEX_131YS_0826… 7.25e6 HGNC:2… BMP10           bone morphog…
    ## 4 ENSG00000163217… GTEX_13FTW_0826… 6.89e6 HGNC:2… BMP10           bone morphog…
    ## 5 ENSG00000270641… GTEX_ZAK1_1126_… 6.55e6 HGNC:1… TSIX            TSIX transcr…
    ## 6 ENSG00000163217… GTEX_13O61_0426… 6.18e6 HGNC:2… BMP10           bone morphog…
    ## # … with 4 more variables: Chromosome <chr>, Accession.numbers <chr>,
    ## #   NCBI.Gene.ID <int>, Mouse.genome.database.ID <chr>

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
head(samples$Tissue.Sample.ID)
```

    ## [1] "GTEX-1117F-0126" "GTEX-1117F-0226" "GTEX-1117F-0326" "GTEX-1117F-0426"
    ## [5] "GTEX-1117F-0526" "GTEX-1117F-0626"

``` r
head(counts_long$Tissue.Sample.ID)
```

    ## [1] "GTEX_13D11_1526_SM_5J2NA.1" "GTEX_1313W_1426_SM_5KLZU.1"
    ## [3] "GTEX_131YS_0826_SM_5PNYV.1" "GTEX_13FTW_0826_SM_5K7XR.1"
    ## [5] "GTEX_ZAK1_1126_SM_5PNXU.1"  "GTEX_13O61_0426_SM_5L3ET.1"

``` r
counts_long_newname <- counts_long %>%
  separate(Tissue.Sample.ID, into = c("Tissue.Sample.ID", NULL), 
           sep =  "_SM_")
```

    ## Warning: Expected 1 pieces. Additional pieces discarded in 873630 rows [1, 2, 3,
    ## 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, ...].

``` r
head(counts_long_newname$Tissue.Sample.ID)
```

    ## [1] "GTEX_13D11_1526" "GTEX_1313W_1426" "GTEX_131YS_0826" "GTEX_13FTW_0826"
    ## [5] "GTEX_ZAK1_1126"  "GTEX_13O61_0426"

``` r
head(samples$Tissue.Sample.ID)
```

    ## [1] "GTEX-1117F-0126" "GTEX-1117F-0226" "GTEX-1117F-0326" "GTEX-1117F-0426"
    ## [5] "GTEX-1117F-0526" "GTEX-1117F-0626"

``` r
samples_new <- samples %>%
  mutate(Tissue.Sample.ID = gsub("-", "_", Tissue.Sample.ID))
head(samples$Tissue.Sample.ID)
```

    ## [1] "GTEX-1117F-0126" "GTEX-1117F-0226" "GTEX-1117F-0326" "GTEX-1117F-0426"
    ## [5] "GTEX-1117F-0526" "GTEX-1117F-0626"

``` r
counts_long_samples <- counts_long_newname %>%
  inner_join(., samples_new, by = "Tissue.Sample.ID")
head(counts_long_samples)
```

    ## # A tibble: 6 × 17
    ##   Ensembl.gene.ID  Tissue.Sample.ID counts HGNC.ID Approved.symbol Approved.name
    ##   <chr>            <chr>             <dbl> <chr>   <chr>           <chr>        
    ## 1 ENSG00000163217… GTEX_13D11_1526  8.28e6 HGNC:2… BMP10           bone morphog…
    ## 2 ENSG00000270641… GTEX_1313W_1426  7.69e6 HGNC:1… TSIX            TSIX transcr…
    ## 3 ENSG00000163217… GTEX_131YS_0826  7.25e6 HGNC:2… BMP10           bone morphog…
    ## 4 ENSG00000163217… GTEX_13FTW_0826  6.89e6 HGNC:2… BMP10           bone morphog…
    ## 5 ENSG00000270641… GTEX_ZAK1_1126   6.55e6 HGNC:1… TSIX            TSIX transcr…
    ## 6 ENSG00000163217… GTEX_13O61_0426  6.18e6 HGNC:2… BMP10           bone morphog…
    ## # … with 11 more variables: Chromosome <chr>, Accession.numbers <chr>,
    ## #   NCBI.Gene.ID <int>, Mouse.genome.database.ID <chr>, Tissue <chr>,
    ## #   Subject.ID <chr>, Sex <chr>, Age.Bracket <chr>, Hardy.Scale <chr>,
    ## #   Pathology.Categories <chr>, Pathology.Notes <chr>

Now you have a file with the counts every gene as well as the
experimental variables in 1 data frame.

### Filtering, arranging and summarizing variables

:::success

#### Key functions: Tidy and Transform

| Function         | Description                                                |
|------------------|------------------------------------------------------------|
| `str()`          | A function that prints the internal structure of an object |
| `summary()`      | A function that summarizes each variable                   |
| `pivot_wider()`  |                                                            |
| `pivot_longer()` |                                                            |
| `separate()`     |                                                            |
| `drop_na()`      |                                                            |
| `select()`       |                                                            |
| `arrange()`      |                                                            |
| `summarize()`    |                                                            |
| `arrange()`      |                                                            |
| `mutate()`       |                                                            |
| `full_join()`    |                                                            |
| `left_join()`    |                                                            |
| `inner_join()`   |                                                            |

:::

## Visualize

Now, we can use ggplot2 to show how many samples for each biological
condition.

:::success

#### The grammer of graphics

| Function               | Description |
|------------------------|-------------|
| `ggplot()`             |             |
| `aes()`                |             |
| `geom_point()`         |             |
| `geom_bar()`           |             |
| `geom_boxplot()`       |             |
| `theme()`              |             |
| `labs()`               |             |
| `scale_color_manual()` |             |
| `cowplot()`            |             |

:::

## Communicate

Communication is a 2-way street. In this section, I encourage you to
think not only about what you have to say but what others have to say as
well.

<https://gtexportal.org/home/gene/BMP10>

![](https://hackmd.io/_uploads/S1SxUwPRt.png)

### R Markdown

The workshop notes for using this repository to teach an Introduction to
R for RNA-seq are crated with the file `r4rnaseq-workshop.Rmd`.

## Functions and/or For Loops?

Not sure if I want to include either or both of these advanced beginner
concepts.

## References

-   [R for Data Science by Hadley Wickham and Garrett
    Grolemund](https://r4ds.had.co.nz/index.html)
-   [Rouillard et al. 2016. The Harmonizome: a collection of processed
    datasets gathered to serve and mine knowledge about genes and
    proteins. Database
    (Oxford).](http://database.oxfordjournals.org/content/2016/baw100.short)

## Additional Resources

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
