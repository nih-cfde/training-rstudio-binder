### Appendix

2 + 2 * 100
log(202)

pval <- 0.05
pval

-log10(pval)


favorite_genes <- c("BRCA1", "JUN",  "GNRH1", "TH", "AR")
favorite_genes

#install.packages("ggplot2")

library(ggplot2)
library(tidyr)
library(dplyr)


samples <- read.csv("./data/samples.csv")

View(samples)
head(samples)
tail(samples)
str(samples)
summary(samples)


counts <- read.csv("./data/countData.HEART.csv", row.names = 1)
dim(counts)
head(counts)[1:5]


# with row.names
results <- read.table("./data/GTEx_Heart_20-29_vs_50-59.tsv")
head(results)


dim(samples)


dplyr::count(samples, SMTS) 


dplyr::count(samples, SMTS, SEX) 


dplyr::count(samples, SMTS, SEX, AGE, DTHHRDY ) 


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


ggplot(results, aes(x = logFC, y = -log10(adj.P.Val))) +
  geom_point(aes(color = ifelse( adj.P.Val < 0.05, "p < 0.05", "NS"))) +
  geom_hline(yintercept = -log10(0.05)) 


ggplot(results, aes(x = logFC, y = -log10(adj.P.Val))) +
  geom_point(aes(color = ifelse( adj.P.Val < 0.05, "p < 0.05", "NS"))) +
  geom_hline(yintercept = -log10(0.05))  +
  theme(legend.position = "bottom") +
  labs(color = "20-29 vs 50-59 year olds", 
       subtitle = "Heart Tissue Gene Expression")



ggplot(samples, aes(x = SMCENTER, y = SMRIN)) +
  geom_boxplot() +
  geom_jitter(aes(color = SMRIN))


results %>% filter(adj.P.Val < 0.05) %>% head()


results %>% filter(logFC > 1 | logFC < -1) %>% head()


results %>% filter(adj.P.Val < 0.05,
                   logFC > 1 | logFC < -1) %>%
  arrange(adj.P.Val) %>%
  head()



resultsDEGs <- results %>% filter(adj.P.Val < 0.05,
                                  logFC > 1 | logFC < -1) %>%
  arrange(adj.P.Val) %>% 
  rownames(.)
resultsDEGs


colData <- read.csv("./data/colData.HEART.csv", row.names = 1)
head(colData)

head(rownames(colData) == colnames(counts))
head(colnames(counts))
head(rownames(colData))


colData_tidy <-  colData %>%
  mutate(SAMPID = gsub("-", ".", SAMPID))  
rownames(colData_tidy) <- colData_tidy$SAMPID

mycols <- rownames(colData_tidy)
head(mycols)


counts_tidy <- counts %>%
  select(all_of(mycols))

head(rownames(colData_tidy) == colnames(counts_tidy))


genes <- read.table("./data/genes.txt", sep = "\t",  header = T, fill = T)
head(genes)


resultsSymbol <- results %>%
  mutate(Approved.symbol = row.names(.))
head(resultsSymbol)


resultsName <- left_join(resultsSymbol, genes, by = "Approved.symbol")
head(resultsName)


resultsNameTidy <- resultsName %>%
  filter(adj.P.Val < 0.05,
         logFC > 1 | logFC < -1) %>%
  arrange(adj.P.Val) %>%
  select(Approved.symbol, Approved.name, Ensembl.gene.ID, logFC, AveExpr, adj.P.Val)
head(resultsNameTidy)


counts_tidy_slim <- counts_tidy %>%
  filter(rowSums(.) >0 ) %>%
  head() %>%
  mutate(Ensembl.gene.ID = row.names(.) )
head(counts_tidy_slim)

counts_tidy_long <- counts_tidy_slim %>%
  pivot_longer(cols = all_of(mycols), names_to = "SAMPID", 
               values_to = "counts") 
head(counts_tidy_long)

library(scales)

counts_tidy_long_joined %>%
  ggplot(aes(x = AGE, y = counts)) +
  geom_boxplot() +
  geom_point() +
  facet_wrap(~Ensembl.gene.ID, scales = "free_y") +
  scale_y_log10(labels = label_number_si())
