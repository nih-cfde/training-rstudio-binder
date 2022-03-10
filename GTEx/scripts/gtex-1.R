library(dplyr)
library(tidyr)
library(tibble)
library(readr)
library(ggplot2)
library(cowplot)
library(scales)

# import

setwd("~/GTEx")
myfile = "data/GTEx_Brain_20-29_vs_30-39.tsv"

df <- read.table(myfile) 

head(df)
str(df)
summary(df)

# transform

df2 <- df %>% 
  mutate(gene = row.names(.),
         sig = if_else(adj.P.Val < 0.05, "p < 0.05", "NS"),
         file = myfile) %>%
  as_tibble()
head(df2)


# visualize

ggplot(df2, aes(x = logFC, y = -log10(adj.P.Val))) +
  geom_point(aes(color = sig)) +
  labs(subtitle = myfile) +
  theme(legend.position = "none")

ggplot(df2, aes(x = sig)) +
  geom_bar(aes(fill = sig)) +
  theme(legend.position = "none") +
  labs(x = "Adjusted p-value", subtitle = " ") 

# reshape

df3 <- df2 %>%
  group_by(sig) %>%
  summarize(count = length(gene))
head(df3)

ggplot(df3, aes(x = sig, y = count, label = count)) +
  geom_bar(stat = "identity", aes(fill = sig)) +
  theme(legend.position = "none") +
  labs(x = "Adjusted p-value", subtitle = " ") +
  geom_text(aes(x = sig, y = count )) +
  scale_y_continuous(labels = label_number_si())


