library(tidyverse)
library(recount3)
library(biomaRt)
library(Rtsne)
library(DESeq2)
library(ggpubr)
library(cowplot)

# get GTEx heart data
human_projects <- available_projects(organism = "human")

# enter yes

head(human_projects)
tail(human_projects)

gtex_heart <- subset(human_projects,
                     project == "HEART"  & 
                       file_source == "gtex" & 
                       project_type == "data_sources" )

head(gtex_heart)

rse_gtex_heart <- create_rse(gtex_heart)
rse_gtex_heart

# format data for DESEq2
countData <- assays(rse_gtex_heart)$raw_counts %>% as.data.frame()
colData <- colData(rse_gtex_heart) %>% as.data.frame()

# check that rows and samples match
rownames(colData) == colnames(countData)

# variables
dim(colData)
dim(countData)

head(rownames(colData))
(colnames(colData))
head(rownames(countData))
head(colnames(countData))

# subset data
# include only those with SRA accession numbers
# exclude miRNA samples

colData <-  colData %>%
  filter(gtex.run_acc != "NA",
         gtex.smnabtcht != "RNA isolation_PAXgene Tissue miRNA") %>%
  dplyr::select(external_id, study, gtex.run_acc, 
                gtex.age, gtex.smtsd)
head(colData)

colData %>%
  group_by(gtex.age, gtex.smtsd) %>%
  summarise(cohort_size = length(gtex.age)) %>%
  ggplot(aes(x = gtex.age,  y = cohort_size, fill = gtex.smtsd)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(x = "Age", y = "Cohort size", fill = "Tissue",
       subtitle = "GTEx data obtained using recount3 ") +
  theme_linedraw(base_size = 15) +
  theme(legend.position = "none") +
  geom_text(aes(label = cohort_size),
            position = position_dodge(width = .9),
            vjust = -0.25)

# get countdata for this subset of colData

## colData and countData must contain the exact same samples. 
savecols <- as.character(rownames(colData)) #select the rowsname 
savecols <- as.vector(savecols) # make it a vector
countData <- countData %>% dplyr::select(one_of(savecols)) # select just the columns 
head(countData)[1:5]  

# check that rows and samples match
rownames(colData) == colnames(countData)

## get and clean ensemble ids

ensembl <- useEnsembl(biomart="ensembl", dataset="hsapiens_gene_ensembl")
gene_info <- getBM(attributes=c('ensembl_gene_id','hgnc_symbol'),  
                   mart = ensembl) %>% 
  mutate_all(na_if, "") %>%
  drop_na(.) %>%
  unique(.) %>%
  mutate(ensembl_gene_id = paste0(ensembl_gene_id, ".1", sep = ""))

head(gene_info)
tail(gene_info)

## make long for easier ggplotting and join with gene info

countData_long <- countData %>%
  mutate(ensembl_gene_id = rownames(.)) %>%
  pivot_longer(-ensembl_gene_id, 
               names_to = "external_id", values_to = "counts") %>%
  inner_join(gene_info, .,by = "ensembl_gene_id") %>% 
  full_join(colData, ., by = "external_id") %>%
  arrange(desc(counts))
head(countData_long)
tail(countData_long)

# plot your favorite gene

countData_long %>%
  filter( hgnc_symbol == "MT-CO2") %>%
  ggplot(aes(x = gtex.age, y = counts, 
             fill = gtex.smtsd)) +
  geom_boxplot() +
  scale_y_log10() +
  labs(y = 'MT-CO2 counts', x = "Age", subtitle = "") +
  theme_linedraw(base_size = 15) +
  theme(legend.position = "none")

# replace dashes with underscores for deseq
names(countData) <- gsub(x = names(countData), pattern = "\\-", replacement = "_")
rownames(colData) <- gsub(x = rownames(colData) , pattern = "\\-", replacement = "_")
colData$gtex.age <- gsub(x = colData$gtex.age , pattern = "\\-", replacement = "_")
colData$gtex.smtsd <-  gsub(x = colData$gtex.smtsd , pattern = "\\-", replacement = "")
colData$gtex.smtsd <-  gsub(x = colData$gtex.smtsd , pattern = " ", replacement = "")
names(countData)
rownames(colData)

# check that rows and samples match
rownames(colData) == colnames(countData)

# subset to 100 for deseq

colDataSlim <- colData %>%
  filter(gtex.age  %in% c("30_39","40_49")) 

## colData and countData must contain the exact same samples. 
savecols <- as.character(rownames(colDataSlim)) #select the rowsname 
savecols <- as.vector(savecols) # make it a vector
countDataSlim <- countData %>% dplyr::select(one_of(savecols)) # select just the columns 
head(countDataSlim)[1:5]  

# check that rows and samples match
rownames(colDataSlim) == colnames(countDataSlim)


# deseq

dds <- DESeqDataSetFromMatrix(countData = countDataSlim,
                              colData = colDataSlim,
                              design = ~ gtex.age * gtex.smtsd)

dds <- dds[ rowSums(counts(dds)) > 1, ]  # Pre-filtering genes with 0 counts
dds <- DESeq(dds, parallel = TRUE)
vsd <- vst(dds, blind=FALSE)

res1 <- results(dds, name="gtex.age_40_49_vs_30_39",  independentFiltering = T)
res2 <- results(dds, name="gtex.smtsd_HeartLeftVentricle_vs_HeartAtrialAppendage", independentFiltering = T)
res3 <- results(dds, name="gtex.age40_49.gtex.smtsdHeartLeftVentricle", independentFiltering = T)


sum(res1$padj < 0.1, na.rm=TRUE) # age 1145 DEGS
sum(res2$padj < 0.1, na.rm=TRUE) # tissue 5243 tissue
sum(res3$padj < 0.1, na.rm=TRUE) # tissue 5243 tissue

plotMA(res1, ylim=c(-2,2))
plotMA(res2, ylim=c(-2,2))
plotMA(res3, ylim=c(-2,2))

ensembl_gene_id <- rownames(res1)  
ensembl_gene_id <- data.frame(ensembl_gene_id) %>%
  left_join(., gene_info)

ensembl_gene_id <- ensembl_gene_id[1:51297,]
head(ensembl_gene_id )

ggmaplot(res1, main = expression("Age 30-39" %->% "Age 40 -49"),
         fdr = 0.05, fc = 2, size = 0.4,
         palette = c("#B31B21", "#1465AC", "darkgray"),
         #genenames = as.vector( ensembl_gene_id$hgnc_symbol),
         legend = "bottom", top = 1,
         ggtheme = ggplot2::theme_linedraw(base_size = 15))

ggmaplot(res2, main = expression("Heart Atrial Appendage" %->% "Heart Left Ventricle"),
         fdr = 0.05, fc = 2, size = 0.4,
         palette = c("#B31B21", "#1465AC", "darkgray"),
         #genenames = as.vector( ensembl_gene_id$hgnc_symbol),
         legend = "bottom", top = 1,
         ggtheme = ggplot2::theme_linedraw(base_size = 15))

countData_long %>%
  filter( ensembl_gene_id == "ENSG00000163217.1") %>%
  ggplot(aes(x = gtex.age, y = counts, 
             fill = gtex.smtsd)) +
  geom_boxplot() +
  scale_y_log10(labels = scales::label_number_si(accuracy = 0.1)) +
  labs(y = 'Counts', x = "Age", subtitle = "ENSG00000163217.1") +
  theme_linedraw(base_size = 15) +
  theme(legend.position = "bottom", legend.direction = "vertical")
