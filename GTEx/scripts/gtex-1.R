setwd("~/GTEx")

library(dplyr)
library(tidyr)
library(tibble)
library(readr)
library(ggplot2)

# import

myfile = "data/GTEx_Brain_20-29_vs_30-39.tsv"

df <- read.table(myfile) 

head(df)
str(df)

# transform

df2 <- df %>% 
  mutate(gene = row.names(.),
         sig = if_else(adj.P.Val < 0.05, "p < 0.05", "NS"),
         file = myfile) %>%
  as_tibble()
head(df2)

numsiggenes <- df2 %>%
  filter(sig != "NS") %>%
  summarize(n = length(gene)) %>%
  pull(n)
numsiggenes

# visualize

ggplot(df2, aes(x = logFC, y = -log10(adj.P.Val))) +
  geom_point(aes(color = sig)) + facet_wrap(~file) +
  labs(subtitle = paste(numsiggenes, " differentially expressed genes"))




