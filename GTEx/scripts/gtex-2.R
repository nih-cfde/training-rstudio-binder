setwd("~/GTEx")

library(dplyr)
library(tidyr)
library(tibble)
library(readr)
library(ggplot2)
library(stringr)

# import

files <- dir(pattern = ".tsv", path = "data",
             full.names = T)
files

df <- data.frame()

for (myfile in files){
  

print(myfile)

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



p <- df %>%
  filter(!tissue %in% c("Bladder", "SalivaryGland", "Uterus", "NA")) %>%
  ggplot(aes(x = logFC, y = -log10(adj.P.Val))) +
  geom_point(aes(color = sig)) + 
  facet_wrap(~group, ncol = 5) +
  theme(legend.position = "bottom")

png(file="fig-2.png", width = 9, height = 63,
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

