library(ggplot2)
library(tidyr)
library(dplyr)
library(readr)
library(tibble)
library(stringr)
library(forcats)
library(recount3)
library(biomaRt)
library(DESeq2)
library(cowplot)
library(scales)
library(magick)

# import

samplesbaseR <- read.csv("./data/GTExPortal.csv")
head(samplesbaseR)

samplestidyR <- read_csv("./data/GTExPortal.csv")
head(samplestidyR)

results <- read.table("./data/GTEx_Heart_20-29_vs_30-39.tsv",
                      header = TRUE, sep = "\t")
head(results)

genes <- read.table("./data/genes.txt", 
                    sep = "\t", header = T, fill = T)
head(genes)

#gunzip -k ../data/countData.HEART.csv.gz
counts <- read.csv("./data/countData.HEART.csv", header = TRUE, row.names = 1)
head(counts)[1:5]

colData <- read.csv("./data/colData.HEART.csv", header = TRUE, row.names = 1)
head(colData)[1:5]

head(rownames(colData) == colnames(counts))
