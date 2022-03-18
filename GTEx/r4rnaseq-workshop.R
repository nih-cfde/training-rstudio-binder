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


# a data frame with row.names
results <- read.table("./data/GTEx_Heart_20-29_vs_30-39.tsv")
head(results)

# a data frame without row.names
results2 <- read.table("./data/GTEx_Heart_20-29_vs_30-39.tsv",  sep = "\t", header = TRUE )
head(results2)


genes <- read.table("./data/genes.txt", sep = "\t",  header = T, fill = T)
head(genes)


# Open the Terminal and type the command (ater the $) to uznip
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


head(results2)
head(genes)

head(results2$X)
head(genes$Approved.symbol)

results_new <- results2 %>% dplyr::rename("Approved.symbol" = "X")
head(results_new)


results_genes <- left_join(results_new, genes, by = "Approved.symbol")
head(results_genes)


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


head(counts_long$Tissue.Sample.ID)
head(samples$Tissue.Sample.ID)

counts_long_newname <- counts_long %>%
  separate(Tissue.Sample.ID, into = c("Tissue.Sample.ID", NULL), 
           sep =  ".SM.")

head(counts_long_newname$Tissue.Sample.ID)
head(samples$Tissue.Sample.ID)

samples_new <- samples %>%
  mutate(Tissue.Sample.ID = gsub("-", ".", Tissue.Sample.ID))
head(samples_new$Tissue.Sample.ID)


counts_long_samples <- counts_long_newname %>%
  inner_join(., samples_new, by = "Tissue.Sample.ID")
head(counts_long_samples)


head(rownames(colData) == colnames(counts))