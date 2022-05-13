# commands for installing packages (uncomment to run)

#install.packages("dplyr")
#install.packages("tidyr")
#install.packages("tibble")
#install.packages("readr")
#install.packages("ggplot2")
#install.packages("cowplot")
#install.packages("scales")

# load packages

library(dplyr)
library(tidyr)
library(tibble)
library(readr)
library(ggplot2)
library(cowplot)
library(scales)

# import

myfile = "data/GTEx_Heart_20-29_vs_70-79.tsv"
#myfile = "data/GTEx_Muscle_20-29_vs_70-79.tsv"

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

a <- ggplot(df2, aes(x = logFC, y = -log10(adj.P.Val))) +
  geom_point(aes(color = sig)) +
  labs(subtitle = myfile)
a

b <- ggplot(df2, aes(x = sig)) +
  geom_bar(aes(fill = sig)) +
  theme(legend.position = "none") +
  labs(x = "Adjusted p-value", subtitle = myfile) 
b
# reshape

df3 <- df2 %>%
  group_by(sig) %>%
  summarize(count = length(gene))
head(df3)

c <- ggplot(df3, aes(x = sig, y = count, label = count)) +
  geom_bar(stat = "identity", aes(fill = sig)) +
  theme(legend.position = "none") +
  labs(x = "Adjusted p-value", subtitle = " ") +
  geom_text(aes(x = sig, y = count )) +
  scale_y_continuous(labels = label_number_si())
c

p <- plot_grid(a,c)

png(file="./images/DEGs-1.png", 
    width=6, height=4, res = 300, units = "in")
plot(p)
dev.off()

