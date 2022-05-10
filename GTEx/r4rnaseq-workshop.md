
# Introduction to R for RNA Sequencing Analysis with data from the Gene Expression Tissue Project (GTEx)

**When:** Wednesday, May 11, 2022, 19 am - 12 pm PDT [workd
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
this 3 hour workshop, we will use R to explore publicly-available
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

This event is part of the [CFDE May
Hackathon](https://nih-cfde.github.io/2022-may-hackathon/). Join us
tomorrow at the Social Co-Working Sessions to practice and ask
questions.

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
log10(0.05)
```

    ## [1] -1.30103

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
#View(samples)
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
    ## 1523 GTEX-145ME Female 40-49 Ventilator Case GTEX-145ME-0926-SM-5O9AR
    ## 1524 GTEX-145ME Female 40-49 Ventilator Case GTEX-145ME-1026-SM-5O9B4
    ## 1525 GTEX-145ME Female 40-49 Ventilator Case GTEX-145ME-1126-SM-5SIAT
    ## 1526 GTEX-145ME Female 40-49 Ventilator Case GTEX-145ME-1226-SM-5SIB6
    ## 1527 GTEX-145ME Female 40-49 Ventilator Case GTEX-145ME-1326-SM-5O98Q
    ## 1528 GTEX-145ME Female 40-49 Ventilator Case GTEX-145ME-1426-SM-5RQJS
    ##                 SMTS SMNABTCH  SMNABTCHD SMGEBTCHT SMAFRZE SMCENTER SMRIN
    ## 1523 Small Intestine BP-47675 2013-12-19 TruSeq.v1  RNASEQ       B1   7.4
    ## 1524         Stomach BP-47675 2013-12-19 TruSeq.v1  RNASEQ       B1   7.4
    ## 1525           Colon BP-47616 2013-12-18 TruSeq.v1  RNASEQ       B1   6.9
    ## 1526           Ovary BP-47616 2013-12-18 TruSeq.v1  RNASEQ       B1   7.3
    ## 1527          Uterus BP-47675 2013-12-19 TruSeq.v1  RNASEQ       B1   8.5
    ## 1528          Vagina BP-48437 2014-01-17 TruSeq.v1  RNASEQ       B1   7.2
    ##      SMATSSCR
    ## 1523        1
    ## 1524        1
    ## 1525        1
    ## 1526        1
    ## 1527        1
    ## 1528        1

``` r
str(samples)
```

    ## 'data.frame':    1528 obs. of  13 variables:
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
    ##  Length:1528        Length:1528        Length:1528        Length:1528       
    ##  Class :character   Class :character   Class :character   Class :character  
    ##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
    ##                                                                             
    ##                                                                             
    ##                                                                             
    ##     SAMPID              SMTS             SMNABTCH          SMNABTCHD        
    ##  Length:1528        Length:1528        Length:1528        Length:1528       
    ##  Class :character   Class :character   Class :character   Class :character  
    ##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
    ##                                                                             
    ##                                                                             
    ##                                                                             
    ##   SMGEBTCHT           SMAFRZE            SMCENTER             SMRIN       
    ##  Length:1528        Length:1528        Length:1528        Min.   : 3.200  
    ##  Class :character   Class :character   Class :character   1st Qu.: 6.300  
    ##  Mode  :character   Mode  :character   Mode  :character   Median : 7.000  
    ##                                                           Mean   : 7.058  
    ##                                                           3rd Qu.: 7.700  
    ##                                                           Max.   :10.000  
    ##     SMATSSCR     
    ##  Min.   :0.0000  
    ##  1st Qu.:0.0000  
    ##  Median :1.0000  
    ##  Mean   :0.8534  
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

    ## [1] 63811   306

``` r
head(counts)[1:5]
```

    ##                 GTEX.12ZZX.0726.SM.5EGKA.1 GTEX.13D11.1526.SM.5J2NA.1
    ## ENSG00000278704                          0                          0
    ## ENSG00000277400                          0                          0
    ## ENSG00000274847                          0                          0
    ## ENSG00000277428                          0                          0
    ## ENSG00000276256                          0                          0
    ## ENSG00000278198                          0                          0
    ##                 GTEX.ZAJG.0826.SM.5PNVA.1 GTEX.11TT1.1426.SM.5EGIA.1
    ## ENSG00000278704                         0                          0
    ## ENSG00000277400                         0                          0
    ## ENSG00000274847                         0                          0
    ## ENSG00000277428                         0                          0
    ## ENSG00000276256                         0                          0
    ## ENSG00000278198                         0                          0
    ##                 GTEX.13VXT.1126.SM.5LU3A.1
    ## ENSG00000278704                          0
    ## ENSG00000277400                          0
    ## ENSG00000274847                          0
    ## ENSG00000277428                          0
    ## ENSG00000276256                          0
    ## ENSG00000278198                          0

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

    ## [1] 1528   13

How many samples are there per tissue?

``` r
dplyr::count(samples, SMTS) 
```

    ##               SMTS   n
    ## 1   Adipose Tissue 134
    ## 2    Adrenal Gland  20
    ## 3     Blood Vessel 139
    ## 4            Brain  82
    ## 5           Breast  50
    ## 6            Colon  78
    ## 7        Esophagus 144
    ## 8            Heart 106
    ## 9           Kidney   6
    ## 10           Liver  28
    ## 11            Lung  78
    ## 12          Muscle 104
    ## 13           Nerve  71
    ## 14           Ovary  16
    ## 15        Pancreas  30
    ## 16       Pituitary  37
    ## 17        Prostate  24
    ## 18  Salivary Gland  22
    ## 19            Skin 160
    ## 20 Small Intestine  23
    ## 21          Spleen  16
    ## 22         Stomach  29
    ## 23          Testis  37
    ## 24         Thyroid  69
    ## 25          Uterus  14
    ## 26          Vagina  11

How many samples are there per tissue and sex? Can we test the effect of
sex on gene expression in all tissues? For many samples, yes, but not
all tissues were samples from both males and females.

``` r
head(dplyr::count(samples, SMTS, SEX))
```

    ##             SMTS    SEX  n
    ## 1 Adipose Tissue Female 40
    ## 2 Adipose Tissue   Male 94
    ## 3  Adrenal Gland Female  7
    ## 4  Adrenal Gland   Male 13
    ## 5   Blood Vessel Female 48
    ## 6   Blood Vessel   Male 91

How many samples are there per sex, age, and hardy scale? Do you have
enough samples to test the effects of Sex, Age, and Hardy Scale in the
Heart?

``` r
head(dplyr::count(samples, SMTS, SEX, AGE, DTHHRDY ) )
```

    ##             SMTS    SEX   AGE                      DTHHRDY n
    ## 1 Adipose Tissue Female 20-29              Ventilator Case 3
    ## 2 Adipose Tissue Female 30-39              Ventilator Case 2
    ## 3 Adipose Tissue Female 40-49 Fast death of natural causes 1
    ## 4 Adipose Tissue Female 40-49              Ventilator Case 5
    ## 5 Adipose Tissue Female 40-49       Violent and fast death 2
    ## 6 Adipose Tissue Female 50-59 Fast death of natural causes 3

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
results %>% 
  filter(adj.P.Val < 0.05) %>% 
  head()
```

    ##            logFC  AveExpr         t      P.Value  adj.P.Val          B
    ## AAGAB -0.4011097 4.904460 -4.013690 0.0001394737 0.02151260  0.8922610
    ## ABCA6  0.7016965 5.597551  3.502285 0.0007779680 0.03216746 -0.6657214
    ## ABCA9  0.6970969 6.237353  3.114336 0.0026040559 0.04866231 -1.7334759
    ## ABCB7 -0.3708764 5.088921 -3.134484 0.0024510401 0.04755891 -1.6840509
    ## ABCD3 -0.6082187 6.190704 -3.966022 0.0001646305 0.02282632  0.7409476
    ## ABCE1 -0.3764537 5.332213 -3.336582 0.0013173889 0.03802552 -1.1360534

``` r
results %>% 
  filter(logFC > 1 | logFC < -1) %>%
  head()
```

    ##              logFC   AveExpr         t     P.Value  adj.P.Val          B
    ## ACTA1    -1.358451 10.437939 -2.446102 0.016765666 0.10888918 -3.1289828
    ## ADAMTSL2  1.338257  5.208146  2.900833 0.004871530 0.06245142 -2.2916348
    ## ADH1B     1.259668  7.381462  3.382176 0.001141426 0.03624785 -0.9658612
    ## ADIPOQ   -1.119484  1.117207 -1.720643 0.089405972 0.26371302 -4.3157948
    ## AJAP1     1.010117 -1.212201  2.790425 0.006659281 0.07018819 -2.4766685
    ## ALAS2     1.122494 -1.039829  1.840601 0.069603628 0.22901993 -4.0459220

Sometimes its nice to arrange by p-value.

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

    ##                                                SAMPID  SMTS
    ## GTEX-12ZZX-0726-SM-5EGKA.1 GTEX-12ZZX-0726-SM-5EGKA.1 Heart
    ## GTEX-13D11-1526-SM-5J2NA.1 GTEX-13D11-1526-SM-5J2NA.1 Heart
    ## GTEX-ZAJG-0826-SM-5PNVA.1   GTEX-ZAJG-0826-SM-5PNVA.1 Heart
    ## GTEX-11TT1-1426-SM-5EGIA.1 GTEX-11TT1-1426-SM-5EGIA.1 Heart
    ## GTEX-13VXT-1126-SM-5LU3A.1 GTEX-13VXT-1126-SM-5LU3A.1 Heart
    ## GTEX-14ASI-0826-SM-5Q5EB.1 GTEX-14ASI-0826-SM-5Q5EB.1 Heart
    ##                                               SMTSD     SUBJID    SEX   AGE
    ## GTEX-12ZZX-0726-SM-5EGKA.1 Heart - Atrial Appendage GTEX-12ZZX Female 40-49
    ## GTEX-13D11-1526-SM-5J2NA.1 Heart - Atrial Appendage GTEX-13D11 Female 50-59
    ## GTEX-ZAJG-0826-SM-5PNVA.1    Heart - Left Ventricle  GTEX-ZAJG Female 50-59
    ## GTEX-11TT1-1426-SM-5EGIA.1 Heart - Atrial Appendage GTEX-11TT1   Male 20-29
    ## GTEX-13VXT-1126-SM-5LU3A.1   Heart - Left Ventricle GTEX-13VXT Female 20-29
    ## GTEX-14ASI-0826-SM-5Q5EB.1 Heart - Atrial Appendage GTEX-14ASI   Male 60-69
    ##                            SMRIN                      DTHHRDY        SRA
    ## GTEX-12ZZX-0726-SM-5EGKA.1   7.1       Violent and fast death SRR1340617
    ## GTEX-13D11-1526-SM-5J2NA.1   8.9              Ventilator Case SRR1345436
    ## GTEX-ZAJG-0826-SM-5PNVA.1    6.4           Intermediate death SRR1367456
    ## GTEX-11TT1-1426-SM-5EGIA.1   9.0              Ventilator Case SRR1378243
    ## GTEX-13VXT-1126-SM-5LU3A.1   8.6              Ventilator Case SRR1381693
    ## GTEX-14ASI-0826-SM-5Q5EB.1   6.4 Fast death of natural causes SRR1335164
    ##                                  DATE
    ## GTEX-12ZZX-0726-SM-5EGKA.1 2013-10-22
    ## GTEX-13D11-1526-SM-5J2NA.1 2013-12-04
    ## GTEX-ZAJG-0826-SM-5PNVA.1  2013-10-31
    ## GTEX-11TT1-1426-SM-5EGIA.1 2013-10-24
    ## GTEX-13VXT-1126-SM-5LU3A.1 2013-12-17
    ## GTEX-14ASI-0826-SM-5Q5EB.1 2014-01-17

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

    ## [1] "GTEX-12ZZX-0726-SM-5EGKA.1" "GTEX-13D11-1526-SM-5J2NA.1"
    ## [3] "GTEX-ZAJG-0826-SM-5PNVA.1"  "GTEX-11TT1-1426-SM-5EGIA.1"
    ## [5] "GTEX-13VXT-1126-SM-5LU3A.1" "GTEX-14ASI-0826-SM-5Q5EB.1"

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

    ## [1] "GTEX.12ZZX.0726.SM.5EGKA.1" "GTEX.13D11.1526.SM.5J2NA.1"
    ## [3] "GTEX.ZAJG.0826.SM.5PNVA.1"  "GTEX.11TT1.1426.SM.5EGIA.1"
    ## [5] "GTEX.13VXT.1126.SM.5LU3A.1" "GTEX.14ASI.0826.SM.5Q5EB.1"

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
genes <- read.table("./data/ensembl_genes.tsv", sep = "\t",  header = T, fill = T)
```

    ## Warning in scan(file = file, what = what, sep = sep, quote = quote, dec = dec, :
    ## EOF within quoted string

``` r
head(genes)
```

    ##                id     name
    ## 1 ENSG00000000003   TSPAN6
    ## 2 ENSG00000000005     TNMD
    ## 3 ENSG00000000419     DPM1
    ## 4 ENSG00000000457    SCYL3
    ## 5 ENSG00000000460 C1orf112
    ## 6 ENSG00000000938      FGR
    ##                                                                                      description
    ## 1                                              tetraspanin 6 [Source:HGNC Symbol;Acc:HGNC:11858]
    ## 2                                                tenomodulin [Source:HGNC Symbol;Acc:HGNC:17757]
    ## 3 dolichyl-phosphate mannosyltransferase subunit 1, catalytic [Source:HGNC Symbol;Acc:HGNC:3005]
    ## 4                                   SCY1 like pseudokinase 3 [Source:HGNC Symbol;Acc:HGNC:19285]
    ## 5                        chromosome 1 open reading frame 112 [Source:HGNC Symbol;Acc:HGNC:25565]
    ## 6              FGR proto-oncogene, Src family tyrosine kinase [Source:HGNC Symbol;Acc:HGNC:3697]
    ##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             synonyms
    ## 1                                                                                                                                                                                                                                                              [ENTREZ:7105, HGNC:11858, MIM:300191, NM_001278740, NM_001278741, NM_001278742, NM_001278743, NM_003270, NP_001265669, NP_001265670, NP_001265671, NP_001265672, NP_003261, T245, TM4SF6, TSPAN-6, TSPAN6, XM_011531018, XP_011529320, tetraspanin 6]
    ## 2                                                                                                                                                                                                                                                                                                                                                                                                                [BRICD4, CHM1L, ENTREZ:64102, HGNC:17757, MIM:300459, NM_022144, NP_071427, TEM, TNMD, tenomodulin]
    ## 3                                                                                                                                                                                                                                              [CDGIE, DPM1, ENTREZ:8813, HGNC:3005, MIM:603503, MPDS, NM_001317034, NM_001317035, NM_001317036, NM_003859, NP_001303963, NP_001303964, NP_001303965, NP_003850, NR_133648, XR_002958550, XR_002958551, dolichyl-phosphate mannosyltransferase subunit 1, catalytic]
    ## 4                                                                                         [ENTREZ:57147, HGNC:19285, MIM:608192, NM_020423, NM_181093, NP_065156, NP_851607, PACE-1, PACE1, SCY1 like pseudokinase 3, SCYL3, XM_006711465, XM_011509801, XM_011509802, XM_011509803, XM_017001862, XM_017001863, XM_017001864, XM_017001865, XM_024448565, XP_006711528, XP_011508103, XP_011508104, XP_011508105, XP_016857351, XP_016857352, XP_016857353, XP_016857354, XP_024304333, XR_001737335, XR_001737336]
    ## 5 [C1orf112, ENTREZ:55732, HGNC:25565, NM_001320047, NM_001320048, NM_001320050, NM_001320051, NM_001363739, NM_001366768, NM_001366769, NM_001366770, NM_001366771, NM_001366772, NM_001366773, NM_018186, NP_001306976, NP_001306977, NP_001306979, NP_001306980, NP_001350668, NP_001353697, NP_001353698, NP_001353699, NP_001353700, NP_001353701, NP_001353702, NR_159440, XM_011509735, XM_017001722, XM_017001723, XP_011508037, XP_016857211, XP_016857212, XR_921872, chromosome 1 open reading frame 112]
    ## 6                                      [ENTREZ:2268, FGR proto-oncogene, Src family tyrosine kinase, FGR, HGNC:3697, MIM:164940, NM_001042729, NM_001042747, NM_005248, NP_001036194, NP_001036212, NP_005239, SRC2, XM_006710452, XM_011541010, XM_011541011, XM_011541012, XM_011541013, XM_011541014, XM_017000673, XM_017000674, XP_006710515, XP_011539312, XP_011539313, XP_011539314, XP_011539315, XP_011539316, XP_016856162, XP_016856163, XR_946583, c-fgr, c-src2, p55-Fgr, p55c-fgr, p58-Fgr, p58c-fgr]
    ##        organism
    ## 1 NCBI:txid9606
    ## 2 NCBI:txid9606
    ## 3 NCBI:txid9606
    ## 4 NCBI:txid9606
    ## 5 NCBI:txid9606
    ## 6 NCBI:txid9606

The column with genes symbols is called `name`. To combine this data
frame without results. We can use the mutate function to create a new
column based off the row names. Let’s save this as `resultsSymbol`.

``` r
resultsSymbol <- results %>%
  mutate(name = row.names(.))
head(resultsSymbol)
```

    ##               logFC    AveExpr         t    P.Value adj.P.Val         B
    ## A1BG     0.67408600  1.6404652 2.1740238 0.03283291 0.1536518 -3.617093
    ## A1BG-AS1 0.23168690 -0.1864802 1.0403316 0.30150123 0.5316030 -4.984225
    ## A2M      0.02453974  9.8251848 0.1948624 0.84602333 0.9215696 -5.783835
    ## A2M-AS1  0.38115436  2.4535892 2.4839630 0.01520646 0.1033370 -3.067127
    ## A2ML1    0.58865741 -1.0412696 1.8263856 0.07173966 0.2328150 -4.065276
    ## A2MP1    0.31631081 -0.8994146 1.4061454 0.16377753 0.3730822 -4.583435
    ##              name
    ## A1BG         A1BG
    ## A1BG-AS1 A1BG-AS1
    ## A2M           A2M
    ## A2M-AS1   A2M-AS1
    ## A2ML1       A2ML1
    ## A2MP1       A2MP1

Now, we can use one of the join functions to combine two data frames.
`left_join` will return all records from the left table and any matching
values from the right. `right_join` will return all values from the
right table and any matching values from the left. `inner_join` will
return records that have values in both tables. `full_join` will return
everything.

``` r
resultsName <- left_join(resultsSymbol, genes, by = "name")
head(resultsName)
```

    ##        logFC    AveExpr         t    P.Value adj.P.Val         B     name
    ## 1 0.67408600  1.6404652 2.1740238 0.03283291 0.1536518 -3.617093     A1BG
    ## 2 0.23168690 -0.1864802 1.0403316 0.30150123 0.5316030 -4.984225 A1BG-AS1
    ## 3 0.02453974  9.8251848 0.1948624 0.84602333 0.9215696 -5.783835      A2M
    ## 4 0.38115436  2.4535892 2.4839630 0.01520646 0.1033370 -3.067127  A2M-AS1
    ## 5 0.58865741 -1.0412696 1.8263856 0.07173966 0.2328150 -4.065276    A2ML1
    ## 6 0.31631081 -0.8994146 1.4061454 0.16377753 0.3730822 -4.583435    A2MP1
    ##                id
    ## 1 ENSG00000121410
    ## 2            <NA>
    ## 3            <NA>
    ## 4            <NA>
    ## 5 ENSG00000166535
    ## 6            <NA>
    ##                                                        description
    ## 1           alpha-1-B glycoprotein [Source:HGNC Symbol;Acc:HGNC:5]
    ## 2                                                             <NA>
    ## 3                                                             <NA>
    ## 4                                                             <NA>
    ## 5 alpha-2-macroglobulin like 1 [Source:HGNC Symbol;Acc:HGNC:23336]
    ## 6                                                             <NA>
    ##                                                                                                                                                                                                                                                                                                                 synonyms
    ## 1                                                                                                                                                                                                            [A1B, A1BG, ABG, ENTREZ:1, GAB, HGNC:5, HYST2477, MIM:138670, NM_130786, NP_570602, alpha-1-B glycoprotein]
    ## 2                                                                                                                                                                                                                                                                                                                   <NA>
    ## 3                                                                                                                                                                                                                                                                                                                   <NA>
    ## 4                                                                                                                                                                                                                                                                                                                   <NA>
    ## 5 [A2ML1, CPAMD9, ENTREZ:144568, HGNC:23336, MIM:610627, NM_001282424, NM_144670, NP_001269353, NP_653271, OMS, XM_011520566, XM_011520567, XM_017018868, XM_017018869, XM_017018870, XP_011518868, XP_011518869, XP_016874357, XP_016874358, XP_016874359, XR_001748594, XR_931275, alpha-2-macroglobulin like 1, p170]
    ## 6                                                                                                                                                                                                                                                                                                                   <NA>
    ##        organism
    ## 1 NCBI:txid9606
    ## 2          <NA>
    ## 3          <NA>
    ## 4          <NA>
    ## 5 NCBI:txid9606
    ## 6          <NA>

Congratulations! You have successfully joined two tables. Now, you can
filter and select columsn to make a pretty table of the DEGS.

.

``` r
resultsNameTidy <- resultsName %>%
  filter(adj.P.Val < 0.05,
                   logFC > 1 | logFC < -1) %>%
  arrange(adj.P.Val) %>%
  select(name, description, id, logFC, AveExpr, adj.P.Val)
head(resultsNameTidy)
```

    ##           name
    ## 1        EDA2R
    ## 2       PTCHD4
    ## 3       BTBD11
    ## 4     MTHFD2P1
    ## 5      C4orf54
    ## 6 LOC101929331
    ##                                                              description
    ## 1                                                                   <NA>
    ## 2        patched domain containing 4 [Source:HGNC Symbol;Acc:HGNC:21345]
    ## 3                                                                   <NA>
    ## 4                                                                   <NA>
    ## 5 chromosome 4 open reading frame 54 [Source:HGNC Symbol;Acc:HGNC:27741]
    ## 6                                                                   <NA>
    ##                id     logFC    AveExpr    adj.P.Val
    ## 1            <NA>  1.253278  1.0260046 0.0004544671
    ## 2 ENSG00000244694  1.962957 -1.7174066 0.0004544671
    ## 3            <NA> -1.194207  0.4506981 0.0044764970
    ## 4            <NA>  1.825674 -1.6578790 0.0044764970
    ## 5 ENSG00000248713 -2.824211  2.7276196 0.0159674585
    ## 6            <NA>  1.129013 -1.6306733 0.0175055847

Now, let’s make a list of the Ensemble IDs of the DEGs .

``` r
resultsNameTidyIds <- resultsNameTidy %>%
  drop_na(id) %>%
  pull(id)
resultsNameTidyIds
```

    ##  [1] "ENSG00000244694" "ENSG00000248713" "ENSG00000007933" "ENSG00000239474"
    ##  [5] "ENSG00000185615" "ENSG00000022267" "ENSG00000138347" "ENSG00000205221"
    ##  [9] "ENSG00000188783" "ENSG00000088882" "ENSG00000196616"

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
  mutate(id = row.names(.)) %>%
  filter(id %in% resultsNameTidyIds)
dim(counts_tidy_slim)
```

    ## [1]  11 307

``` r
head(counts_tidy_slim)[1:5]
```

    ##                 GTEX.12ZZX.0726.SM.5EGKA.1 GTEX.13D11.1526.SM.5J2NA.1
    ## ENSG00000007933                       9772                      16299
    ## ENSG00000188783                    2372757                    3306346
    ## ENSG00000138347                     656172                     692042
    ## ENSG00000185615                      14385                      10734
    ## ENSG00000205221                     137920                     192318
    ## ENSG00000239474                     329732                     201574
    ##                 GTEX.ZAJG.0826.SM.5PNVA.1 GTEX.11TT1.1426.SM.5EGIA.1
    ## ENSG00000007933                     32826                       2685
    ## ENSG00000188783                   2121770                     272055
    ## ENSG00000138347                    300549                     760218
    ## ENSG00000185615                     33927                       3075
    ## ENSG00000205221                     54148                      14700
    ## ENSG00000239474                    152104                     584987
    ##                 GTEX.13VXT.1126.SM.5LU3A.1
    ## ENSG00000007933                       5120
    ## ENSG00000188783                     291091
    ## ENSG00000138347                    1288805
    ## ENSG00000185615                       3339
    ## ENSG00000205221                      52296
    ## ENSG00000239474                     688891

``` r
tail(counts_tidy_slim)
```

    ##                 GTEX.12ZZX.0726.SM.5EGKA.1 GTEX.13D11.1526.SM.5J2NA.1
    ## ENSG00000239474                     329732                     201574
    ## ENSG00000088882                      20189                       5408
    ## ENSG00000196616                    1027184                    2399081
    ## ENSG00000248713                      30591                     295903
    ## ENSG00000244694                       1004                        718
    ## ENSG00000022267                    2503873                    5635021
    ##                 GTEX.ZAJG.0826.SM.5PNVA.1 GTEX.11TT1.1426.SM.5EGIA.1
    ## ENSG00000239474                    152104                     584987
    ## ENSG00000088882                      3842                      30837
    ## ENSG00000196616                    237476                     755213
    ## ENSG00000248713                       901                     175863
    ## ENSG00000244694                        76                        214
    ## ENSG00000022267                   1665270                    2438587
    ##                 GTEX.13VXT.1126.SM.5LU3A.1 GTEX.14ASI.0826.SM.5Q5EB.1
    ## ENSG00000239474                     688891                     613314
    ## ENSG00000088882                       2889                      28415
    ## ENSG00000196616                     263871                    1639802
    ## ENSG00000248713                     128831                       8266
    ## ENSG00000244694                        565                       2005
    ## ENSG00000022267                   15867945                    3041048
    ##                 GTEX.ZF3C.1226.SM.4WWCB.1 GTEX.Y8E4.0426.SM.4V6GB.1
    ## ENSG00000239474                     13481                    610368
    ## ENSG00000088882                      5097                    101871
    ## ENSG00000196616                    122209                   2927462
    ## ENSG00000248713                         0                     26525
    ## ENSG00000244694                      9472                      7248
    ## ENSG00000022267                    371084                   3123426
    ##                 GTEX.13PVR.0926.SM.5S2RB.1 GTEX.12BJ1.0326.SM.5FQUB.1
    ## ENSG00000239474                     229676                     366824
    ## ENSG00000088882                       4127                      37191
    ## ENSG00000196616                    1179181                     663248
    ## ENSG00000248713                       7843                     137260
    ## ENSG00000244694                       1075                        875
    ## ENSG00000022267                     849117                    4948675
    ##                 GTEX.131XH.0226.SM.5LZVB.1 GTEX.11O72.1026.SM.5986B.1
    ## ENSG00000239474                      72999                     101511
    ## ENSG00000088882                       2662                       7856
    ## ENSG00000196616                     235872                     324722
    ## ENSG00000248713                      18936                     391141
    ## ENSG00000244694                       2555                       1672
    ## ENSG00000022267                    1211671                    5234961
    ##                 GTEX.12WSG.1226.SM.5EQ4C.1 GTEX.13PVQ.1226.SM.5IJDC.1
    ## ENSG00000239474                     497687                     388504
    ## ENSG00000088882                       8786                       4857
    ## ENSG00000196616                    1422539                      25481
    ## ENSG00000248713                      23572                      14606
    ## ENSG00000244694                       2480                       1563
    ## ENSG00000022267                    8012113                    4774692
    ##                 GTEX.13112.0426.SM.5PNVC.1 GTEX.139TU.1926.SM.5J2OC.1
    ## ENSG00000239474                     225676                     236078
    ## ENSG00000088882                      10999                     161158
    ## ENSG00000196616                     877517                     607501
    ## ENSG00000248713                       1766                     379730
    ## ENSG00000244694                       4792                       5841
    ## ENSG00000022267                    3284862                   11594668
    ##                 GTEX.1399U.0726.SM.5KM1D.1 GTEX.ZE7O.0626.SM.57WCD.1
    ## ENSG00000239474                     335147                    242206
    ## ENSG00000088882                       5872                     15962
    ## ENSG00000196616                    1994178                    685834
    ## ENSG00000248713                       6993                      1398
    ## ENSG00000244694                        878                      2072
    ## ENSG00000022267                     840440                   1828323
    ##                 GTEX.13OVG.0526.SM.5K7YD.1 GTEX.11LCK.0826.SM.5PNYD.1
    ## ENSG00000239474                     493480                     320314
    ## ENSG00000088882                      11281                      23278
    ## ENSG00000196616                     961743                    1284410
    ## ENSG00000248713                       7438                      15308
    ## ENSG00000244694                       2421                        852
    ## ENSG00000022267                    2301776                    1326193
    ##                 GTEX.11ZVC.0426.SM.5CVLD.1 GTEX.13W3W.0426.SM.5SI9D.1
    ## ENSG00000239474                     100813                     660742
    ## ENSG00000088882                       4464                      19722
    ## ENSG00000196616                     362182                     457571
    ## ENSG00000248713                       1759                    1135552
    ## ENSG00000244694                       1769                       1596
    ## ENSG00000022267                     922001                   25598354
    ##                 GTEX.146FR.0926.SM.5QGPE.1 GTEX.ZVT2.0926.SM.5GICE.1
    ## ENSG00000239474                     316669                    243183
    ## ENSG00000088882                       4171                     22658
    ## ENSG00000196616                    2571023                   2029661
    ## ENSG00000248713                     298849                      7699
    ## ENSG00000244694                       2446                       770
    ## ENSG00000022267                    2619220                   1066416
    ##                 GTEX.13O3Q.0326.SM.5L3FE.1 GTEX.14E6C.0326.SM.5Q5EE.1
    ## ENSG00000239474                      90862                     164808
    ## ENSG00000088882                      22234                      20693
    ## ENSG00000196616                     308651                    2279576
    ## ENSG00000248713                      58231                       1077
    ## ENSG00000244694                       1704                        275
    ## ENSG00000022267                    2651407                    1710616
    ##                 GTEX.131XG.0526.SM.5DUWF.1 GTEX.1445S.1226.SM.5O9BF.1
    ## ENSG00000239474                     279790                     451412
    ## ENSG00000088882                       6336                       5992
    ## ENSG00000196616                     902270                    6689956
    ## ENSG00000248713                      18454                       4971
    ## ENSG00000244694                       1817                       5483
    ## ENSG00000022267                     898047                    2827815
    ##                 GTEX.13FHO.1226.SM.5L3EF.1 GTEX.YEC4.0226.SM.4W1YG.1
    ## ENSG00000239474                     327475                    700402
    ## ENSG00000088882                       7799                      3622
    ## ENSG00000196616                    2575719                   1015310
    ## ENSG00000248713                       1319                     27948
    ## ENSG00000244694                       1459                      1150
    ## ENSG00000022267                    1655023                   4913484
    ##                 GTEX.ZF3C.1126.SM.57WEG.1 GTEX.12WSC.1126.SM.5EQ4G.1
    ## ENSG00000239474                    279302                     336994
    ## ENSG00000088882                     11710                      69331
    ## ENSG00000196616                    785593                     340208
    ## ENSG00000248713                   1094381                       2911
    ## ENSG00000244694                      7425                      10141
    ## ENSG00000022267                   4427137                    2065900
    ##                 GTEX.YECK.1226.SM.4W21G.1 GTEX.ZAB5.0226.SM.5CVMH.1
    ## ENSG00000239474                    168986                    472408
    ## ENSG00000088882                     17890                      1323
    ## ENSG00000196616                    940500                    717344
    ## ENSG00000248713                     85983                      6019
    ## ENSG00000244694                      2371                      2242
    ## ENSG00000022267                   5228009                   3557245
    ##                 GTEX.12WSN.0226.SM.5DUXH.1 GTEX.ZF2S.0826.SM.4WWBI.1
    ## ENSG00000239474                     187954                    335606
    ## ENSG00000088882                       8778                     58002
    ## ENSG00000196616                     992999                   1165488
    ## ENSG00000248713                     149809                      8551
    ## ENSG00000244694                       1113                      3925
    ## ENSG00000022267                    3140505                   1575747
    ##                 GTEX.ZYWO.0526.SM.5E45I.1 GTEX.12696.1126.SM.5FQTI.1
    ## ENSG00000239474                    372883                    1017286
    ## ENSG00000088882                     11388                       4626
    ## ENSG00000196616                   1878353                     295854
    ## ENSG00000248713                     90019                       5130
    ## ENSG00000244694                      1429                        816
    ## ENSG00000022267                   4999859                   10748217
    ##                 GTEX.ZPIC.0826.SM.4WWFJ.1 GTEX.132NY.1426.SM.5J1MJ.1
    ## ENSG00000239474                    354155                     282408
    ## ENSG00000088882                     37638                      28115
    ## ENSG00000196616                    212334                     721745
    ## ENSG00000248713                    830070                      49497
    ## ENSG00000244694                       672                       6125
    ## ENSG00000022267                  34347895                   10683926
    ##                 GTEX.12WSI.0426.SM.5EQ5J.1 GTEX.14C39.0726.SM.5RQIK.1
    ## ENSG00000239474                     103717                      46146
    ## ENSG00000088882                       3006                       7247
    ## ENSG00000196616                    1139257                     447330
    ## ENSG00000248713                       3869                        557
    ## ENSG00000244694                        781                       5334
    ## ENSG00000022267                    1564873                    1576617
    ##                 GTEX.12ZZY.1226.SM.5GCNK.1 GTEX.13S86.0326.SM.5SI6K.1
    ## ENSG00000239474                     134638                     441039
    ## ENSG00000088882                      76376                      22044
    ## ENSG00000196616                     439804                     748056
    ## ENSG00000248713                       7293                     444405
    ## ENSG00000244694                       7400                       5445
    ## ENSG00000022267                    2804395                    8179210
    ##                 GTEX.ZDYS.0226.SM.5HL4K.1 GTEX.ZUA1.0826.SM.4YCDL.1
    ## ENSG00000239474                    915221                     16519
    ## ENSG00000088882                      3118                      8815
    ## ENSG00000196616                    748634                    129122
    ## ENSG00000248713                     74839                       797
    ## ENSG00000244694                      1667                      5786
    ## ENSG00000022267                  10961346                    549579
    ##                 GTEX.1497J.1226.SM.5Q5BL.1 GTEX.13OW6.1126.SM.5L3HL.1
    ## ENSG00000239474                     133245                     143385
    ## ENSG00000088882                       3997                       4802
    ## ENSG00000196616                     492325                     222328
    ## ENSG00000248713                       2233                       3108
    ## ENSG00000244694                        151                       2129
    ## ENSG00000022267                    2051950                    2432549
    ##                 GTEX.13OW6.0926.SM.5L3GM.1 GTEX.1269C.0826.SM.5N9EM.1
    ## ENSG00000239474                     357718                      27391
    ## ENSG00000088882                      52799                       4781
    ## ENSG00000196616                    2215985                     373352
    ## ENSG00000248713                       7064                       2342
    ## ENSG00000244694                       2289                       1109
    ## ENSG00000022267                    1882985                     912105
    ##                 GTEX.12ZZW.1026.SM.5GCMM.1 GTEX.11GSP.1226.SM.5985M.1
    ## ENSG00000239474                       4849                     137007
    ## ENSG00000088882                       5486                     158195
    ## ENSG00000196616                    3578089                     273695
    ## ENSG00000248713                        250                       2480
    ## ENSG00000244694                       4316                       1408
    ## ENSG00000022267                    1030583                    3124615
    ##                 GTEX.ZPU1.0626.SM.4YCDM.1 GTEX.11TT1.1326.SM.5PNYM.1
    ## ENSG00000239474                    604089                    1069084
    ## ENSG00000088882                      1394                      14065
    ## ENSG00000196616                    167233                     213331
    ## ENSG00000248713                      2680                    2388441
    ## ENSG00000244694                      1312                        131
    ## ENSG00000022267                   2131657                   13781517
    ##                 GTEX.12696.1226.SM.5FQSM.1 GTEX.1117F.0726.SM.5GIEN.1
    ## ENSG00000239474                     439308                      82569
    ## ENSG00000088882                       6337                      45985
    ## ENSG00000196616                     977922                    2518466
    ## ENSG00000248713                     211454                       1730
    ## ENSG00000244694                       2058                       5581
    ## ENSG00000022267                   10558254                    1726985
    ##                 GTEX.ZEX8.0426.SM.4WWEN.1 GTEX.YF7O.0526.SM.5P9IO.1
    ## ENSG00000239474                   1164001                    691180
    ## ENSG00000088882                     23051                     10051
    ## ENSG00000196616                    313681                    300010
    ## ENSG00000248713                    673535                    853334
    ## ENSG00000244694                       887                       399
    ## ENSG00000022267                   9787814                  12017033
    ##                 GTEX.11EMC.0726.SM.5EGJO.1 GTEX.13NYB.0326.SM.5IJDP.1
    ## ENSG00000239474                     153105                     282697
    ## ENSG00000088882                      23843                      59148
    ## ENSG00000196616                    1228621                    1589828
    ## ENSG00000248713                       1200                      59807
    ## ENSG00000244694                       1848                       2636
    ## ENSG00000022267                    1176550                    2540001
    ##                 GTEX.11DYG.1026.SM.5A5JQ.1 GTEX.117XS.0726.SM.5H131.1
    ## ENSG00000239474                     505701                     163439
    ## ENSG00000088882                       4497                        873
    ## ENSG00000196616                    2604348                     595528
    ## ENSG00000248713                       4651                       3270
    ## ENSG00000244694                        775                       4553
    ## ENSG00000022267                    3428319                    1910797
    ##                 GTEX.13OVL.0526.SM.5KLZQ.1 GTEX.13FTZ.0326.SM.5J1O1.1
    ## ENSG00000239474                     356485                      88785
    ## ENSG00000088882                      21289                      66765
    ## ENSG00000196616                     784495                    1316346
    ## ENSG00000248713                       3198                       1585
    ## ENSG00000244694                       1460                      14674
    ## ENSG00000022267                    2901578                    5727377
    ##                 GTEX.11DXY.0826.SM.5EGGR.1 GTEX.11O72.1126.SM.5N9E2.1
    ## ENSG00000239474                      39715                     171327
    ## ENSG00000088882                      12627                      24186
    ## ENSG00000196616                     288605                     251411
    ## ENSG00000248713                        552                       1160
    ## ENSG00000244694                       1252                       2235
    ## ENSG00000022267                     567554                    1280833
    ##                 GTEX.111YS.0326.SM.5GZZ3.1 GTEX.11P81.0526.SM.59873.1
    ## ENSG00000239474                     359130                     356190
    ## ENSG00000088882                       1183                      37392
    ## ENSG00000196616                    2556352                    1372544
    ## ENSG00000248713                      55387                       5388
    ## ENSG00000244694                       1209                         22
    ## ENSG00000022267                    2921282                    1180426
    ##                 GTEX.YF7O.0426.SM.5P9FS.1 GTEX.1192W.0226.SM.5EGGT.1
    ## ENSG00000239474                   1363449                     148335
    ## ENSG00000088882                      7143                      27643
    ## ENSG00000196616                    142542                     489673
    ## ENSG00000248713                   2039123                       5282
    ## ENSG00000244694                      3162                       4615
    ## ENSG00000022267                  48334489                    1969620
    ##                 GTEX.13NZB.0226.SM.5KM1T.1 GTEX.13OVG.0426.SM.5KM2T.1
    ## ENSG00000239474                     426586                     157360
    ## ENSG00000088882                       2571                      72884
    ## ENSG00000196616                     719862                    2451158
    ## ENSG00000248713                       2293                      13887
    ## ENSG00000244694                       1479                       3907
    ## ENSG00000022267                    2484708                    1466816
    ##                 GTEX.11I78.0826.SM.5A5K4.1 GTEX.13O3P.1426.SM.5L3DT.1
    ## ENSG00000239474                     668940                     319592
    ## ENSG00000088882                       8764                       3929
    ## ENSG00000196616                     429196                    1092105
    ## ENSG00000248713                     293079                     223968
    ## ENSG00000244694                       1752                       1412
    ## ENSG00000022267                   11312473                    2942280
    ##                 GTEX.13N1W.1026.SM.5IJC5.1 GTEX.13O1R.1226.SM.5J1NU.1
    ## ENSG00000239474                     176115                     292168
    ## ENSG00000088882                       5705                      31825
    ## ENSG00000196616                     101967                     224828
    ## ENSG00000248713                     185491                     237230
    ## ENSG00000244694                       3519                       2316
    ## ENSG00000022267                    2142494                    2896820
    ##                 GTEX.13CF2.0226.SM.5L3DV.1 GTEX.1122O.0826.SM.5GICV.1
    ## ENSG00000239474                     312345                     459072
    ## ENSG00000088882                      22209                       7022
    ## ENSG00000196616                     382304                     534088
    ## ENSG00000248713                      75720                      49225
    ## ENSG00000244694                       6058                       1004
    ## ENSG00000022267                    5857194                    3412533
    ##                 GTEX.14C5O.1326.SM.5S2UW.1 GTEX.12WS9.0826.SM.59HJX.1
    ## ENSG00000239474                      26125                     144452
    ## ENSG00000088882                       2002                      44951
    ## ENSG00000196616                     324447                    3122262
    ## ENSG00000248713                        591                       7508
    ## ENSG00000244694                       4585                       1391
    ## ENSG00000022267                     447812                    1357532
    ##                 GTEX.11GSP.1326.SM.5A5KY.1 GTEX.1399S.1026.SM.5KLZ9.1
    ## ENSG00000239474                      32102                     756447
    ## ENSG00000088882                       9122                       7148
    ## ENSG00000196616                     101497                     582136
    ## ENSG00000248713                        845                       7756
    ## ENSG00000244694                       3880                        152
    ## ENSG00000022267                     775496                    5858339
    ##                 GTEX.1339X.0426.SM.5KLZY.1 GTEX.Y5V5.0726.SM.4VBPY.1
    ## ENSG00000239474                     954122                    382750
    ## ENSG00000088882                       5170                     18856
    ## ENSG00000196616                     204733                   1510442
    ## ENSG00000248713                      50189                     14105
    ## ENSG00000244694                        443                      2484
    ## ENSG00000022267                    6464080                   6154362
    ##                 GTEX.13FLV.0926.SM.5L3DZ.1 GTEX.14C38.1426.SM.5RQHZ.1
    ## ENSG00000239474                     277303                     361825
    ## ENSG00000088882                      32130                       7655
    ## ENSG00000196616                     339926                    1019819
    ## ENSG00000248713                       5116                      21382
    ## ENSG00000244694                       2083                       2664
    ## ENSG00000022267                    7001395                    4670998
    ##                 GTEX.117YW.0426.SM.5GZZZ.1 GTEX.ZZPT.0926.SM.5GICZ.1
    ## ENSG00000239474                      39616                    308654
    ## ENSG00000088882                       1956                       730
    ## ENSG00000196616                     282392                   6579731
    ## ENSG00000248713                        689                      3731
    ## ENSG00000244694                       1713                      3815
    ## ENSG00000022267                     621654                   1216195
    ##                 GTEX.11ZTT.0526.SM.5EQLA.1 GTEX.12WSK.0526.SM.5CVNA.1
    ## ENSG00000239474                     256432                     363586
    ## ENSG00000088882                      41379                       5568
    ## ENSG00000196616                    1041493                    2274919
    ## ENSG00000248713                       4585                      47960
    ## ENSG00000244694                       1066                       5317
    ## ENSG00000022267                    1122831                    2083047
    ##                 GTEX.1212Z.0626.SM.5FQTB.1 GTEX.ZAJG.0926.SM.5Q5AB.1
    ## ENSG00000239474                     104222                     90676
    ## ENSG00000088882                       4001                      7782
    ## ENSG00000196616                     212736                    812764
    ## ENSG00000248713                       1161                     11711
    ## ENSG00000244694                      10481                      1616
    ## ENSG00000022267                    2264727                   1224570
    ##                 GTEX.13NYS.1926.SM.5IJCB.1 GTEX.ZV7C.0526.SM.51MRB.1
    ## ENSG00000239474                     373735                    199694
    ## ENSG00000088882                        952                     11746
    ## ENSG00000196616                    4645022                    415644
    ## ENSG00000248713                       5542                     17311
    ## ENSG00000244694                       6500                      1588
    ## ENSG00000022267                    1410018                   1183971
    ##                 GTEX.13JUV.0226.SM.5IJCC.1 GTEX.11DXX.0326.SM.5PNWC.1
    ## ENSG00000239474                     172255                     454142
    ## ENSG00000088882                      10342                        785
    ## ENSG00000196616                    1729957                     167603
    ## ENSG00000248713                     262735                       9444
    ## ENSG00000244694                       2505                       2751
    ## ENSG00000022267                    4627183                    1483377
    ##                 GTEX.13O3O.1526.SM.5KM1C.1 GTEX.11TUW.1026.SM.5GU7D.1
    ## ENSG00000239474                     183325                     395704
    ## ENSG00000088882                       2035                      51729
    ## ENSG00000196616                     229722                     106453
    ## ENSG00000248713                       2161                     218712
    ## ENSG00000244694                        907                       4680
    ## ENSG00000022267                    1881067                    2837283
    ##                 GTEX.13U4I.0826.SM.5SIBD.1 GTEX.13VXT.0726.SM.5SIAD.1
    ## ENSG00000239474                     719565                     132639
    ## ENSG00000088882                       6731                      12605
    ## ENSG00000196616                     273232                    1063596
    ## ENSG00000248713                       6186                       6764
    ## ENSG00000244694                       2332                        286
    ## ENSG00000022267                    4989125                     755719
    ##                 GTEX.11GS4.0426.SM.5N9CD.1 GTEX.13X6H.0426.SM.5LU4E.1
    ## ENSG00000239474                      75527                     560235
    ## ENSG00000088882                      20698                       4284
    ## ENSG00000196616                     823319                     736614
    ## ENSG00000248713                       2001                       3244
    ## ENSG00000244694                       4166                       1103
    ## ENSG00000022267                    1830851                    1178872
    ##                 GTEX.YB5K.0226.SM.5IFJE.1 GTEX.ZVT4.1326.SM.5NQ8E.1
    ## ENSG00000239474                    485123                    131375
    ## ENSG00000088882                     24465                    150643
    ## ENSG00000196616                    728786                    728067
    ## ENSG00000248713                      8652                    708759
    ## ENSG00000244694                      1670                      2005
    ## ENSG00000022267                    900339                   4589390
    ##                 GTEX.ZYVF.1826.SM.5E44F.1 GTEX.146FH.1026.SM.5RQIF.1
    ## ENSG00000239474                    220715                     594303
    ## ENSG00000088882                     17891                       1769
    ## ENSG00000196616                   1414337                     721493
    ## ENSG00000248713                      4189                      12006
    ## ENSG00000244694                      1628                       5727
    ## ENSG00000022267                    738548                    4818282
    ##                 GTEX.ZT9W.0526.SM.57WFG.1 GTEX.139YR.0526.SM.5L3DG.1
    ## ENSG00000239474                    364244                     251237
    ## ENSG00000088882                      8675                       7647
    ## ENSG00000196616                   2359429                    1400996
    ## ENSG00000248713                     20065                       9879
    ## ENSG00000244694                      2027                       3076
    ## ENSG00000022267                   2248454                    1005498
    ##                 GTEX.14BIM.2726.SM.5Q5EG.1 GTEX.145LV.0226.SM.5S2QG.1
    ## ENSG00000239474                     193731                     225024
    ## ENSG00000088882                       3594                       4841
    ## ENSG00000196616                    1144328                     982785
    ## ENSG00000248713                      18005                       1678
    ## ENSG00000244694                       1602                       2425
    ## ENSG00000022267                    3109590                     605633
    ##                 GTEX.145MN.0626.SM.5QGRH.1 GTEX.12WSG.0526.SM.5FQTH.1
    ## ENSG00000239474                     993925                     868902
    ## ENSG00000088882                      10326                      12833
    ## ENSG00000196616                     141918                     415642
    ## ENSG00000248713                     325779                     162205
    ## ENSG00000244694                       1119                       2456
    ## ENSG00000022267                   22335238                    5363354
    ##                 GTEX.13CF2.0426.SM.5KM1H.1 GTEX.13OW7.1626.SM.5IJDH.1
    ## ENSG00000239474                      68884                     312912
    ## ENSG00000088882                       9070                      17151
    ## ENSG00000196616                     111444                     516608
    ## ENSG00000248713                       2215                      18742
    ## ENSG00000244694                       8108                       1782
    ## ENSG00000022267                     823262                    3112735
    ##                 GTEX.117YX.0626.SM.5EGJI.1 GTEX.13PL6.0826.SM.5IJBI.1
    ## ENSG00000239474                    1067862                      80682
    ## ENSG00000088882                      50748                      30773
    ## ENSG00000196616                    1227998                    1019818
    ## ENSG00000248713                       8418                     284790
    ## ENSG00000244694                        630                        846
    ## ENSG00000022267                    2649744                    6877196
    ##                 GTEX.11WQK.0226.SM.5EQLI.1 GTEX.11TUW.1126.SM.5EQKJ.1
    ## ENSG00000239474                     507250                     341765
    ## ENSG00000088882                       9761                      49182
    ## ENSG00000196616                      35374                     231178
    ## ENSG00000248713                    2383202                     102517
    ## ENSG00000244694                        374                       4935
    ## ENSG00000022267                    7145604                    2548390
    ##                 GTEX.12WSK.0626.SM.5LZUJ.1 GTEX.13S86.0226.SM.5S2PJ.1
    ## ENSG00000239474                     813984                    1597369
    ## ENSG00000088882                      18240                        964
    ## ENSG00000196616                     795138                      21566
    ## ENSG00000248713                     767113                     494078
    ## ENSG00000244694                       3553                       1625
    ## ENSG00000022267                   22535513                    4765660
    ##                 GTEX.YFC4.0426.SM.4TT3J.1 GTEX.13PVQ.1326.SM.5LU4J.1
    ## ENSG00000239474                    306309                     647069
    ## ENSG00000088882                     21865                       7144
    ## ENSG00000196616                   1347632                     218323
    ## ENSG00000248713                      5310                     158407
    ## ENSG00000244694                      3302                        152
    ## ENSG00000022267                   4944870                    3963852
    ##                 GTEX.1399R.1726.SM.5K7YJ.1 GTEX.132NY.1726.SM.5EGKK.1
    ## ENSG00000239474                     403206                     451382
    ## ENSG00000088882                       4667                       5459
    ## ENSG00000196616                    1160992                     323393
    ## ENSG00000248713                      12482                       1008
    ## ENSG00000244694                       2445                       3305
    ## ENSG00000022267                    1167428                    2454519
    ##                 GTEX.ZYWO.0626.SM.5E45K.1 GTEX.ZLFU.0326.SM.4WWBK.1
    ## ENSG00000239474                    693849                    356191
    ## ENSG00000088882                     21228                       551
    ## ENSG00000196616                   2543128                    473691
    ## ENSG00000248713                     24379                      4530
    ## ENSG00000244694                       144                       371
    ## ENSG00000022267                  11651690                   5475590
    ##                 GTEX.ZDTT.0726.SM.4WKFK.1 GTEX.1314G.0126.SM.5LZUL.1
    ## ENSG00000239474                   1046447                     105480
    ## ENSG00000088882                      7810                       4766
    ## ENSG00000196616                    903347                     381233
    ## ENSG00000248713                     12308                       2034
    ## ENSG00000244694                      2388                       1515
    ## ENSG00000022267                  13479587                    1455304
    ##                 GTEX.13U4I.0626.SM.5LU5L.1 GTEX.ZDTS.1226.SM.4WKGL.1
    ## ENSG00000239474                     483716                    463334
    ## ENSG00000088882                      22692                      5996
    ## ENSG00000196616                    1135502                    390817
    ## ENSG00000248713                       8310                     10058
    ## ENSG00000244694                       3565                      3816
    ## ENSG00000022267                    1712703                   2980629
    ##                 GTEX.ZGAY.0226.SM.4WWAL.1 GTEX.ZYT6.0926.SM.5GIEM.1
    ## ENSG00000239474                    411379                    438564
    ## ENSG00000088882                     28065                     64771
    ## ENSG00000196616                   5365960                   1773334
    ## ENSG00000248713                     14776                      6472
    ## ENSG00000244694                       878                      1293
    ## ENSG00000022267                   1373545                   1631395
    ##                 GTEX.13JVG.1126.SM.5KM2M.1 GTEX.ZG7Y.1426.SM.4WWBM.1
    ## ENSG00000239474                     268028                    381437
    ## ENSG00000088882                       5384                      8313
    ## ENSG00000196616                     557497                   6755259
    ## ENSG00000248713                      32638                     74897
    ## ENSG00000244694                       1130                      2458
    ## ENSG00000022267                    1248104                   2697710
    ##                 GTEX.1399U.0526.SM.5K7YM.1 GTEX.ZYFG.0426.SM.5E43M.1
    ## ENSG00000239474                     357249                    713824
    ## ENSG00000088882                       1493                      4390
    ## ENSG00000196616                    1121708                    809807
    ## ENSG00000248713                       2875                      4387
    ## ENSG00000244694                       2461                      2561
    ## ENSG00000022267                    2490056                   3134954
    ##                 GTEX.12584.0926.SM.5FQTN.1 GTEX.ZF29.0426.SM.4WKFN.1
    ## ENSG00000239474                      73573                    403267
    ## ENSG00000088882                        613                      1327
    ## ENSG00000196616                     563118                   2535920
    ## ENSG00000248713                       4289                     26063
    ## ENSG00000244694                       2177                       887
    ## ENSG00000022267                    1829429                   1436931
    ##                 GTEX.13RTJ.0726.SM.5QGQN.1 GTEX.ZG7Y.0926.SM.5EQ6O.1
    ## ENSG00000239474                      99401                   1394024
    ## ENSG00000088882                       4434                      1082
    ## ENSG00000196616                     677761                    491942
    ## ENSG00000248713                       1900                    361991
    ## ENSG00000244694                        617                      3337
    ## ENSG00000022267                     822155                  18969149
    ##                 GTEX.111FC.0826.SM.5GZWO.1 GTEX.ZTPG.1226.SM.4YCDO.1
    ## ENSG00000239474                     315239                    772296
    ## ENSG00000088882                      21736                      5484
    ## ENSG00000196616                     658242                    154612
    ## ENSG00000248713                      15600                     41096
    ## ENSG00000244694                       1138                       152
    ## ENSG00000022267                    2848950                   9357548
    ##                 GTEX.ZF29.0226.SM.4WKHO.1 GTEX.ZPU1.0726.SM.5HL6O.1
    ## ENSG00000239474                    847447                    306638
    ## ENSG00000088882                      3767                     18718
    ## ENSG00000196616                    718557                   1600167
    ## ENSG00000248713                     16810                      8507
    ## ENSG00000244694                      1295                      2318
    ## ENSG00000022267                   4399367                   1782438
    ##                 GTEX.145LS.1326.SM.5Q5EP.1 GTEX.ZYT6.1726.SM.5E44P.1
    ## ENSG00000239474                     410710                     32226
    ## ENSG00000088882                     109481                     28606
    ## ENSG00000196616                     212319                    390925
    ## ENSG00000248713                     202690                       484
    ## ENSG00000244694                       5734                       617
    ## ENSG00000022267                    8485695                    409959
    ##                 GTEX.13N11.0726.SM.5L3DP.1 GTEX.ZV7C.0326.SM.57WB1.1
    ## ENSG00000239474                     364357                    670813
    ## ENSG00000088882                      29647                       843
    ## ENSG00000196616                    3659007                    519929
    ## ENSG00000248713                      22381                      2520
    ## ENSG00000244694                       1863                      1955
    ## ENSG00000022267                    3268680                   3756373
    ##                 GTEX.12ZZY.1126.SM.5DUWQ.1 GTEX.13D11.1726.SM.5IFGQ.1
    ## ENSG00000239474                      75251                     683728
    ## ENSG00000088882                      12319                       5963
    ## ENSG00000196616                     129039                     525328
    ## ENSG00000248713                       1447                       2188
    ## ENSG00000244694                       3082                        664
    ## ENSG00000022267                     752292                    3320750
    ##                 GTEX.YEC3.0726.SM.4YCD1.1 GTEX.YEC3.0426.SM.5IFK1.1
    ## ENSG00000239474                    899677                    499773
    ## ENSG00000088882                     13245                     12780
    ## ENSG00000196616                    533819                   1924064
    ## ENSG00000248713                      5095                     13070
    ## ENSG00000244694                      3233                      2710
    ## ENSG00000022267                   2900764                   1315576
    ##                 GTEX.11EQ8.1326.SM.5EGJQ.1 GTEX.13OVI.0326.SM.5K7X1.1
    ## ENSG00000239474                     412209                     293988
    ## ENSG00000088882                       6949                       2486
    ## ENSG00000196616                    1931809                    1604089
    ## ENSG00000248713                       2487                       5354
    ## ENSG00000244694                        901                       1456
    ## ENSG00000022267                    1739448                    7156334
    ##                 GTEX.ZF2S.1026.SM.4WWB1.1 GTEX.11ZVC.0526.SM.5N9G1.1
    ## ENSG00000239474                    622760                      22367
    ## ENSG00000088882                     22200                      69785
    ## ENSG00000196616                     68154                    2020545
    ## ENSG00000248713                     28507                       1385
    ## ENSG00000244694                       873                       3156
    ## ENSG00000022267                   6526618                    1747392
    ##                 GTEX.12WSD.1226.SM.5HL9Q.1 GTEX.11DXZ.0326.SM.5EGH1.1
    ## ENSG00000239474                     233959                     323938
    ## ENSG00000088882                       2616                        462
    ## ENSG00000196616                     564022                    1465352
    ## ENSG00000248713                       3931                       4348
    ## ENSG00000244694                       1034                       1641
    ## ENSG00000022267                    2660493                    1017841
    ##                 GTEX.13FH7.0926.SM.5J2MR.1 GTEX.1192X.0726.SM.5987R.1
    ## ENSG00000239474                    1105396                     241295
    ## ENSG00000088882                       7973                       1154
    ## ENSG00000196616                     576361                    6545888
    ## ENSG00000248713                     476040                      29017
    ## ENSG00000244694                         85                       3478
    ## ENSG00000022267                   18897056                    6243964
    ##                 GTEX.13FHP.1026.SM.5K7Y2.1 GTEX.11DXX.0526.SM.5PNVR.1
    ## ENSG00000239474                      14514                     267454
    ## ENSG00000088882                       1781                       4576
    ## ENSG00000196616                     180351                     617523
    ## ENSG00000248713                        152                      84542
    ## ENSG00000244694                        673                       2163
    ## ENSG00000022267                     303492                    1852788
    ##                 GTEX.Y8E4.0326.SM.4VBRR.1 GTEX.13X6K.1826.SM.5O9CR.1
    ## ENSG00000239474                    750635                     152238
    ## ENSG00000088882                     13708                      20132
    ## ENSG00000196616                    415442                     603748
    ## ENSG00000248713                      4407                       3734
    ## ENSG00000244694                      4140                       3367
    ## ENSG00000022267                   2607143                    2356134
    ##                 GTEX.13112.0526.SM.5EQ4S.1 GTEX.14A5I.1026.SM.5Q5E3.1
    ## ENSG00000239474                     202047                     118289
    ## ENSG00000088882                       7851                      16297
    ## ENSG00000196616                    1196631                    4930272
    ## ENSG00000248713                       4091                      10578
    ## ENSG00000244694                       3785                       2655
    ## ENSG00000022267                    2406411                    2845223
    ##                 GTEX.YJ8O.0826.SM.5CVM3.1 GTEX.ZVZP.0226.SM.5NQ73.1
    ## ENSG00000239474                    165996                    561370
    ## ENSG00000088882                     21913                      1530
    ## ENSG00000196616                   3086460                    589944
    ## ENSG00000248713                      5326                      5805
    ## ENSG00000244694                      1105                      1003
    ## ENSG00000022267                   2622700                   2182123
    ##                 GTEX.12584.1026.SM.59HK3.1 GTEX.11NV4.0826.SM.5BC4S.1
    ## ENSG00000239474                      58871                     416683
    ## ENSG00000088882                      16278                       4489
    ## ENSG00000196616                    2755089                    1732598
    ## ENSG00000248713                      33688                      26199
    ## ENSG00000244694                       3758                       3230
    ## ENSG00000022267                    3251252                    4191868
    ##                 GTEX.13NZA.0826.SM.5K7WS.1 GTEX.ZDXO.0726.SM.57WBT.1
    ## ENSG00000239474                      70051                    320976
    ## ENSG00000088882                      13060                      9385
    ## ENSG00000196616                    1317565                    269973
    ## ENSG00000248713                       1481                      2540
    ## ENSG00000244694                       3660                      3077
    ## ENSG00000022267                    2325042                   2984704
    ##                 GTEX.13QBU.0426.SM.5J2O4.1 GTEX.132AR.2026.SM.5IJG4.1
    ## ENSG00000239474                     375893                     395556
    ## ENSG00000088882                       2152                       4721
    ## ENSG00000196616                     915560                     158518
    ## ENSG00000248713                      18919                      31616
    ## ENSG00000244694                        521                        303
    ## ENSG00000022267                    4384027                    8743164
    ##                 GTEX.146FH.1126.SM.5NQAT.1 GTEX.12WSA.1126.SM.5EGKU.1
    ## ENSG00000239474                     307329                     182894
    ## ENSG00000088882                      18543                       2194
    ## ENSG00000196616                    2169639                    2171542
    ## ENSG00000248713                       9778                       1138
    ## ENSG00000244694                       4362                       2202
    ## ENSG00000022267                    1554420                     984939
    ##                 GTEX.ZVT2.1026.SM.5GU55.1 GTEX.14E7W.1226.SM.5RQIU.1
    ## ENSG00000239474                    545913                      21269
    ## ENSG00000088882                     17295                       5160
    ## ENSG00000196616                    515217                      42178
    ## ENSG00000248713                      6478                        295
    ## ENSG00000244694                      2066                       5003
    ## ENSG00000022267                   4766612                     456630
    ##                 GTEX.148VJ.1526.SM.5Q5DU.1 GTEX.ZGAY.0326.SM.57WF5.1
    ## ENSG00000239474                      23194                   1157169
    ## ENSG00000088882                       3708                      4976
    ## ENSG00000196616                     143015                    357840
    ## ENSG00000248713                       2317                    986741
    ## ENSG00000244694                        297                      3773
    ## ENSG00000022267                     533836                  26266931
    ##                 GTEX.132AR.1926.SM.5EGK5.1 GTEX.13FTZ.0226.SM.5K7X6.1
    ## ENSG00000239474                     472733                      82607
    ## ENSG00000088882                       7516                      11118
    ## ENSG00000196616                     548969                     329180
    ## ENSG00000248713                      57091                       1550
    ## ENSG00000244694                        152                       3901
    ## ENSG00000022267                    4343375                     977506
    ##                 GTEX.132QS.0426.SM.5KLZ6.1 GTEX.14E6D.0926.SM.5S2QV.1
    ## ENSG00000239474                    1193136                      34136
    ## ENSG00000088882                       1941                      11301
    ## ENSG00000196616                     201354                     452624
    ## ENSG00000248713                      17840                          0
    ## ENSG00000244694                        593                        684
    ## ENSG00000022267                   13509985                     505138
    ##                 GTEX.ZDXO.0426.SM.4WKF6.1 GTEX.11DXY.1026.SM.5987V.1
    ## ENSG00000239474                    222496                     261182
    ## ENSG00000088882                     84288                      22268
    ## ENSG00000196616                    816328                     809530
    ## ENSG00000248713                     54162                       1981
    ## ENSG00000244694                      1633                       2258
    ## ENSG00000022267                   2978652                    3178690
    ##                 GTEX.131YS.0826.SM.5PNYV.1 GTEX.148VI.0326.SM.5RQK7.1
    ## ENSG00000239474                     602782                     164855
    ## ENSG00000088882                      12910                      13526
    ## ENSG00000196616                    1431668                     233134
    ## ENSG00000248713                      10183                       1152
    ## ENSG00000244694                       3595                        249
    ## ENSG00000022267                    3927428                    1569717
    ##                 GTEX.11NUK.0926.SM.5HL57.1 GTEX.145LV.0326.SM.5Q5BW.1
    ## ENSG00000239474                     190263                     353376
    ## ENSG00000088882                      41768                        853
    ## ENSG00000196616                    2366794                     208030
    ## ENSG00000248713                       3063                       4282
    ## ENSG00000244694                       1325                       1412
    ## ENSG00000022267                    2491722                    1370425
    ##                 GTEX.13PVR.1026.SM.5QGQW.1 GTEX.11ZUS.0326.SM.5EQ4W.1
    ## ENSG00000239474                     454376                     184799
    ## ENSG00000088882                       2665                      22793
    ## ENSG00000196616                     460552                     639109
    ## ENSG00000248713                      69460                      13876
    ## ENSG00000244694                        265                       1331
    ## ENSG00000022267                    7513073                    2029970
    ##                 GTEX.ZZPU.1126.SM.5N9CW.1 GTEX.117YX.1126.SM.5H128.1
    ## ENSG00000239474                    254121                     635496
    ## ENSG00000088882                     21753                        288
    ## ENSG00000196616                   4556073                     341553
    ## ENSG00000248713                     41578                       3652
    ## ENSG00000244694                      5680                       1273
    ## ENSG00000022267                   3466477                    3445295
    ##                 GTEX.11ZUS.0226.SM.5FQT8.1 GTEX.ZYFG.0526.SM.5GZXX.1
    ## ENSG00000239474                     316340                    411936
    ## ENSG00000088882                      16505                      6583
    ## ENSG00000196616                     155370                   1199625
    ## ENSG00000248713                       4953                      9700
    ## ENSG00000244694                       2045                      3089
    ## ENSG00000022267                    2252900                   1216768
    ##                 GTEX.1399R.1926.SM.5K7X8.1 GTEX.145MO.1126.SM.5NQBX.1
    ## ENSG00000239474                     493966                      86191
    ## ENSG00000088882                       1329                       5991
    ## ENSG00000196616                     298081                     237779
    ## ENSG00000248713                       3698                       1875
    ## ENSG00000244694                       4181                       3159
    ## ENSG00000022267                    4743696                    1248630
    ##                 GTEX.1339X.0326.SM.5K7Z8.1 GTEX.13QBU.0226.SM.5LU48.1
    ## ENSG00000239474                     351396                     570613
    ## ENSG00000088882                       2635                       5377
    ## ENSG00000196616                     425050                    1386234
    ## ENSG00000248713                      14592                    4039652
    ## ENSG00000244694                       1174                          0
    ## ENSG00000022267                    2025256                    5366537
    ##                 GTEX.14A6H.0226.SM.5Q5DX.1 GTEX.147F4.1226.SM.5NQAY.1
    ## ENSG00000239474                     609619                      32509
    ## ENSG00000088882                      51045                       1622
    ## ENSG00000196616                     449070                     168972
    ## ENSG00000248713                       3551                        817
    ## ENSG00000244694                       1340                       1107
    ## ENSG00000022267                    4294973                     505124
    ##                 GTEX.13CF3.0726.SM.5J2MY.1 GTEX.13PDP.1326.SM.5K7U9.1
    ## ENSG00000239474                    1063042                      99000
    ## ENSG00000088882                       8907                       1631
    ## ENSG00000196616                     381642                     888315
    ## ENSG00000248713                     126371                      13004
    ## ENSG00000244694                       2215                       2422
    ## ENSG00000022267                   17917840                    2108658
    ##                 GTEX.13OW5.0926.SM.5L3GZ.1 GTEX.13X6I.1426.SM.5SI9Z.1
    ## ENSG00000239474                     168962                     179840
    ## ENSG00000088882                       2699                      11461
    ## ENSG00000196616                     217906                    2762505
    ## ENSG00000248713                     117697                       2128
    ## ENSG00000244694                       5243                       6194
    ## ENSG00000022267                    4126669                     916642
    ##                 GTEX.13CF3.0826.SM.5LZYZ.1 GTEX.11EM3.0426.SM.5N9BZ.1
    ## ENSG00000239474                      28214                     349771
    ## ENSG00000088882                     427711                      24119
    ## ENSG00000196616                    4790959                    2015217
    ## ENSG00000248713                       2594                      20145
    ## ENSG00000244694                       7369                        811
    ## ENSG00000022267                    2850103                    1205174
    ##                 GTEX.1211K.0626.SM.5FQUZ.1 GTEX.11GS4.0526.SM.5A5KQ.1
    ## ENSG00000239474                     816427                     123620
    ## ENSG00000088882                       1386                      44964
    ## ENSG00000196616                     292773                     180721
    ## ENSG00000248713                     212051                       3593
    ## ENSG00000244694                        701                       3609
    ## ENSG00000022267                   11632768                    2061582
    ##                 GTEX.ZTPG.1326.SM.51MSQ.1 GTEX.146FR.0626.SM.5RQJ1.1
    ## ENSG00000239474                    404482                    1077588
    ## ENSG00000088882                     25172                       1511
    ## ENSG00000196616                   1028091                     515628
    ## ENSG00000248713                     28113                       9839
    ## ENSG00000244694                      1276                       2054
    ## ENSG00000022267                   3219368                    7243214
    ##                 GTEX.13YAN.1326.SM.5Q5F1.1 GTEX.13O61.0526.SM.5J2M1.1
    ## ENSG00000239474                     113125                     466562
    ## ENSG00000088882                        582                       1368
    ## ENSG00000196616                     381522                    1324066
    ## ENSG00000248713                       2349                      10147
    ## ENSG00000244694                        774                       3264
    ## ENSG00000022267                     338502                    5234775
    ##                 GTEX.11ILO.2526.SM.5A5LQ.1 GTEX.12BJ1.0226.SM.5LUA2.1
    ## ENSG00000239474                     262290                     450094
    ## ENSG00000088882                       5201                       1872
    ## ENSG00000196616                    1204311                     467904
    ## ENSG00000248713                       3737                       3584
    ## ENSG00000244694                       2123                        441
    ## ENSG00000022267                    3282337                    1779235
    ##                 GTEX.144GL.1026.SM.5O99R.1 GTEX.13FTW.0826.SM.5K7XR.1
    ## ENSG00000239474                     520419                     318291
    ## ENSG00000088882                       8684                       6560
    ## ENSG00000196616                     329609                    1584761
    ## ENSG00000248713                       9992                    3400790
    ## ENSG00000244694                        751                       1815
    ## ENSG00000022267                    2343480                   12652431
    ##                 GTEX.139UC.0426.SM.5K7UR.1 GTEX.13OW5.1126.SM.5J1NR.1
    ## ENSG00000239474                      62734                      23985
    ## ENSG00000088882                       3115                       1905
    ## ENSG00000196616                     448353                     130512
    ## ENSG00000248713                        886                       2851
    ## ENSG00000244694                       2631                       3133
    ## ENSG00000022267                    1483999                     385160
    ##                 GTEX.YB5K.0126.SM.5IFJ2.1 GTEX.11EMC.0826.SM.59862.1
    ## ENSG00000239474                    598420                     157546
    ## ENSG00000088882                      8035                       6952
    ## ENSG00000196616                     32243                    1999779
    ## ENSG00000248713                   2405910                       3276
    ## ENSG00000244694                      2478                       2773
    ## ENSG00000022267                  34121453                    1794613
    ##                 GTEX.131XF.0326.SM.5DUVR.1 GTEX.132Q8.1126.SM.5K7XS.1
    ## ENSG00000239474                     362406                     287714
    ## ENSG00000088882                       1393                       7600
    ## ENSG00000196616                     188273                    4614109
    ## ENSG00000248713                       5671                      32731
    ## ENSG00000244694                       2262                       3189
    ## ENSG00000022267                    4534082                    6442347
    ##                 GTEX.13FTW.1026.SM.5L3E3.1 GTEX.13PL7.0726.SM.5KM1S.1
    ## ENSG00000239474                     770801                     275660
    ## ENSG00000088882                       4039                       1203
    ## ENSG00000196616                     653611                    1522541
    ## ENSG00000248713                      21019                      10848
    ## ENSG00000244694                       1170                        735
    ## ENSG00000022267                    7156695                    2116898
    ##                 GTEX.ZEX8.0326.SM.4WKGS.1 GTEX.1399S.0826.SM.5KM23.1
    ## ENSG00000239474                    285092                     349912
    ## ENSG00000088882                    116182                       1642
    ## ENSG00000196616                   1147612                    1071713
    ## ENSG00000248713                      7055                      27519
    ## ENSG00000244694                      1827                        134
    ## ENSG00000022267                   2381962                    3362252
    ##                 GTEX.ZVZQ.0726.SM.51MR3.1 GTEX.13O3P.1626.SM.5K7X3.1
    ## ENSG00000239474                    166443                      80132
    ## ENSG00000088882                    144177                       5333
    ## ENSG00000196616                   1596684                     260393
    ## ENSG00000248713                      2488                       4251
    ## ENSG00000244694                      6740                       3080
    ## ENSG00000022267                   3869034                     464699
    ##                 GTEX.13OW8.2126.SM.5J1OS.1 GTEX.13O1R.0926.SM.5L3DS.1
    ## ENSG00000239474                      70607                     294069
    ## ENSG00000088882                       8311                       3832
    ## ENSG00000196616                     376434                     136335
    ## ENSG00000248713                       4682                       4180
    ## ENSG00000244694                       5602                        703
    ## ENSG00000022267                    1216742                    1008736
    ##                 GTEX.ZYW4.0926.SM.59HJS.1 GTEX.13O3O.1426.SM.5KM2S.1
    ## ENSG00000239474                     63048                     179667
    ## ENSG00000088882                     12279                      67291
    ## ENSG00000196616                    621859                    2619621
    ## ENSG00000248713                      1912                     145150
    ## ENSG00000244694                      2000                       3668
    ## ENSG00000022267                   1429877                    2969493
    ##                 GTEX.13O61.0426.SM.5L3ET.1 GTEX.Z93S.0326.SM.5HL84.1
    ## ENSG00000239474                      76416                    280252
    ## ENSG00000088882                        951                     12594
    ## ENSG00000196616                    2177532                   2156530
    ## ENSG00000248713                      83297                      2228
    ## ENSG00000244694                        664                      9427
    ## ENSG00000022267                    3785731                   1826939
    ##                 GTEX.11ONC.1026.SM.5GU64.1 GTEX.ZAB4.1026.SM.5HL7T.1
    ## ENSG00000239474                     109805                    240845
    ## ENSG00000088882                       4588                      6005
    ## ENSG00000196616                     242501                   1646906
    ## ENSG00000248713                       6655                      2207
    ## ENSG00000244694                       9123                      2267
    ## ENSG00000022267                    2386278                   1744073
    ##                 GTEX.ZAB4.0926.SM.5CVN4.1 GTEX.ZZPU.0926.SM.5GZYT.1
    ## ENSG00000239474                    409070                    320427
    ## ENSG00000088882                      6270                      6730
    ## ENSG00000196616                   1305537                   1556849
    ## ENSG00000248713                      8391                      3346
    ## ENSG00000244694                      1737                       804
    ## ENSG00000022267                   4138388                   2218196
    ##                 GTEX.131XE.0526.SM.5K7YT.1 GTEX.ZAB5.0126.SM.5CVMT.1
    ## ENSG00000239474                     146578                    342833
    ## ENSG00000088882                       5009                      7217
    ## ENSG00000196616                     428937                   3474944
    ## ENSG00000248713                      37589                      6860
    ## ENSG00000244694                        823                      3029
    ## ENSG00000022267                    3337622                   1663471
    ##                 GTEX.13NYB.0226.SM.5N9G4.1 GTEX.1313W.1426.SM.5KLZU.1
    ## ENSG00000239474                       3717                     326153
    ## ENSG00000088882                       2704                      67139
    ## ENSG00000196616                      38649                     790121
    ## ENSG00000248713                        148                       2622
    ## ENSG00000244694                       1162                       3130
    ## ENSG00000022267                     221639                    2208213
    ##                 GTEX.12ZZZ.1726.SM.59HK5.1 GTEX.ZAK1.1126.SM.5PNXU.1
    ## ENSG00000239474                     230847                    611783
    ## ENSG00000088882                       7881                     37386
    ## ENSG00000196616                     955298                   3636735
    ## ENSG00000248713                       1844                     22319
    ## ENSG00000244694                       3307                      2390
    ## ENSG00000022267                    1675728                   4503198
    ##                 GTEX.1313W.1126.SM.5EQ5U.1 GTEX.1212Z.0726.SM.5EGI5.1
    ## ENSG00000239474                     256402                     180257
    ## ENSG00000088882                     167692                       4402
    ## ENSG00000196616                    1308003                     136532
    ## ENSG00000248713                       2055                       7389
    ## ENSG00000244694                       3111                       7331
    ## ENSG00000022267                    2005522                    2892692
    ##                 GTEX.13FHP.0826.SM.5K7V5.1 GTEX.111FC.0626.SM.5N9CU.1
    ## ENSG00000239474                     213910                     312805
    ## ENSG00000088882                      27915                      37129
    ## ENSG00000196616                    2614227                    1739255
    ## ENSG00000248713                       8108                      10016
    ## ENSG00000244694                       2677                       1285
    ## ENSG00000022267                    3637139                    1732253
    ##                 GTEX.Y5V6.0826.SM.4VBRU.1 GTEX.131XF.0426.SM.5HL7U.1
    ## ENSG00000239474                   1022354                     209562
    ## ENSG00000088882                      9746                       1784
    ## ENSG00000196616                    510105                     872476
    ## ENSG00000248713                      3525                      13311
    ## ENSG00000244694                      1354                        881
    ## ENSG00000022267                   4934262                    1749129
    ##                 GTEX.ZXG5.0626.SM.5NQ85.1 GTEX.ZTTD.0526.SM.57WDV.1
    ## ENSG00000239474                     26597                      8523
    ## ENSG00000088882                     11002                     19948
    ## ENSG00000196616                   2315572                   8538300
    ## ENSG00000248713                      1621                      1595
    ## ENSG00000244694                      7103                      5578
    ## ENSG00000022267                   1369275                   6611857
    ##                 GTEX.11UD2.0926.SM.5CVL6.1 GTEX.13NZ9.0126.SM.5K7XV.1
    ## ENSG00000239474                     585547                     471652
    ## ENSG00000088882                       5079                       4275
    ## ENSG00000196616                     216618                     801133
    ## ENSG00000248713                      75070                     114557
    ## ENSG00000244694                       1405                       5046
    ## ENSG00000022267                    2235736                    2970457
    ##                 GTEX.13N1W.0926.SM.5MR36.1 GTEX.13NZB.0426.SM.5KM26.1
    ## ENSG00000239474                     326425                     584764
    ## ENSG00000088882                      30523                      13420
    ## ENSG00000196616                    1033515                    1141934
    ## ENSG00000248713                      26755                     260392
    ## ENSG00000244694                       2405                       1085
    ## ENSG00000022267                    4065716                    2880222
    ##                 GTEX.11ONC.0126.SM.5PNW6.1 GTEX.YEC4.0326.SM.4W216.1
    ## ENSG00000239474                      59023                   2287584
    ## ENSG00000088882                      24233                      3766
    ## ENSG00000196616                     307689                    248955
    ## ENSG00000248713                       9811                    173733
    ## ENSG00000244694                       9868                      2624
    ## ENSG00000022267                    1155530                  28518290
    ##                 GTEX.132QS.0526.SM.5IJC7.1 GTEX.13FH7.0826.SM.5J2NW.1
    ## ENSG00000239474                     637847                     389482
    ## ENSG00000088882                       8679                       8165
    ## ENSG00000196616                     558709                    1077768
    ## ENSG00000248713                      11203                      36579
    ## ENSG00000244694                       1893                        139
    ## ENSG00000022267                    8181022                     906142
    ##                 GTEX.14A5I.1226.SM.5NQBW.1 GTEX.111VG.0326.SM.5GZX7.1
    ## ENSG00000239474                       7434                     142994
    ## ENSG00000088882                       1034                       9202
    ## ENSG00000196616                     188665                    1571247
    ## ENSG00000248713                        108                       3613
    ## ENSG00000244694                        302                       3014
    ## ENSG00000022267                     154380                    3375601
    ##                 GTEX.ZYW4.1026.SM.5SI8W.1 GTEX.YEC3.0726.SM.5IFIW.1
    ## ENSG00000239474                      6931                    659568
    ## ENSG00000088882                    324532                      3340
    ## ENSG00000196616                   3568911                    398939
    ## ENSG00000248713                       152                      5211
    ## ENSG00000244694                      3066                      2067
    ## ENSG00000022267                   3306998                   2954213
    ##                 GTEX.13SLW.0826.SM.5QGP7.1 GTEX.ZYFC.1126.SM.5E44W.1
    ## ENSG00000239474                     157666                    235396
    ## ENSG00000088882                       2313                     15603
    ## ENSG00000196616                    1397323                    254667
    ## ENSG00000248713                     233196                      2780
    ## ENSG00000244694                       2270                      1104
    ## ENSG00000022267                    4243336                   1323216
    ##                 GTEX.11DXZ.0626.SM.5GU77.1 GTEX.ZDYS.0326.SM.5HL4W.1
    ## ENSG00000239474                     441953                    244825
    ## ENSG00000088882                       3948                      5536
    ## ENSG00000196616                     326025                   1919359
    ## ENSG00000248713                       4336                     45287
    ## ENSG00000244694                       1459                       291
    ## ENSG00000022267                    3534497                   1126119
    ##                 GTEX.ZVT3.0826.SM.5GIC8.1 GTEX.131XE.0626.SM.5HL98.1
    ## ENSG00000239474                    353194                     312322
    ## ENSG00000088882                      5210                       1385
    ## ENSG00000196616                    884359                     151164
    ## ENSG00000248713                     23083                       2339
    ## ENSG00000244694                      2162                       2948
    ## ENSG00000022267                   1745546                    3043823
    ##                 GTEX.12WSE.0926.SM.5S2VX.1 GTEX.13JVG.1326.SM.5N9F8.1
    ## ENSG00000239474                     422826                       7837
    ## ENSG00000088882                      47551                       2139
    ## ENSG00000196616                    3549006                     180968
    ## ENSG00000248713                      12514                        928
    ## ENSG00000244694                        972                       1821
    ## ENSG00000022267                    2034905                     462182
    ##                 GTEX.Y5V5.0626.SM.4VBPX.1 GTEX.13W3W.0526.SM.5LU3X.1
    ## ENSG00000239474                    237830                     244837
    ## ENSG00000088882                      3244                      19620
    ## ENSG00000196616                    669982                    2327448
    ## ENSG00000248713                     12575                     177431
    ## ENSG00000244694                      5405                        394
    ## ENSG00000022267                   3751075                    2296955
    ##                 GTEX.ZDTS.1326.SM.4WKGX.1 GTEX.13O21.2326.SM.5MR3X.1
    ## ENSG00000239474                    220099                     416342
    ## ENSG00000088882                      2849                       3856
    ## ENSG00000196616                    283445                     292207
    ## ENSG00000248713                      1875                       2796
    ## ENSG00000244694                      1451                       1594
    ## ENSG00000022267                   2753523                    1599614
    ##                 GTEX.ZYFD.2026.SM.5E459.1 GTEX.13O21.0326.SM.5J1N9.1
    ## ENSG00000239474                    302200                     356574
    ## ENSG00000088882                     43550                       6985
    ## ENSG00000196616                    157935                    2184125
    ## ENSG00000248713                     54220                     491913
    ## ENSG00000244694                      1014                       4836
    ## ENSG00000022267                    884154                    3305648
    ##                 GTEX.1211K.0226.SM.59HJY.1 GTEX.ZUA1.0726.SM.4YCD9.1
    ## ENSG00000239474                     491567                    106073
    ## ENSG00000088882                      11607                     30013
    ## ENSG00000196616                    1903305                   2853118
    ## ENSG00000248713                      19422                      2543
    ## ENSG00000244694                        819                      5245
    ## ENSG00000022267                    1542288                   3156305
    ##                 GTEX.139YR.0826.SM.5LZXY.1 GTEX.117YW.0326.SM.5N9CY.1
    ## ENSG00000239474                     312383                      40402
    ## ENSG00000088882                       3995                       3668
    ## ENSG00000196616                     338488                     491410
    ## ENSG00000248713                       1615                        871
    ## ENSG00000244694                       1891                       5485
    ## ENSG00000022267                    1304722                    1052906
    ##                 GTEX.ZYFC.1026.SM.5GZX9.1 GTEX.1122O.0626.SM.5N9B9.1
    ## ENSG00000239474                    575777                     319280
    ## ENSG00000088882                     19830                        913
    ## ENSG00000196616                   1157718                    1317138
    ## ENSG00000248713                      9549                      29387
    ## ENSG00000244694                      3817                        940
    ## ENSG00000022267                   2596497                    1419442
    ##                 GTEX.ZTTD.0626.SM.4YCCY.1 GTEX.ZDTT.0326.SM.4WKF9.1
    ## ENSG00000239474                    367289                    634877
    ## ENSG00000088882                     10787                     78038
    ## ENSG00000196616                   1122487                   1099649
    ## ENSG00000248713                    158508                     38248
    ## ENSG00000244694                      7016                      1232
    ## ENSG00000022267                  10577081                   2713886
    ##                 GTEX.12WSC.1026.SM.5EQ5Y.1 GTEX.11LCK.0926.SM.5A5KA.1
    ## ENSG00000239474                     321180                     609968
    ## ENSG00000088882                       8268                       1657
    ## ENSG00000196616                     401323                     426742
    ## ENSG00000248713                       7595                       3782
    ## ENSG00000244694                       2864                        444
    ## ENSG00000022267                    2681823                    5751501
    ##                 GTEX.14BMV.1026.SM.5SI6B.1 GTEX.12WSD.1126.SM.5EGJD.1
    ## ENSG00000239474                     982753                     280540
    ## ENSG00000088882                      32032                       1311
    ## ENSG00000196616                    1883631                      57901
    ## ENSG00000248713                     190815                       1346
    ## ENSG00000244694                        739                       2501
    ## ENSG00000022267                    3090016                    5041687
    ##                 GTEX.147JS.1326.SM.5SI6D.1 GTEX.ZQUD.1526.SM.51MRE.1
    ## ENSG00000239474                     427797                    457105
    ## ENSG00000088882                     115454                      2115
    ## ENSG00000196616                     537204                    308394
    ## ENSG00000248713                      41492                      5168
    ## ENSG00000244694                       6939                       120
    ## ENSG00000022267                    3756382                   2951894
    ##                 GTEX.1399T.0726.SM.5J1MH.1 GTEX.145MN.0726.SM.5NQBH.1
    ## ENSG00000239474                     364831                     962966
    ## ENSG00000088882                      34300                       5796
    ## ENSG00000196616                    2092336                     329670
    ## ENSG00000248713                       3324                     114285
    ## ENSG00000244694                       5624                        140
    ## ENSG00000022267                    4413257                    9850992
    ##                 GTEX.ZLFU.0226.SM.4WWFH.1 GTEX.1399T.0426.SM.5PNVJ.1
    ## ENSG00000239474                    813200                       8166
    ## ENSG00000088882                       247                       2098
    ## ENSG00000196616                    298518                     285452
    ## ENSG00000248713                      8712                        456
    ## ENSG00000244694                      1210                       1265
    ## ENSG00000022267                   8888799                     288178
    ##                 GTEX.1477Z.1126.SM.5P9GK.1 GTEX.13SLX.0926.SM.5S2NM.1
    ## ENSG00000239474                     233469                     201016
    ## ENSG00000088882                       2767                     104885
    ## ENSG00000196616                    3834368                     729229
    ## ENSG00000248713                      11432                      57310
    ## ENSG00000244694                       4623                       4649
    ## ENSG00000022267                    3322214                    3260742
    ##                 GTEX.14A6H.0326.SM.5NQAN.1 GTEX.111YS.0426.SM.5987O.1
    ## ENSG00000239474                     361130                     584359
    ## ENSG00000088882                     177623                        583
    ## ENSG00000196616                    1675546                     515936
    ## ENSG00000248713                       7531                       6686
    ## ENSG00000244694                       1949                        586
    ## ENSG00000022267                    1435091                    4049665
    ##                 GTEX.13N11.0426.SM.5KM3O.1 GTEX.131XG.0626.SM.5GCMP.1
    ## ENSG00000239474                     475357                     921762
    ## ENSG00000088882                       7482                       6956
    ## ENSG00000196616                     842259                     322141
    ## ENSG00000248713                       2930                    1545570
    ## ENSG00000244694                        561                       2592
    ## ENSG00000022267                    3284297                   25502053
    ##                 GTEX.YEC3.0426.SM.4YCEP.1 GTEX.11EM3.0626.SM.5H12Z.1
    ## ENSG00000239474                    616217                     543453
    ## ENSG00000088882                      3066                      25787
    ## ENSG00000196616                   1778386                      86063
    ## ENSG00000248713                     20422                    2354711
    ## ENSG00000244694                      2608                        152
    ## ENSG00000022267                   1408134                   40491641
    ##                              id
    ## ENSG00000239474 ENSG00000239474
    ## ENSG00000088882 ENSG00000088882
    ## ENSG00000196616 ENSG00000196616
    ## ENSG00000248713 ENSG00000248713
    ## ENSG00000244694 ENSG00000244694
    ## ENSG00000022267 ENSG00000022267

Now we can pivot longer. We use `cols` to specify with column names will
be turned into observations and we use `names_to` to specify the name of
the new column that contains those observations. We use `values_to` to
name the column with the corresponding value, in this case we will call
the new columns, `SAMPID` and `counts`.

``` r
counts_tidy_long <- counts_tidy_slim %>%
  pivot_longer(cols = all_of(mycols), names_to = "SAMPID", 
               values_to = "counts") 
head(counts_tidy_long)
```

    ## # A tibble: 6 × 3
    ##   id              SAMPID                     counts
    ##   <chr>           <chr>                       <dbl>
    ## 1 ENSG00000007933 GTEX.12ZZX.0726.SM.5EGKA.1   9772
    ## 2 ENSG00000007933 GTEX.13D11.1526.SM.5J2NA.1  16299
    ## 3 ENSG00000007933 GTEX.ZAJG.0826.SM.5PNVA.1   32826
    ## 4 ENSG00000007933 GTEX.11TT1.1426.SM.5EGIA.1   2685
    ## 5 ENSG00000007933 GTEX.13VXT.1126.SM.5LU3A.1   5120
    ## 6 ENSG00000007933 GTEX.14ASI.0826.SM.5Q5EB.1  17898

Now, that we have a `SAMPID` column, we can join this with our
colData_tidy. We can also use the `id` column to join with genes.

``` r
counts_tidy_long_joined <- counts_tidy_long%>%
  inner_join(., colData_tidy, by = "SAMPID") %>%
  inner_join(., genes, by = "id") %>%
  arrange(desc(counts))
head(counts_tidy_long_joined)
```

    ## # A tibble: 6 × 16
    ##   id      SAMPID counts SMTS  SMTSD SUBJID SEX   AGE   SMRIN DTHHRDY SRA   DATE 
    ##   <chr>   <chr>   <dbl> <chr> <chr> <chr>  <chr> <chr> <dbl> <chr>   <chr> <chr>
    ## 1 ENSG00… GTEX.… 4.83e7 Heart Hear… GTEX-… Male  50-59   8.8 Ventil… SRR1… 2013…
    ## 2 ENSG00… GTEX.… 4.05e7 Heart Hear… GTEX-… Fema… 20-29   8.5 Ventil… SRR1… 2013…
    ## 3 ENSG00… GTEX.… 3.43e7 Heart Hear… GTEX-… Fema… 40-49   8.7 Ventil… SRR1… 2013…
    ## 4 ENSG00… GTEX.… 3.41e7 Heart Hear… GTEX-… Fema… 40-49   8.2 Ventil… SRR1… 2013…
    ## 5 ENSG00… GTEX.… 2.85e7 Heart Hear… GTEX-… Male  40-49   8.6 Ventil… SRR1… 2013…
    ## 6 ENSG00… GTEX.… 2.63e7 Heart Hear… GTEX-… Fema… 40-49   8.6 Ventil… SRR1… 2013…
    ## # … with 4 more variables: name <chr>, description <chr>, synonyms <chr>,
    ## #   organism <chr>

``` r
library(scales)
```

    ## Warning: package 'scales' was built under R version 4.1.2

``` r
counts_tidy_long_joined %>%
  ggplot(aes(x = AGE, y = counts)) +
  geom_boxplot() +
  geom_point() +
  facet_wrap(~name, scales = "free_y") +
  theme(axis.text.x = element_text(angle = 45, hjust  = 1),
        strip.text = element_text(face = "italic")) +
  scale_y_log10(labels = label_number_si()) 
```

    ## Warning: `label_number_si()` was deprecated in scales 1.2.0.
    ## Please use the `scale_cut` argument of `label_number()` instead.
    ## This warning is displayed once every 8 hours.
    ## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was generated.

    ## Warning: Transformation introduced infinite values in continuous y-axis
    ## Transformation introduced infinite values in continuous y-axis

    ## Warning: Removed 3 rows containing non-finite values (stat_boxplot).

![](./images/boxplot2-1.png)<!-- -->

That completes our section on tidying and transforming data.

:::success

#### Key functions: Tidy and Transform

| Function         | Description                                                                                     |
|------------------|-------------------------------------------------------------------------------------------------|
| `filter()`       | A function for filtering data                                                                   |
| `mutate()`       | A function for create new columns                                                               |
| `select()`       | A function for selecting/reordering columns                                                     |
| `arrange()`      | A function for ordering observations                                                            |
| `full_join()`    | Join 2 tables, return all observations                                                          |
| `left_join()`    | Join 2 tables, return all observations in the left and matching observations in the right table |
| `inner_join()`   | Join 2 tables, return observations with values in both tables                                   |
| `pivot_wider()`  | Widen a data frame                                                                              |
| `pivot_longer()` | Lengthen a data frame                                                                           |
| `drop_na()`      | Remove missing values                                                                           |
| `separate()`     | Separate a column into two columns                                                              |

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
was last modified 3 May, 2022.*

------------------------------------------------------------------------

### Appendix

``` r
2 + 2 * 100
log10(0.05)

pval <- 0.05
pval

-log10(pval)


favorite_genes <- c("BRCA1", "JUN",  "GNRH1", "TH", "AR")
favorite_genes

#install.packages("ggplot2")

library(ggplot2)
library(tidyr)
library(dplyr)


samples <- read.csv("./data/samples.csv")

#View(samples)
head(samples)
tail(samples)
str(samples)
summary(samples)


counts <- read.csv("./data/countData.HEART.csv", row.names = 1)
dim(counts)
head(counts)[1:5]


# with row.names
results <- read.table("./data/GTEx_Heart_20-29_vs_50-59.tsv")
head(results)


dim(samples)


dplyr::count(samples, SMTS) 


head(dplyr::count(samples, SMTS, SEX))


head(dplyr::count(samples, SMTS, SEX, AGE, DTHHRDY ) )


ggplot(samples, aes(x = SMTS)) +
  geom_bar(stat = "count")


ggplot(samples, aes(x = SMTS)) +
  geom_bar(stat = "count") + 
  coord_flip()


ggplot(samples, aes(x = SMTS, color = AGE)) +
  geom_bar(stat = "count") + 
  coord_flip()


ggplot(samples, aes(x = SMTS, fill = AGE)) +
  geom_bar(stat = "count") + 
  coord_flip()


ggplot(samples, aes(x = SMTS, fill = AGE)) +
  geom_bar(stat = "count") + 
  coord_flip() +
  facet_wrap(~SEX)


ggplot(results, aes(x = logFC, y = -log10(adj.P.Val))) +
  geom_point() 


ggplot(results, aes(x = logFC, y = -log10(adj.P.Val))) +
  geom_point() +
  geom_hline(yintercept = -log10(0.05))


ggplot(results, aes(x = logFC, y = -log10(adj.P.Val))) +
  geom_point(aes(color = ifelse( adj.P.Val < 0.05, "p < 0.05", "NS"))) +
  geom_hline(yintercept = -log10(0.05)) 


ggplot(results, aes(x = logFC, y = -log10(adj.P.Val))) +
  geom_point(aes(color = ifelse( adj.P.Val < 0.05, "p < 0.05", "NS"))) +
  geom_hline(yintercept = -log10(0.05))  +
  theme(legend.position = "bottom") +
  labs(color = "20-29 vs 50-59 year olds", 
       subtitle = "Heart Tissue Gene Expression")



ggplot(samples, aes(x = SMCENTER, y = SMRIN)) +
  geom_boxplot() +
  geom_jitter(aes(color = SMRIN))


results %>% 
  filter(adj.P.Val < 0.05) %>% 
  head()


results %>% 
  filter(logFC > 1 | logFC < -1) %>%
  head()


results %>% filter(adj.P.Val < 0.05,
                   logFC > 1 | logFC < -1) %>%
  arrange(adj.P.Val) %>%
  head()



resultsDEGs <- results %>% filter(adj.P.Val < 0.05,
                   logFC > 1 | logFC < -1) %>%
  arrange(adj.P.Val) %>% 
  rownames(.)
resultsDEGs


colData <- read.csv("./data/colData.HEART.csv", row.names = 1)
head(colData)

head(rownames(colData) == colnames(counts))
head(colnames(counts))
head(rownames(colData))


colData_tidy <-  colData %>%
  mutate(SAMPID = gsub("-", ".", SAMPID))  
rownames(colData_tidy) <- colData_tidy$SAMPID

mycols <- rownames(colData_tidy)
head(mycols)


counts_tidy <- counts %>%
  select(all_of(mycols))

head(rownames(colData_tidy) == colnames(counts_tidy))


genes <- read.table("./data/ensembl_genes.tsv", sep = "\t",  header = T, fill = T)
head(genes)


resultsSymbol <- results %>%
  mutate(name = row.names(.))
head(resultsSymbol)


resultsName <- left_join(resultsSymbol, genes, by = "name")
head(resultsName)


resultsNameTidy <- resultsName %>%
  filter(adj.P.Val < 0.05,
                   logFC > 1 | logFC < -1) %>%
  arrange(adj.P.Val) %>%
  select(name, description, id, logFC, AveExpr, adj.P.Val)
head(resultsNameTidy)


resultsNameTidyIds <- resultsNameTidy %>%
  drop_na(id) %>%
  pull(id)
resultsNameTidyIds


counts_tidy_slim <- counts_tidy %>%
  mutate(id = row.names(.)) %>%
  filter(id %in% resultsNameTidyIds)
dim(counts_tidy_slim)
head(counts_tidy_slim)[1:5]
tail(counts_tidy_slim)

counts_tidy_long <- counts_tidy_slim %>%
  pivot_longer(cols = all_of(mycols), names_to = "SAMPID", 
               values_to = "counts") 
head(counts_tidy_long)


counts_tidy_long_joined <- counts_tidy_long%>%
  inner_join(., colData_tidy, by = "SAMPID") %>%
  inner_join(., genes, by = "id") %>%
  arrange(desc(counts))
head(counts_tidy_long_joined)


library(scales)

counts_tidy_long_joined %>%
  ggplot(aes(x = AGE, y = counts)) +
  geom_boxplot() +
  geom_point() +
  facet_wrap(~name, scales = "free_y") +
  theme(axis.text.x = element_text(angle = 45, hjust  = 1),
        strip.text = element_text(face = "italic")) +
  scale_y_log10(labels = label_number_si()) 
```
