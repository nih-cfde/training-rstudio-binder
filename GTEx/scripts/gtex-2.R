setwd("~/GTEx")

library(dplyr)
library(tidyr)
library(tibble)
library(readr)
library(ggplot2)

# import

files <- dir(pattern = ".tsv", path = "data",
             full.names = T)

df <- data.frame()

for (myfile in files){
  
# transform

df2 <-  read.table(myfile)  %>% 
  mutate(gene = row.names(.),
         sig = if_else(adj.P.Val < 0.05, "p < 0.05", "NS"),
         file = myfile) %>%
  separate(file, sep = "\\.", into = c("file", "ext")) %>%
  separate(file, sep = "_", into = c("path", "tissue", "base", "vs", "comp")) %>%
  mutate(group = paste(tissue, base, comp, sep = "_")) %>%
  as_tibble()
head(df2)

df <- rbind(df, df2)

}

head(df)

# visualize

p <- ggplot(df, aes(x = logFC, y = -log10(adj.P.Val))) +
  geom_point(aes(color = sig)) + 
  facet_wrap(~group, ncol = 5) +
  theme(legend.position = "bottom")

png(file="fig-2.png", width = 7, height = 7,
    units="in", res = 300)
plot(p)
dev.off()


head(df)

siggenes <- df %>%
  filter(sig != "NS")

siggenes2 <- siggenes %>%
  select(logFC, adj.P.Val, group, gene)

head(siggenes2)

siggenes3 <- siggenes2 %>%
  group_by(gene) %>%
  summarize(n = length(gene)) %>%
  arrange(desc(n))
head(siggenes3)

