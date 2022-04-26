2 + 2 * 100
log(202)

pval <- 0.05
pval

-log10(pval)

favorite_genes <- c("BRCA1", "POMC", "GnRH", "MC4R", "FOS", "CNR1")
favorite_genes

library(ggplot2)
library(tidyr)
library(dplyr)

samples <- read.csv("./data/samples.csv")


head(samples)
names(samples)
str(samples)
summary(samples)

counts <- read.csv("./data/countData.HEART.csv", 
                   header = TRUE, row.names = 1)
dim(counts)
head(counts)[1:5]


colData <- read.csv("./data/colData.HEART.csv", row.names = 1)
head(colData)


# with row.names
results <- read.table("./data/GTEx_Heart_20-29_vs_30-39.tsv")
head(results)

# without row.names
results2 <- read.table("./data/GTEx_Heart_20-29_vs_30-39.tsv",  sep = "\t", header = TRUE )
head(results2)


dim(counts)
length(row.names(counts))


dim(samples)
length(samples$SMTS)


dplyr::count(samples, SMTS) 


dplyr::count(samples, SMTS, SEX) 


#names(colData)
dplyr::count(colData, SMTS, SEX, AGE, DTHHRDY ) 


str(samples)
summary(samples)

str(counts[1:5])
summary(counts[1:5])


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


ggplot(colData, aes(x = DTHHRDY, y = SMRIN)) +
  geom_boxplot() +
  geom_jitter(aes(color = SMRIN))


results %>% mutate(Approved.symbol = row.names(.))  


results %>% filter(adj.P.Val < 0.05,
                   logFC > 1 | logFC < -1)


results %>% arrange(adj.P.Val) 


resultsDEGs <- results %>% 
  mutate(Approved.symbol = row.names(.))  %>% 
  filter(adj.P.Val < 0.05,
         logFC > 1 | logFC < -1) %>%
  arrange(adj.P.Val) 
resultsDEGs


genes <- read.table("./data/genes.txt", sep = "\t",  header = T, fill = T)
head(genes)


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

resultsDEGs <- results %>% 
  mutate(Approved.symbol = row.names(.))  %>% 
  filter(adj.P.Val < 0.05,
         logFC > 1 | logFC < -1) %>% 
  arrange(Approved.symbol) %>%
  left_join(., genes, by =  "Approved.symbol") %>% 
  select(Approved.symbol, Ensembl.gene.ID, logFC, adj.P.Val, Approved.name ) %>%
  filter(grepl("ENSG", Ensembl.gene.ID)) %>%
  as_tibble()
resultsDEGs
DEGsENSG <- resultsDEGs %>% pull(Ensembl.gene.ID)
DEGsENSG
DEGsSymbol <- resultsDEGs %>% pull(Approved.symbol)
DEGsSymbol

head(rownames(colData) == colnames(counts))
head(colnames(counts))
head(rownames(colData))


colData_tidy <-  colData %>%
  mutate(SAMPID = gsub("-", ".", SAMPID))  
rownames(colData_tidy) <- colData_tidy$SAMPID

mycols <- rownames(colData_tidy)

counts_tidy <- counts %>%
  select(all_of(mycols))

head(rownames(colData_tidy) == colnames(counts_tidy))


counts_tidy_long <- counts_tidy %>%
  select(all_of(mycols)) %>%
  mutate(Ensembl.gene.ID = rownames(.)) %>%
  separate(Ensembl.gene.ID, into = c("Ensembl.gene.ID", "version"), 
           sep = "\\.") %>%
  filter(Ensembl.gene.ID %in% all_of(DEGsENSG)) %>%
  pivot_longer(cols = all_of(mycols), names_to = "SAMPID", 
               values_to = "counts") %>%
  inner_join(., colData_tidy, by = "SAMPID") %>%
  arrange(desc(counts)) %>%
  inner_join(., genes, by = "Ensembl.gene.ID") %>%
  select(Ensembl.gene.ID, Approved.name, Approved.symbol, counts, 
         SAMPID, SMTSD, AGE, SEX, DTHHRDY)
head(counts_tidy_long)

library(scales)

counts_tidy_long %>%
  ggplot(aes(x = AGE, y = counts)) +
  geom_boxplot() +
  geom_point() +
  facet_wrap(~Approved.symbol, scales = "free_y") +
  scale_y_log10(labels = label_number_si())