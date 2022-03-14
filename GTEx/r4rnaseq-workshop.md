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
Expression Tissue Project (GTEx).

**When:** Wednesday March 23, 10 am - 12 pm PT  
**Where:**
[Zoom](https://zoom.us/j/7575820324?pwd=d2UyMEhYZGNiV3kyUFpUL1EwQmthQT09)  
**Instructors:** Dr. Rayna Harris  
**Helpers:** Dr. Amanda Charbonneau, Jessica Lumian, Jeremy Walter

Click
[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/nih-cfde/training-rstudio-binder/data?urlpath=rstudio)
to generate a computing environnment for this workshop.

### Overview

<div class="info">

#### Learning Objectives

In this workshop, you will learn how to use R and RStudio to import,
tidy, transform, and visualize data structures commonly associated with
RNA-sequencing experiments. Specially, you will:

-   Explore public RNA-seq data from the Gene Expression Tissue Project
-   Select variables and observations that are relevant to research
    questions
-   Rename variables and experimental factors for data joining and
    plotting
-   Visualize raw and summarized data using bar graphs, scatter plots,
    and box plots

</div>

\[TOC\]

## Introduction

The book [“R for Data Science”](https://r4ds.had.co.nz/index.html)
provides an excellent framework for using data science to turn raw data
into understanding, insight, and knowledge. We will use this framework
as an outline for this workshop.

![](https://hackmd.io/_uploads/SkkxxSHeq.png)

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

For today’s lesson, we will focus on data from the [Gene Expression
Tissue (GTEx) Project](https://commonfund.nih.gov/gtex). The GTEx is an
ongoing effort to build a comprehensive public resource to study
tissue-specific gene expression and regulation. Samples were collected
from 54 non-diseased tissue sites across nearly 1000 individuals,
primarily for molecular assays including WGS, WES, and RNA-Seq.

By the end of today’s workshop, you create tables and plots like the
ones below. These plots give a nice overview of the samples collected
and the variables that can be used for differential gene expression
analysis.

![](./images/GTExPortal-2.png)

![](./images/GTExPortal-5.png) ![](./images/GTExPortal-3.png)

![](./images/DEGs-1.png)

![](./images/DEGs-1.png)

![](./images/DEGs-5.png)

### Getting Started

1.  Click the
    [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/nih-cfde/training-rstudio-binder/data?urlpath=rstudio)
    button to generate a computing environment for this workshop.
2.  Navigate to the GTEX folder.
3.  Click `GTEx.Rproj` to open up an Rproject which will set the working
    directory to `~/GTEx/`.
4.  Open the **r4rnaseq-workshop.R** file which contains all the
    commands for today’s workshop.

### Tidyverse packages

The [**Tidyverse**](https://www.tidyverse.org/) R package is a
collection of functions, data, and documentation that extends the
capabilities of base R. Using packages is key to the successful use of
R. The majority of the packages that you will learn in this book are
part of the so-called tidyverse. The packages in the tidyverse share a
common philosophy of data and R programming, and are designed to work
together naturally.

You can install the complete tidyverse with a single line of code. When
install packages like this, it is a good idea to comment out so that you
don’t reinstall the package everytime you run the script.

``` r
#install.packages("tidyverse")
```

However, for this workshop, the packages listed in the
`.binder/environment.yml` file were pre-installed with Conda. For some
reason, the tidyverse package doesn’t always install properly, so we
installed each package individually.

After installing packages, you must load them with the function
`library()` to use the associated functions, objects, and help files. In
addition to using the package `ggplot`, we will also use `cowplot` and
`scales` to make pretty visualizations.

``` r
library(ggplot2)
library(tidyr)
library(dplyr)
library(readr)
library(tibble)
library(stringr)
library(forcats)
library(cowplot)
library(scales)
library(kableExtra)
```

### Bionconductor packages

[Bioconductor](https://www.bioconductor.org) is an open-source software
project developed for the analysis and comprehension of high-throughput
data in genomics and molecular biology. The project aims to enable
interdisciplinary research, collaboration and rapid development of
scientific software. It is based on the statistical programming language
R. We will not be using these packages in this class, but they are worth
getting to know.

``` r
library(recount3)
library(biomaRt)
library(DESeq2)
```

<div class="success">

#### Key functions

| Function             | Description |
|----------------------|-------------|
| `install.packages()` |             |
| `library()`          |             |

</div>

## Import

Data can be imported using packages from base R or from the tidyverse.

What are the some differences between the data objects imported by
`read.csv()` and `read_csv()`? 1. Periods versus spaces in column names
1. Data frame versus tibble 1. Row names allowed versus not allowed.

The `GTExPortal.csv` file in `./data/` contains information about all
the samples in the GTEx portal. Let’s import this file using
`read.csv()`. Then, use `head()` to view the first few lines of each
file.

``` r
samplesbaseR <- read.csv("./data/GTExPortal.csv")
kable(head(samplesbaseR))
```

<table>
<thead>
<tr>
<th style="text-align:left;">
Tissue.Sample.ID
</th>
<th style="text-align:left;">
Tissue
</th>
<th style="text-align:left;">
Subject.ID
</th>
<th style="text-align:left;">
Sex
</th>
<th style="text-align:left;">
Age.Bracket
</th>
<th style="text-align:left;">
Hardy.Scale
</th>
<th style="text-align:left;">
Pathology.Categories
</th>
<th style="text-align:left;">
Pathology.Notes
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
GTEX-1117F-0126
</td>
<td style="text-align:left;">
Skin - Sun Exposed (Lower leg)
</td>
<td style="text-align:left;">
GTEX-1117F
</td>
<td style="text-align:left;">
female
</td>
<td style="text-align:left;">
60-69
</td>
<td style="text-align:left;">
Slow death
</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">
6 pieces, minimal fat, squamous epithelium is \~50-70 microns
</td>
</tr>
<tr>
<td style="text-align:left;">
GTEX-1117F-0226
</td>
<td style="text-align:left;">
Adipose - Subcutaneous
</td>
<td style="text-align:left;">
GTEX-1117F
</td>
<td style="text-align:left;">
female
</td>
<td style="text-align:left;">
60-69
</td>
<td style="text-align:left;">
Slow death
</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">
2 pieces, \~15% vessel stroma, rep delineated
</td>
</tr>
<tr>
<td style="text-align:left;">
GTEX-1117F-0326
</td>
<td style="text-align:left;">
Nerve - Tibial
</td>
<td style="text-align:left;">
GTEX-1117F
</td>
<td style="text-align:left;">
female
</td>
<td style="text-align:left;">
60-69
</td>
<td style="text-align:left;">
Slow death
</td>
<td style="text-align:left;">
clean_specimens
</td>
<td style="text-align:left;">
2 pieces, clean specimens
</td>
</tr>
<tr>
<td style="text-align:left;">
GTEX-1117F-0426
</td>
<td style="text-align:left;">
Muscle - Skeletal
</td>
<td style="text-align:left;">
GTEX-1117F
</td>
<td style="text-align:left;">
female
</td>
<td style="text-align:left;">
60-69
</td>
<td style="text-align:left;">
Slow death
</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">
2 pieces, !5% fibrous connective tissue, delineated (rep)
</td>
</tr>
<tr>
<td style="text-align:left;">
GTEX-1117F-0526
</td>
<td style="text-align:left;">
Artery - Tibial
</td>
<td style="text-align:left;">
GTEX-1117F
</td>
<td style="text-align:left;">
female
</td>
<td style="text-align:left;">
60-69
</td>
<td style="text-align:left;">
Slow death
</td>
<td style="text-align:left;">
monckeberg, sclerotic
</td>
<td style="text-align:left;">
2 pieces, clean, Monckebeg medial sclerosis, rep delineated
</td>
</tr>
<tr>
<td style="text-align:left;">
GTEX-1117F-0626
</td>
<td style="text-align:left;">
Artery - Coronary
</td>
<td style="text-align:left;">
GTEX-1117F
</td>
<td style="text-align:left;">
female
</td>
<td style="text-align:left;">
60-69
</td>
<td style="text-align:left;">
Slow death
</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">
2 pieces, up to 4mm aderent fat/nerve/vessel, delineated
</td>
</tr>
</tbody>
</table>

Very large tabular files are often saved as .tsv files. These can be
imported with `read.table()` or `read_tsv()`.

``` r
results <- read.table("./data/GTEx_Heart_20-29_vs_30-39.tsv", header = TRUE, sep = "\t")
kable(head(results))
```

<table>
<thead>
<tr>
<th style="text-align:left;">
X
</th>
<th style="text-align:right;">
logFC
</th>
<th style="text-align:right;">
AveExpr
</th>
<th style="text-align:right;">
t
</th>
<th style="text-align:right;">
P.Value
</th>
<th style="text-align:right;">
adj.P.Val
</th>
<th style="text-align:right;">
B
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
A1BG
</td>
<td style="text-align:right;">
0.1033279
</td>
<td style="text-align:right;">
1.3459363
</td>
<td style="text-align:right;">
0.3221575
</td>
<td style="text-align:right;">
0.7482218
</td>
<td style="text-align:right;">
0.8748032
</td>
<td style="text-align:right;">
-5.672644
</td>
</tr>
<tr>
<td style="text-align:left;">
A1BG-AS1
</td>
<td style="text-align:right;">
0.1360923
</td>
<td style="text-align:right;">
-0.2381928
</td>
<td style="text-align:right;">
0.6395041
</td>
<td style="text-align:right;">
0.5244265
</td>
<td style="text-align:right;">
0.7307806
</td>
<td style="text-align:right;">
-5.345563
</td>
</tr>
<tr>
<td style="text-align:left;">
A2M
</td>
<td style="text-align:right;">
-0.0160518
</td>
<td style="text-align:right;">
9.7981987
</td>
<td style="text-align:right;">
-0.1132389
</td>
<td style="text-align:right;">
0.9101410
</td>
<td style="text-align:right;">
0.9564580
</td>
<td style="text-align:right;">
-5.956689
</td>
</tr>
<tr>
<td style="text-align:left;">
A2M-AS1
</td>
<td style="text-align:right;">
0.6050557
</td>
<td style="text-align:right;">
2.5392220
</td>
<td style="text-align:right;">
3.4884410
</td>
<td style="text-align:right;">
0.0008132
</td>
<td style="text-align:right;">
0.0554565
</td>
<td style="text-align:right;">
-0.635100
</td>
</tr>
<tr>
<td style="text-align:left;">
A2ML1
</td>
<td style="text-align:right;">
0.3541353
</td>
<td style="text-align:right;">
-1.1667406
</td>
<td style="text-align:right;">
1.0788316
</td>
<td style="text-align:right;">
0.2840899
</td>
<td style="text-align:right;">
0.5292264
</td>
<td style="text-align:right;">
-4.948617
</td>
</tr>
<tr>
<td style="text-align:left;">
A2MP1
</td>
<td style="text-align:right;">
0.6576474
</td>
<td style="text-align:right;">
-0.7564399
</td>
<td style="text-align:right;">
3.2615528
</td>
<td style="text-align:right;">
0.0016631
</td>
<td style="text-align:right;">
0.0606700
</td>
<td style="text-align:right;">
-1.358971
</td>
</tr>
</tbody>
</table>

I find it helpful to import a table of gene names and symbols that can
be merged with other tables with gene information or searched for useful
information. This table of gene names was downloaded from
<https://www.genenames.org/download/custom/>.

In this case, we use `fill = T` to fill missing fields wiht a NULL
value.

``` r
genes <- read.table("./data/genes.txt", sep = "\t", 
                    header = T, fill = T)
kable(head(genes))
```

<table>
<thead>
<tr>
<th style="text-align:left;">
HGNC.ID
</th>
<th style="text-align:left;">
Approved.symbol
</th>
<th style="text-align:left;">
Approved.name
</th>
<th style="text-align:left;">
Chromosome
</th>
<th style="text-align:left;">
Accession.numbers
</th>
<th style="text-align:right;">
NCBI.Gene.ID
</th>
<th style="text-align:left;">
Ensembl.gene.ID
</th>
<th style="text-align:left;">
Mouse.genome.database.ID
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
HGNC:5
</td>
<td style="text-align:left;">
A1BG
</td>
<td style="text-align:left;">
alpha-1-B glycoprotein
</td>
<td style="text-align:left;">
19q13.43
</td>
<td style="text-align:left;">
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:left;">
ENSG00000121410
</td>
<td style="text-align:left;">
MGI:2152878
</td>
</tr>
<tr>
<td style="text-align:left;">
HGNC:37133
</td>
<td style="text-align:left;">
A1BG-AS1
</td>
<td style="text-align:left;">
A1BG antisense RNA 1
</td>
<td style="text-align:left;">
19q13.43
</td>
<td style="text-align:left;">
BC040926
</td>
<td style="text-align:right;">
503538
</td>
<td style="text-align:left;">
ENSG00000268895
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
HGNC:24086
</td>
<td style="text-align:left;">
A1CF
</td>
<td style="text-align:left;">
APOBEC1 complementation factor
</td>
<td style="text-align:left;">
10q11.23
</td>
<td style="text-align:left;">
AF271790
</td>
<td style="text-align:right;">
29974
</td>
<td style="text-align:left;">
ENSG00000148584
</td>
<td style="text-align:left;">
MGI:1917115
</td>
</tr>
<tr>
<td style="text-align:left;">
HGNC:6
</td>
<td style="text-align:left;">
A1S9T
</td>
<td style="text-align:left;">
symbol withdrawn, see \[HGNC:12469\](/data/gene-symbol-report/
</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:left;">
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
HGNC:7
</td>
<td style="text-align:left;">
A2M
</td>
<td style="text-align:left;">
alpha-2-macroglobulin
</td>
<td style="text-align:left;">
12p13.31
</td>
<td style="text-align:left;">
BX647329, X68728, M11313
</td>
<td style="text-align:right;">
2
</td>
<td style="text-align:left;">
ENSG00000175899
</td>
<td style="text-align:left;">
MGI:2449119
</td>
</tr>
<tr>
<td style="text-align:left;">
HGNC:27057
</td>
<td style="text-align:left;">
A2M-AS1
</td>
<td style="text-align:left;">
A2M antisense RNA 1
</td>
<td style="text-align:left;">
12p13.31
</td>
<td style="text-align:left;">
</td>
<td style="text-align:right;">
144571
</td>
<td style="text-align:left;">
ENSG00000245105
</td>
<td style="text-align:left;">
</td>
</tr>
</tbody>
</table>

Very large data files, such as files with RNA-Seq counts are often
compressed before they are shared. To uncompress a file, click on the
Terminal tab and run the following command.

``` bash
gunzip -k ./data/countData.HEART.csv.gz
```

Once that file is uncompressed, it can be imported. Count files can be
very long and wide, so it is a good idea to only view the first (or
last) few rows and columns. Typically, a gene identifier (like an
ensemble id) will be uesed as the row names.

``` r
counts <- read.csv("./data/countData.HEART.csv", header = TRUE, row.names = 1)
kable(head(counts)[1:5])
```

<table>
<thead>
<tr>
<th style="text-align:left;">
</th>
<th style="text-align:right;">
GTEX_12ZZX_0726_SM_5EGKA.1
</th>
<th style="text-align:right;">
GTEX_13D11_1526_SM_5J2NA.1
</th>
<th style="text-align:right;">
GTEX_ZAJG_0826_SM_5PNVA.1
</th>
<th style="text-align:right;">
GTEX_11TT1_1426_SM_5EGIA.1
</th>
<th style="text-align:right;">
GTEX_13VXT_1126_SM_5LU3A.1
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
ENSG00000278704.1
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
0
</td>
</tr>
<tr>
<td style="text-align:left;">
ENSG00000277400.1
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
0
</td>
</tr>
<tr>
<td style="text-align:left;">
ENSG00000274847.1
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
0
</td>
</tr>
<tr>
<td style="text-align:left;">
ENSG00000277428.1
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
0
</td>
</tr>
<tr>
<td style="text-align:left;">
ENSG00000276256.1
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
0
</td>
</tr>
<tr>
<td style="text-align:left;">
ENSG00000278198.1
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
0
</td>
</tr>
</tbody>
</table>

In order to process the counts data using the DESEq2 pipeline, we need a
corresponding file where the row names are the sample id and they match
the column names of the counts file. We confirm this by asking if
`rownames(colData) == colnames(counts)` or by checking the dimentions of
each.

``` r
colData <- read.csv("./data/colData.HEART.csv", header = TRUE, row.names = 1)
kable(head(colData)[1:5])
```

<table>
<thead>
<tr>
<th style="text-align:left;">
</th>
<th style="text-align:left;">
external_id
</th>
<th style="text-align:left;">
study
</th>
<th style="text-align:left;">
gtex.subjid
</th>
<th style="text-align:left;">
gtex.run_acc
</th>
<th style="text-align:right;">
gtex.sex
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
GTEX_12ZZX_0726_SM_5EGKA.1
</td>
<td style="text-align:left;">
GTEX-12ZZX-0726-SM-5EGKA.1
</td>
<td style="text-align:left;">
HEART
</td>
<td style="text-align:left;">
GTEX-12ZZX
</td>
<td style="text-align:left;">
SRR1340617
</td>
<td style="text-align:right;">
2
</td>
</tr>
<tr>
<td style="text-align:left;">
GTEX_13D11_1526_SM_5J2NA.1
</td>
<td style="text-align:left;">
GTEX-13D11-1526-SM-5J2NA.1
</td>
<td style="text-align:left;">
HEART
</td>
<td style="text-align:left;">
GTEX-13D11
</td>
<td style="text-align:left;">
SRR1345436
</td>
<td style="text-align:right;">
2
</td>
</tr>
<tr>
<td style="text-align:left;">
GTEX_ZAJG_0826_SM_5PNVA.1
</td>
<td style="text-align:left;">
GTEX-ZAJG-0826-SM-5PNVA.1
</td>
<td style="text-align:left;">
HEART
</td>
<td style="text-align:left;">
GTEX-ZAJG
</td>
<td style="text-align:left;">
SRR1367456
</td>
<td style="text-align:right;">
2
</td>
</tr>
<tr>
<td style="text-align:left;">
GTEX_11TT1_1426_SM_5EGIA.1
</td>
<td style="text-align:left;">
GTEX-11TT1-1426-SM-5EGIA.1
</td>
<td style="text-align:left;">
HEART
</td>
<td style="text-align:left;">
GTEX-11TT1
</td>
<td style="text-align:left;">
SRR1378243
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
GTEX_13VXT_1126_SM_5LU3A.1
</td>
<td style="text-align:left;">
GTEX-13VXT-1126-SM-5LU3A.1
</td>
<td style="text-align:left;">
HEART
</td>
<td style="text-align:left;">
GTEX-13VXT
</td>
<td style="text-align:left;">
SRR1381693
</td>
<td style="text-align:right;">
2
</td>
</tr>
<tr>
<td style="text-align:left;">
GTEX_14ASI_0826_SM_5Q5EB.1
</td>
<td style="text-align:left;">
GTEX-14ASI-0826-SM-5Q5EB.1
</td>
<td style="text-align:left;">
HEART
</td>
<td style="text-align:left;">
GTEX-14ASI
</td>
<td style="text-align:left;">
SRR1335164
</td>
<td style="text-align:right;">
1
</td>
</tr>
</tbody>
</table>

``` r
kable(head(rownames(colData) == colnames(counts)))
```

<table>
<thead>
<tr>
<th style="text-align:left;">
x
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
TRUE
</td>
</tr>
<tr>
<td style="text-align:left;">
TRUE
</td>
</tr>
<tr>
<td style="text-align:left;">
TRUE
</td>
</tr>
<tr>
<td style="text-align:left;">
TRUE
</td>
</tr>
<tr>
<td style="text-align:left;">
TRUE
</td>
</tr>
<tr>
<td style="text-align:left;">
TRUE
</td>
</tr>
</tbody>
</table>

<div class="success">

#### Key functions

| Function              | Description                                                     |
|-----------------------|-----------------------------------------------------------------|
| `read.csv()`          | A base R function for importing comma separated tabular data    |
| `read_csv()`          | A tidyR function for importing .csv files as tibbles            |
| `read.table()`        | A base R function for importing tabular data with any delimiter |
| `read_tsv()`          | A tidyR function for importing .tsv files as tibbles            |
| `head()` and `tail()` | Print the first or last 6 lines of an object                    |
| `dim()`               | Print the dimensions of an object                               |

</div>

## Tidy and Transform

### Widen

Most RNA-Seq pipelines require that the counts be in a “wide” format
where each sample is a column and each gene is a row. However, many R
tools prefer data in the long format. I like to create a counts_long
file that can be easily subset by tissue and or gene for quick plotting.

<div class="success">

#### Key functions: Tidy

| Function         | Description |
|------------------|-------------|
| `pivot_wider()`  |             |
| `pivot_longer()` |             |
| `separate()`     |             |
| `drop_na()`      |             |
| `select()`       |             |
| `arrange()`      |             |

</div>

## Transform

### Mutate

### Renameing variables

In the next section, we will join two data frames by a shared column.
Both the results file and the genes file have a column with gene
symbols, but they do not have the same name.

We can use the `rename` function to rename columns. The first value is
the new name and the second value is the old name. Just in case we get
it wrote, let’s save this as a new

``` r
head(results)
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
head(results$X)
```

    ## [1] "A1BG"     "A1BG-AS1" "A2M"      "A2M-AS1"  "A2ML1"    "A2MP1"

``` r
head(genes$Approved.symbol)
```

    ## [1] "A1BG"     "A1BG-AS1" "A1CF"     "A1S9T"    "A2M"      "A2M-AS1"

``` r
results_new <- results %>%
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

### Join

Now that the results and the genes objects both have a column called
`Approved.symbol` they can be joined. The command `full_join()` will
keep all rows of both objects. `left_join` will keep all the rows in the
first object but will drop any rows in the second object that don’t map
onto the first.

``` r
results_genes <- left_join(results_new, genes, by = "Approved.symbol")
kable(head(results_genes))
```

<table>
<thead>
<tr>
<th style="text-align:left;">
Approved.symbol
</th>
<th style="text-align:right;">
logFC
</th>
<th style="text-align:right;">
AveExpr
</th>
<th style="text-align:right;">
t
</th>
<th style="text-align:right;">
P.Value
</th>
<th style="text-align:right;">
adj.P.Val
</th>
<th style="text-align:right;">
B
</th>
<th style="text-align:left;">
HGNC.ID
</th>
<th style="text-align:left;">
Approved.name
</th>
<th style="text-align:left;">
Chromosome
</th>
<th style="text-align:left;">
Accession.numbers
</th>
<th style="text-align:right;">
NCBI.Gene.ID
</th>
<th style="text-align:left;">
Ensembl.gene.ID
</th>
<th style="text-align:left;">
Mouse.genome.database.ID
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
A1BG
</td>
<td style="text-align:right;">
0.1033279
</td>
<td style="text-align:right;">
1.3459363
</td>
<td style="text-align:right;">
0.3221575
</td>
<td style="text-align:right;">
0.7482218
</td>
<td style="text-align:right;">
0.8748032
</td>
<td style="text-align:right;">
-5.672644
</td>
<td style="text-align:left;">
HGNC:5
</td>
<td style="text-align:left;">
alpha-1-B glycoprotein
</td>
<td style="text-align:left;">
19q13.43
</td>
<td style="text-align:left;">
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:left;">
ENSG00000121410
</td>
<td style="text-align:left;">
MGI:2152878
</td>
</tr>
<tr>
<td style="text-align:left;">
A1BG-AS1
</td>
<td style="text-align:right;">
0.1360923
</td>
<td style="text-align:right;">
-0.2381928
</td>
<td style="text-align:right;">
0.6395041
</td>
<td style="text-align:right;">
0.5244265
</td>
<td style="text-align:right;">
0.7307806
</td>
<td style="text-align:right;">
-5.345563
</td>
<td style="text-align:left;">
HGNC:37133
</td>
<td style="text-align:left;">
A1BG antisense RNA 1
</td>
<td style="text-align:left;">
19q13.43
</td>
<td style="text-align:left;">
BC040926
</td>
<td style="text-align:right;">
503538
</td>
<td style="text-align:left;">
ENSG00000268895
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
A2M
</td>
<td style="text-align:right;">
-0.0160518
</td>
<td style="text-align:right;">
9.7981987
</td>
<td style="text-align:right;">
-0.1132389
</td>
<td style="text-align:right;">
0.9101410
</td>
<td style="text-align:right;">
0.9564580
</td>
<td style="text-align:right;">
-5.956689
</td>
<td style="text-align:left;">
HGNC:7
</td>
<td style="text-align:left;">
alpha-2-macroglobulin
</td>
<td style="text-align:left;">
12p13.31
</td>
<td style="text-align:left;">
BX647329, X68728, M11313
</td>
<td style="text-align:right;">
2
</td>
<td style="text-align:left;">
ENSG00000175899
</td>
<td style="text-align:left;">
MGI:2449119
</td>
</tr>
<tr>
<td style="text-align:left;">
A2M-AS1
</td>
<td style="text-align:right;">
0.6050557
</td>
<td style="text-align:right;">
2.5392220
</td>
<td style="text-align:right;">
3.4884410
</td>
<td style="text-align:right;">
0.0008132
</td>
<td style="text-align:right;">
0.0554565
</td>
<td style="text-align:right;">
-0.635100
</td>
<td style="text-align:left;">
HGNC:27057
</td>
<td style="text-align:left;">
A2M antisense RNA 1
</td>
<td style="text-align:left;">
12p13.31
</td>
<td style="text-align:left;">
</td>
<td style="text-align:right;">
144571
</td>
<td style="text-align:left;">
ENSG00000245105
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
A2ML1
</td>
<td style="text-align:right;">
0.3541353
</td>
<td style="text-align:right;">
-1.1667406
</td>
<td style="text-align:right;">
1.0788316
</td>
<td style="text-align:right;">
0.2840899
</td>
<td style="text-align:right;">
0.5292264
</td>
<td style="text-align:right;">
-4.948617
</td>
<td style="text-align:left;">
HGNC:23336
</td>
<td style="text-align:left;">
alpha-2-macroglobulin like 1
</td>
<td style="text-align:left;">
12p13.31
</td>
<td style="text-align:left;">
AK057908
</td>
<td style="text-align:right;">
144568
</td>
<td style="text-align:left;">
ENSG00000166535
</td>
<td style="text-align:left;">
</td>
</tr>
<tr>
<td style="text-align:left;">
A2MP1
</td>
<td style="text-align:right;">
0.6576474
</td>
<td style="text-align:right;">
-0.7564399
</td>
<td style="text-align:right;">
3.2615528
</td>
<td style="text-align:right;">
0.0016631
</td>
<td style="text-align:right;">
0.0606700
</td>
<td style="text-align:right;">
-1.358971
</td>
<td style="text-align:left;">
HGNC:8
</td>
<td style="text-align:left;">
alpha-2-macroglobulin pseudogene 1
</td>
<td style="text-align:left;">
12p13.31
</td>
<td style="text-align:left;">
M24415
</td>
<td style="text-align:right;">
3
</td>
<td style="text-align:left;">
ENSG00000256069
</td>
<td style="text-align:left;">
</td>
</tr>
</tbody>
</table>

#### Key functions: Transform

| Function       | Description |
|----------------|-------------|
| `summarize()`  |             |
| `arrange()`    |             |
| `mutate()`     |             |
| `full_join()`  |             |
| `left_join()`  |             |
| `inner_join()` |             |

## Visualize

Now, we can use ggplot2 to show how many samples for each biological
condition.

``` r
colData %>%
      group_by(gtex.age, gtex.smtsd) %>%
      summarise(cohort_size = length(gtex.age)) %>%
      ggplot(aes(x = gtex.age,  y = cohort_size, fill = gtex.smtsd)) +
      geom_bar(stat = "identity", position = "dodge") +
      labs(x = "Age", y = "Cohort size", fill = "Tissue",
           subtitle = "GTEx data obtained using recount3 ") +
      theme_linedraw(base_size = 15) +
      geom_text(aes(label = cohort_size),
                position = position_dodge(width = .9),
                vjust = -0.25)
```

![recount3-1](https://www.raynamharris.com/images/recount3-gtex-1.png)

``` r
countData_long %>%
  filter( hgnc_symbol == "MT-CO2") %>%
  ggplot(aes(x = gtex.age, y = counts, 
             fill = gtex.smtsd)) +
  geom_boxplot() +
  scale_y_log10() +
  labs(y = 'MT-CO2 counts', x = "Age", fill = "Tissue") +
  theme_linedraw(base_size = 15) +
  scale_y_continuous(labels = scales::label_number_si()) 
```

![recount3-2](https://www.raynamharris.com/images/recount3-gtex-2.png)

## Model

Differential expression analysis with DESeq2 involves multiple steps as
displayed in the flowchart below. Briefly,

-   DESeq2 will model the raw counts, using normalization factors (size
    factors) to account for differences in library depth.
-   Then, it will estimate the gene-wise dispersions and shrink these
    estimates to generate more accurate estimates of dispersion to model
    the counts.
-   Finally, DESeq2 will fit the negative binomial model and perform
    hypothesis testing using the Wald test or Likelihood Ratio Test.

![DESeq](https://angus.readthedocs.io/en/2019/_static/DESeq2_workflow.png)

DESEq2 does not like to have dashes in variable names, so I use `gsub()`
to replace `-` with `_`. Also, DESeq2 performs best with 100 samples or
less. I like to use it on experiments with a 2 x 2 design
(e.g. `~ treatments * condition`). So, I do some data wrangling to just
focus on two age groups.

``` r
# replace dashes with underscores for deseq
colData$gtex.age <- gsub(x = colData$gtex.age , pattern = "\\-", replacement = "_")
colData$gtex.smtsd <-  gsub(x = colData$gtex.smtsd , pattern = "\\-", replacement = "")
colData$gtex.smtsd <-  gsub(x = colData$gtex.smtsd , pattern = " ", replacement = "")

# check that rows and samples match
head(rownames(colData) == colnames(countData))

## [1] TRUE TRUE TRUE TRUE TRUE TRUE

# subset to 100 for deseq

colDataSlim <- colData %>% filter(gtex.age  %in% c("30_39","40_49")) 
savecols <- as.character(rownames(colDataSlim)) #select the rowsname 
savecols <- as.vector(savecols) # make it a vector
countDataSlim <- countData %>% dplyr::select(one_of(savecols)) 

# check that rows and samples match
head(rownames(colDataSlim) == colnames(countDataSlim))

## [1] TRUE TRUE TRUE TRUE TRUE TRUE
```

Now we can use DESeq2 to ask whether or not more genes are
differentially expressed based on age or tissue.

A design formula tells the statistical software the known sources of
variation to control for, as well as, the factor of interest to test for
during differential expression testing. Here our experimental design has
one factor with two levels.

DESeq stores virtually all information associated with your experiment
in one specific R object, called DESeqDataSet. This is, in fact, a
specialized object of the class “SummarizedExperiment”. This, in turn,is
a container where rows (rowRanges()) represent features of interest
(e.g. genes, transcripts, exons) and columns represent samples
(colData()). The actual count data is stored in theassay()slot.

``` r
dds <- DESeqDataSetFromMatrix(countData = countDataSlim,
                              colData = colDataSlim,
                              design = ~ gtex.age * gtex.smtsd)

dds <- dds[ rowSums(counts(dds)) > 1, ]  # Pre-filtering genes with 0 counts
dds <- DESeq(dds, parallel = TRUE)
vsd <- vst(dds, blind=FALSE)

res1 <- results(dds, name="gtex.age_40_49_vs_30_39",  independentFiltering = T)
sum(res1$padj < 0.05, na.rm=TRUE)
## [1] 993

res2 <- results(dds, name="gtex.smtsd_HeartLeftVentricle_vs_HeartAtrialAppendage", independentFiltering = T)
sum(res2$padj < 0.05, na.rm=TRUE)
## [1] 4256
```

These results indicate that 993 genes were differentially expressed
between the 30- and 40- year old cohorts while 4256 genes were
differentially expressed between the left ventricle and atrial
appendages of the heart.

We can create MA plots to show the log fold change and mean expression
level for each gene.

``` r
a <- ggmaplot(res1, main = expression("Age: 30-39" %->% "40-49"),
         fdr = 0.05, fc = 2, size = 0.4,
         palette = c("#B31B21", "#1465AC", "darkgray"),
         legend = "bottom", top = 1,
         ggtheme = ggplot2::theme_linedraw(base_size = 15))


b <- ggmaplot(res2, main = expression("Heart: Atrial Appendage" %->% "Left Ventricle"),
         fdr = 0.05, fc = 2, size = 0.4,
         palette = c("#B31B21", "#1465AC", "darkgray"),
         legend = "bottom", top = 1,
         ggtheme = ggplot2::theme_linedraw(base_size = 15))
         

p2 <- plot_grid(a,b, nrow = 1)
p2
```

![recount3-3](https://www.raynamharris.com/images/recount3-gtex-4.png)

Finally, we can make a box plot of one of the differently expressed
genes to confirm that the the direction is correct. Here I show that
“ENSG00000163217.1” (aka BMP10) is more highly expressed in the atrial
appendage than the left ventricle.

``` r
countData_long %>%
  filter( ensembl_gene_id == "ENSG00000163217.1") %>%
  ggplot(aes(x = gtex.age, y = counts, 
             fill = gtex.smtsd)) +
  geom_boxplot() +
  scale_y_log10(labels = scales::label_number_si(accuracy = 0.1)) +
  labs(y = 'Counts', x = "Age", subtitle = "ENSG00000163217.1") +
  theme_linedraw(base_size = 15) +
  theme(legend.position = "bottom", legend.direction = "vertical")
```

Finally, I make a box plot of one of the differently expressed genes to
confirm that the the direction is correct. Here I show that
“ENSG00000163217.1” (aka *BMP10*) is more highly expressed in the atrial
appendage than the left ventricle.

``` r
countData_long %>%
  filter( ensembl_gene_id == "ENSG00000163217.1") %>%
  ggplot(aes(x = gtex.age, y = counts, 
             fill = gtex.smtsd)) +
  geom_boxplot() +
  scale_y_log10(labels = scales::label_number_si(accuracy = 0.1)) +
  labs(y = 'Counts', x = "Age", subtitle = "ENSG00000163217.1") +
  theme_linedraw(base_size = 15) +
  theme(legend.position = "bottom", legend.direction = "vertical")
```

## Communicate

Communication is a 2-way street. In this section, I encourage you to
think not only about what you have to say but what others have to say as
well.

<https://gtexportal.org/home/gene/BMP10>

![](https://hackmd.io/_uploads/S1SxUwPRt.png)

## Functions and/or For Loops?

Not sure if I want to include either or both of these advanced beginner
concepts.

#### Key Points

1.  Create a gene-level count matrix of gene expression quantification
    using recount3
2.  Perform differential expression of a two factor experiment in DESeq2
3.  Perform quality control and exploratory visualization of RNA-seq
    data in R

## References

-   [R for Data Science by Hadley Wickham and Garrett
    Grolemund](https://r4ds.had.co.nz/index.html)
-   [Rouillard et al. 2016. The harmonizome: a collection of processed
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

## *Note: the source document `r4rnaseq-workshop.Rmd` was last modified 14 March, 2022.*

``` r
knitr::opts_chunk$set(echo = TRUE, message = FALSE, cache = TRUE,
                      fig.path = "./images/")

:::info
#### Learning Objectives 

In this workshop, you will learn how to use R and RStudio to import, tidy, transform, and visualize data structures commonly associated with RNA-sequencing experiments. Specially, you will: 

* Explore public RNA-seq data from the Gene Expression Tissue Project
* Select variables and observations that are relevant to research questions 
* Rename variables and experimental factors for data joining and plotting
* Visualize raw and summarized data using bar graphs, scatter plots, and box plots 

:::

#install.packages("tidyverse")
library(ggplot2)
library(tidyr)
library(dplyr)
library(readr)
library(tibble)
library(stringr)
library(forcats)
library(cowplot)
library(scales)
library(kableExtra)
library(recount3)
library(biomaRt)
library(DESeq2)

:::success
#### Key functions

| Function | Description |
| --- | --- |
| `install.packages()` |  |
| `library()` |  |
:::

samplesbaseR <- read.csv("./data/GTExPortal.csv")
kable(head(samplesbaseR))
results <- read.table("./data/GTEx_Heart_20-29_vs_30-39.tsv", header = TRUE, sep = "\t")
kable(head(results))
genes <- read.table("./data/genes.txt", sep = "\t", 
                    header = T, fill = T)
kable(head(genes))
rm ./data/countData.HEART.csv
gunzip -k ./data/countData.HEART.csv.gz
counts <- read.csv("./data/countData.HEART.csv", header = TRUE, row.names = 1)
kable(head(counts)[1:5])
colData <- read.csv("./data/colData.HEART.csv", header = TRUE, row.names = 1)
kable(head(colData)[1:5])
kable(head(rownames(colData) == colnames(counts)))

:::success
#### Key functions

| Function | Description |
| --- | --- |
| `read.csv()`  | A base R function for importing comma separated tabular data  |
| `read_csv()`  | A tidyR function for importing .csv files as tibbles |
| `read.table()` | A base R function for importing tabular data with any delimiter |
| `read_tsv()`  | A tidyR function for importing .tsv files as tibbles | 
| `head()` and `tail()` |Print the first or last 6 lines of an object  | 
| `dim()`  | Print the dimensions of an object | 
:::


:::success
#### Key functions: Tidy

| Function | Description |
| --- | --- |
| `pivot_wider()` |  |
| `pivot_longer()` |  |
| `separate()` |  |
| `drop_na()` |  |
| `select()`|  |
| `arrange()` |  |
:::

head(results)
head(genes)

head(results$X)
head(genes$Approved.symbol)

results_new <- results %>%
  dplyr::rename("Approved.symbol" = "X")
head(results_new)
results_genes <- left_join(results_new, genes, by = "Approved.symbol")
kable(head(results_genes))
```
