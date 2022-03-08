setwd("~/GTEx")

library(dplyr)
library(tidyr)
library(tibble)
library(readr)

df <- read.table("data/GTEx_Brain_20-29_vs_30-39.tsv") 
head(df)