library(ggplot2)
library(tidyr)
library(dplyr)
library(readr)
library(tibble)
library(cowplot)
library(scales)
library(forcats)
library(stringr)

samples <- read.csv("./data/GTExPortal.csv")


head(samples)
names(samples)


# with row.names
results <- read.table("./data/GTEx_Heart_20-29_vs_30-39.tsv")
head(results)

# without row.names
results2 <- read.table("./data/GTEx_Heart_20-29_vs_30-39.tsv",  sep = "\t", header = TRUE )
head(results2)


genes <- read.table("./data/genes.txt", sep = "\t",  header = T, fill = T)
head(genes)


# Open the Terminal and type the command (after the $) to uznip
# $ gunzip -k ./data/countData.HEART.csv.gz


counts <- read.csv("./data/countData.Muscle.csv", 
                   header = TRUE, row.names = 1)
dim(counts)
head(counts)[1:5]


colData <- read.csv("./data/colData.HEART.csv")
head(colData)


dim(counts)
length(row.names(counts))


dim(genes)
length(genes$Approved.symbol)


dim(samples)
length(samples$Tissue.Sample.ID)


dplyr::count(samples, Tissue) 


dplyr::count(samples, Tissue, Sex) 


#names(colData)
dplyr::count(colData, gtex.smts, gtex.sex, gtex.age, gtex.dthhrdy) 


str(samples)
summary(samples)

str(results2)
summary(results2)

str(counts[1:5])
summary(counts[1:5])


ggplot(samples, aes(x = Tissue)) +
  geom_bar(stat = "count")


ggplot(samples, aes(x = Tissue)) +
  geom_bar(stat = "count") + 
  coord_flip()


ggplot(samples, aes(x = Tissue, color = Age.Bracket)) +
  geom_bar(stat = "count") + 
  coord_flip()


ggplot(samples, aes(x = Tissue, fill = Age.Bracket)) +
  geom_bar(stat = "count") + 
  coord_flip()


ggplot(samples, aes(x = Tissue, fill = Age.Bracket)) +
  geom_bar(stat = "count") + 
  coord_flip() +
  facet_wrap(~Sex)


ggplot(results, aes(x = logFC, y = -log10(adj.P.Val))) +
  geom_point() 


ggplot(results, aes(x = logFC, y = -log10(adj.P.Val))) +
  geom_point() +
  geom_hline(yintercept = -log10(0.05))


  ggplot(colData, aes(x = gtex.smcenter, y = gtex.smrin)) +
    geom_boxplot() +
    geom_jitter(aes(color = gtex.smrin))


results %>% mutate(Approved.symbol = row.names(.))  
results2 %>% rename(Approved.symbol = X)   


results %>% filter(adj.P.Val < 0.05,
                   logFC > 1 | logFC < -1)


results %>% arrange(adj.P.Val) 


left_join(resultsDEGs, genes, by =  "Approved.symbol")


resultsDEGs %>% select(Approved.symbol, logFC, adj.P.Val)


resultsDEGs <- results %>% 
  mutate(Approved.symbol = row.names(.))  %>% 
  filter(adj.P.Val < 0.05,
         logFC > 1 | logFC < -1) %>% 
  arrange(Approved.symbol) %>%
  left_join(., genes, by =  "Approved.symbol") %>% 
  select(Approved.symbol, Ensembl.gene.ID, logFC, adj.P.Val, Approved.name ) %>%
  as_tibble()
resultsDEGs


head(counts)[1:5]
head(genes$Ensembl.gene.ID)

genes2 <- genes %>%
  mutate(Ensembl.gene.ID = paste(Ensembl.gene.ID, "1", sep = "."))

counts2 <- counts %>%
  mutate(Ensembl.gene.ID = row.names(.))

head(counts2$Ensembl.gene.ID)[1:5]
head(genes2$Ensembl.gene.ID)


counts_long <- counts2 %>%
  pivot_longer(-Ensembl.gene.ID, names_to = "Tissue.Sample.ID", values_to = "counts") %>%
  inner_join(., genes2, by = "Ensembl.gene.ID") %>%
  arrange(desc(counts))
head(counts_long)

head(samples)
head(samples$Tissue.Sample.ID)
head(counts_long$Tissue.Sample.ID)


head(rownames(colData) == colnames(counts))