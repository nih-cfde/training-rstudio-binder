library(ggplot2)
library(tidyr)
library(dplyr)
library(readr)
library(tibble)
library(stringr)
library(forcats)
library(cowplot)
library(scales)

samplesbaseR <- read.csv("./data/GTExPortal.csv")
head(samplesbaseR)

results <- read.table("./data/GTEx_Heart_20-29_vs_30-39.tsv",
                      header = TRUE, sep = "\t")
head(results)

genes <- read.table("./data/genes.txt",  sep = "\t", header = T, fill = T)
head(genes)

# open the Terminal and run this command: 
# gunzip -k ./data/countData.HEART.csv.gz

counts <- read.csv("./data/countData.HEART.csv", header = TRUE, row.names = 1)
head(counts)[1:5]

colData <- read.csv("./data/colData.HEART.csv", header = TRUE, row.names = 1)
head(colData)[1:5]

head(rownames(colData) == colnames(counts))