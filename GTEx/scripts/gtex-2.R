library(dplyr)
library(tidyr)
library(tibble)
library(readr)
library(ggplot2)
library(stringr)

# import

setwd("~/GTEx")

files <- dir(pattern = ".tsv", path = "data",
             full.names = T)
files

df <- data.frame()

for (myfile in files){
  
print(myfile)

df2 <-  read.table(myfile)  %>% 
  as_tibble() %>%
  mutate(gene = row.names(.),
         sig = if_else(adj.P.Val < 0.05, "p < 0.05", "NS"),
         file = myfile) %>%
  separate(file, sep = "\\.", into = c("file", "ext")) %>%
  separate(file, sep = "_", into = c("path", "tissue", "base", "vs", "comp")) %>%
  mutate(group = paste(tissue, base, comp, sep = "_")) %>%
  filter(!tissue %in% c("Bladder", "SalivaryGland", "Uterus", "NA")) 
  
head(df2)

df <- rbind(df, df2)

}

head(df)

# visualize

a <- ggplot(df, aes(x = logFC, y = -log10(adj.P.Val))) +
  geom_point(aes(color = sig)) + 
  facet_wrap(~group, ncol = 5) +
  theme(legend.position = "bottom")
a

# reshape

df3 <- df %>%
  group_by(sig, group) %>%
  summarize(count = length(gene))
head(df3)

b <-  ggplot(df3, aes(x = sig, y = count, label = count)) +
  geom_bar(stat = "identity", aes(fill = sig)) +
  theme(legend.position = "none") +
  labs(x = "Adjusted p-value", subtitle = " ") +
  geom_text(aes(x = sig, y = count )) +
  scale_y_continuous(labels = label_number_si()) +
  facet_wrap(~group, ncol = 5)
b

p <- plot_grid(a,b, ncol = 1)


png(file="DEGs.png", 
    width=7, height=7, res = 300, units = "in")
plot(p)
dev.off()

