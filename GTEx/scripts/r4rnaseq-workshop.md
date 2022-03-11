# Introduction to R for RNA-Seq Workshop

[![hackmd-github-sync-badge](https://hackmd.io/2ArmQGwGT0uUyL5Ehqy0hQ/badge)](https://hackmd.io/2ArmQGwGT0uUyL5Ehqy0hQ)

**When:** Wednesday March 23, 10 am - 12 pm PT **Where:**
[Zoom](https://zoom.us/j/7575820324?pwd=d2UyMEhYZGNiV3kyUFpUL1EwQmthQT09)
**Instructors:** Dr. Rayna Harris **Helpers:** Jeremy Walter, Dr. Amanda
Charbonneau, and Jessica Lumian

Click
[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/nih-cfde/training-rstudio-binder/data?urlpath=rstudio)
to generate a computing enviornment for this workshop.

**Description**

This free two-hour workshop will provide an overview of the R
programming language and the user-friendly RStudio environment for
exploratory RNA-sequencing analysis. You will be introduced to R syntax,
variables, functions, packages, and data structures. You will learn the
basics of data wrangling including importing data from files,
subsetting, joining, filtering, and more. You will gain hands-on
practice calculating and visualizing differential gene expression using
popular open-source packages and public RNA-Seq data from the Gene
Expression Tissue Project (GTEx).

**Overview**

\[TOC\]

**Learning Objectives**

1.  Create a gene-level count matrix of gene expression quantification
    using recount3
2.  Perform differential expression of a two factor experiment in DESeq2
3.  Perform quality control and exploratory visualization of RNA-seq
    data in R

## Introduction and Setup

The book [“R for Data Science”](https://r4ds.had.co.nz/index.html)
provides an excellent framework for using data science to turn raw data
into understanding, insight, and knowledge. We will use this framework
as an outline for this workshop.

![](https://hackmd.io/_uploads/SkkxxSHeq.png)

**R** is a statistical computing and data visualization programming
language. **RStudio** is an integrated development environment, or IDE,
for R programming.. R and RStudio work on Mac, Linux, and Windows
operating systems. The RStudio layout displays lots of useful
information and allows us to run R code from a script and view and save
outputs all from one interface.

When you start RStudio, you’ll see two key regions in the interface: the
console and the output. For now, all you need to know is that you type R
code in the console pane, and press enter to run it. You will learn more
as we go along!

![](https://hackmd.io/_uploads/H1a8-HHx5.png)

You can run R-friendly code in the local console:

    2 + 2

and it will have an output like this:

    ## [1] 4

Functions are in a code font and followed by parentheses, like `sum()`,
or `mean()`.

The [**Tidyverse**](https://www.tidyverse.org/) R package is a
collection of functions, data, and documentation that extends the
capabilities of base R. Using packages is key to the successful use of
R. The majority of the packages that you will learn in this book are
part of the so-called tidyverse. The packages in the tidyverse share a
common philosophy of data and R programming, and are designed to work
together naturally.

You can install the complete tidyverse with a single line of code. When
install packages like this, it is a good idea to comment out so that you
don’t reinstall the package everytime you run the script. However, for
this workshop, the packages listed in the `.binder/environment.yml` file
were pre-installed with Conda.

    #install.packages("tidyverse")

After installing packages, you must load them with the fuction
`library()` to use the associated functions, objects, and help files.

    library(ggplot2)
    library(tidyr)
    library(dplyr)
    library(readr)
    library(tibble)
    library(stringr)
    library(forcats)

The mission of the [Bioconductor](https://www.bioconductor.org) project
is to develop, support, and disseminate free open source software that
facilitates rigorous and reproducible analysis of data from current and
emerging biological assays. We are dedicated to building a diverse,
collaborative, and welcoming community of developers and data
scientists.

[Bioconductor](https://www.bioconductor.org) is an open-source software
project developed for the analysis and comprehension of high-throughput
data in genomics and molecular biology. The project aims to enable
interdisciplinary research, collaboration and rapid development of
scientific software. It is based on the statistical programming language
R.

is …

    library("recount3")
    library("biomaRt")
    library("DESeq2")

In addition to using the package `ggplot` (which is part of the
`tidyverse`), we will also use `cowplot`, `scales`, and `magick` to make
pretty visualizations.

    library(cowplot)
    library(scales)
    library(magick)

#### Key functions

<table>
<thead>
<tr class="header">
<th>Function</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>install.packages()</code></td>
<td></td>
</tr>
<tr class="even">
<td><code>library()</code></td>
<td></td>
</tr>
<tr class="odd">
<td><code>BiocManager::install()</code></td>
<td></td>
</tr>
</tbody>
</table>

## Import

Data can be imported using packages from base R or from the tidyverse.
The `GTExPortal.csv` file in `../data/` contains information about all
the samples in the GTEx portal. Let’s import this file using both
`read.csv()` and `read_csv()`. Then, use `head()` to view the first few
lines of each file.

    samplesbaseR <- read.csv("../data/GTExPortal.csv")
    head(samplesbaseR)

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

    samplestidyR <- read_csv("../data/GTExPortal.csv")
    head(samplestidyR)

    ## # A tibble: 6 × 8
    ##   `Tissue Sample ID` Tissue       `Subject ID` Sex   `Age Bracket` `Hardy Scale`
    ##   <chr>              <chr>        <chr>        <chr> <chr>         <chr>        
    ## 1 GTEX-1117F-0126    Skin - Sun … GTEX-1117F   fema… 60-69         Slow death   
    ## 2 GTEX-1117F-0226    Adipose - S… GTEX-1117F   fema… 60-69         Slow death   
    ## 3 GTEX-1117F-0326    Nerve - Tib… GTEX-1117F   fema… 60-69         Slow death   
    ## 4 GTEX-1117F-0426    Muscle - Sk… GTEX-1117F   fema… 60-69         Slow death   
    ## 5 GTEX-1117F-0526    Artery - Ti… GTEX-1117F   fema… 60-69         Slow death   
    ## 6 GTEX-1117F-0626    Artery - Co… GTEX-1117F   fema… 60-69         Slow death   
    ## # … with 2 more variables: Pathology Categories <chr>, Pathology Notes <chr>

:::warning

**Challenge**

What are the some differences between the data objects imported by
`read.csv()` and `read_csv()`?

1.  Periods versus spaces in column names
2.  Data frame versus tibble
3.  Row names allowed versus not allowed

Very large tabular files are often saved as .tsv files. These can be
imported with `read.table()` or `read_tsv()`.

    results <- read.table("../data/GTEx_Heart_20-29_vs_30-39.tsv",
                          header = TRUE, sep = "\t")
    head(results)

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

    genes <- read.table("../data/genes.txt", 
                            sep = "\t", header = T, fill = T)

    ## Warning in scan(file = file, what = what, sep = sep, quote = quote, dec = dec, :
    ## EOF within quoted string

    head(genes)

    ##      HGNC.ID Approved.symbol                  Approved.name Alias.name
    ## 1     HGNC:5            A1BG         alpha-1-B glycoprotein           
    ## 2 HGNC:37133        A1BG-AS1           A1BG antisense RNA 1           
    ## 3 HGNC:24086            A1CF APOBEC1 complementation factor           
    ## 4 HGNC:24086            A1CF APOBEC1 complementation factor           
    ## 5 HGNC:24086            A1CF APOBEC1 complementation factor           
    ## 6 HGNC:24086            A1CF APOBEC1 complementation factor           
    ##   Alias.symbol Ensembl.gene.ID NCBI.gene.ID UCSC.gene.ID
    ## 1              ENSG00000121410            1   uc002qsd.5
    ## 2     FLJ23569 ENSG00000268895       503538   uc002qse.3
    ## 3          ACF ENSG00000148584        29974   uc057tgv.1
    ## 4          ASP ENSG00000148584        29974   uc057tgv.1
    ## 5        ACF64 ENSG00000148584        29974   uc057tgv.1
    ## 6        ACF65 ENSG00000148584        29974   uc057tgv.1

Very large data files, such as files with RNA-Seq counts are often
compressed before they are shared. To uncompress a file, click on the
Terminal tab and run the following command.

    gunzip -k ../data/countData.HEART.csv.gz

Once that file is uncompressed, it can be imported. Count files can be
very long and wide, so it is a good idea to only view the first (or
last) few rows and columns. Typically, a gene identifier (like an
ensemble id) will be uesed as the row names.

    counts <- read.csv("../data/countData.HEART.csv", header = TRUE, row.names = 1)
    head(counts)[1:5]

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

In order to process the counts data using the DESEq2 pipeline, we need a
corresponding file where the row names are the sample id and they match
the column names of the counts file. We confirm this by asking if
`rownames(colData) == colnames(counts)` or by checking the dimentions of
each.

    colData <- read.csv("../data/colData.HEART.csv", header = TRUE, row.names = 1)
    head(colData)[1:5]

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

    head(rownames(colData) == colnames(counts))

    ## [1] TRUE TRUE TRUE TRUE TRUE TRUE

#### Key functions

<table>
<colgroup>
<col style="width: 50%" />
<col style="width: 50%" />
</colgroup>
<thead>
<tr class="header">
<th>Function</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>read.csv()</code></td>
<td>A base R function for importing comma separated tabular data</td>
</tr>
<tr class="even">
<td><code>read_csv()</code></td>
<td>A tidyR function for importing .csv files as tibbles</td>
</tr>
<tr class="odd">
<td><code>read.table()</code></td>
<td>A base R function for importing tabular data with any delimiter</td>
</tr>
<tr class="even">
<td><code>read_tsv()</code></td>
<td>A tidyR function for importing .tsv files as tibbles</td>
</tr>
<tr class="odd">
<td><code>head()</code> and <code>tail()</code></td>
<td>Print the first or last 6 lines of an object</td>
</tr>
<tr class="even">
<td><code>dim()</code></td>
<td>Print the dimensions of an object</td>
</tr>
</tbody>
</table>

## Tidy and Transform

### Widen

Most RNA-Seq pipelines require that the counts be in a “wide” format
where each sample is a column and each gene is a row. However, many R
tools prefer data in the long format. I like to create a counts\_long
file that can be easily subset by tissue and or gene for quick plotting.

::: warning

**Challenge**

#### Key functions: Tidy

<table>
<thead>
<tr class="header">
<th>Function</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>pivot_wider()</code></td>
<td></td>
</tr>
<tr class="even">
<td><code>pivot_longer()</code></td>
<td></td>
</tr>
<tr class="odd">
<td><code>separate()</code></td>
<td></td>
</tr>
<tr class="even">
<td><code>drop_na()</code></td>
<td></td>
</tr>
</tbody>
</table>

## Transform

### Join

I prefer to search genes by their common name rather than their Ensemble
identifier, so I create a file called gene\_info and I combine this with
my countData\_long for quickly plotting count data for genes of
interest.

#### Key functions: Transform

<table>
<thead>
<tr class="header">
<th>Function</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>summarize()</code></td>
<td></td>
</tr>
<tr class="even">
<td><code>arrange()</code></td>
<td></td>
</tr>
<tr class="odd">
<td><code>mutate()</code></td>
<td></td>
</tr>
<tr class="even">
<td><code>full_join()</code></td>
<td></td>
</tr>
<tr class="odd">
<td><code>left_join()</code></td>
<td></td>
</tr>
<tr class="even">
<td><code>inner_join()</code></td>
<td></td>
</tr>
</tbody>
</table>

## Visualize

Now, we can use ggplot2 to show how many samples for each biological
condition.

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

![recount3-1](https://www.raynamharris.com/images/recount3-gtex-1.png)

    countData_long %>%
      filter( hgnc_symbol == "MT-CO2") %>%
      ggplot(aes(x = gtex.age, y = counts, 
                 fill = gtex.smtsd)) +
      geom_boxplot() +
      scale_y_log10() +
      labs(y = 'MT-CO2 counts', x = "Age", fill = "Tissue") +
      theme_linedraw(base_size = 15) +
      scale_y_continuous(labels = scales::label_number_si()) 

![recount3-2](https://www.raynamharris.com/images/recount3-gtex-2.png)

::: warning

**Challenge**

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

These results indicate that 993 genes were differentially expressed
between the 30- and 40- year old cohorts while 4256 genes were
differentially expressed between the left ventricle and atrial
appendages of the heart.

We can create MA plots to show the log fold change and mean expression
level for each gene.

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

![recount3-3](https://www.raynamharris.com/images/recount3-gtex-4.png)

Finally, we can make a box plot of one of the differently expressed
genes to confirm that the the direction is correct. Here I show that
“ENSG00000163217.1” (aka BMP10) is more highly expressed in the atrial
appendage than the left ventricle.

    countData_long %>%
      filter( ensembl_gene_id == "ENSG00000163217.1") %>%
      ggplot(aes(x = gtex.age, y = counts, 
                 fill = gtex.smtsd)) +
      geom_boxplot() +
      scale_y_log10(labels = scales::label_number_si(accuracy = 0.1)) +
      labs(y = 'Counts', x = "Age", subtitle = "ENSG00000163217.1") +
      theme_linedraw(base_size = 15) +
      theme(legend.position = "bottom", legend.direction = "vertical")

Finally, I make a box plot of one of the differently expressed genes to
confirm that the the direction is correct. Here I show that
“ENSG00000163217.1” (aka *BMP10*) is more highly expressed in the atrial
appendage than the left ventricle.

    countData_long %>%
      filter( ensembl_gene_id == "ENSG00000163217.1") %>%
      ggplot(aes(x = gtex.age, y = counts, 
                 fill = gtex.smtsd)) +
      geom_boxplot() +
      scale_y_log10(labels = scales::label_number_si(accuracy = 0.1)) +
      labs(y = 'Counts', x = "Age", subtitle = "ENSG00000163217.1") +
      theme_linedraw(base_size = 15) +
      theme(legend.position = "bottom", legend.direction = "vertical")

::: warning

**Challenge**

## Communicate

Communication is a 2-way street. In this section, I encourage you to
think not only about what you have to say but what others have to say as
well.

<https://gtexportal.org/home/gene/BMP10>

![](https://hackmd.io/_uploads/S1SxUwPRt.png)

::: warning

**Challenge**

::: spoiler

## Functions and/or For Loops?

Not sure if I want to include either or both of these advanced beginner
concepts.

**Key Points**

1.  Create a gene-level count matrix of gene expression quantification
    using recount3
2.  Perform differential expression of a two factor experiment in DESeq2
3.  Perform quality control and exploratory visualization of RNA-seq
    data in R
4.  …

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