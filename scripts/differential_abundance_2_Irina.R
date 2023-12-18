# to double check DESeq2 and regenerate volcano plot
# load libraries
library(tidyverse)
library(phyloseq)
library(DESeq2)
library(vegan)


#### Load data ####
load("space_project_final.RData")

#### DESeq ####
data_source_deseq <- phyloseq_to_deseq2(mpt_final, ~`data_source`)
DESEQ_data_source <- DESeq(data_source_deseq)

## NOTE: If you get a zeros error, then you need to add '1' count to all reads
data_source_plus1 <- transform_sample_counts(mpt_final, function(x) x+1)
data_source_deseq <- phyloseq_to_deseq2(data_source_plus1, ~`data_source`)
DESEQ_data_source <- DESeq(data_source_deseq)
res_data_source <- results(DESEQ_data_source, tidy=TRUE, 
               #this will ensure that No is your reference group
               contrast = c("data_source","iss","hiseas"))
View(res_data_source)

vol_plot_data_source <- res_data_source %>%
  mutate(significant = padj<0.01 & abs(log2FoldChange)>2) %>%
  ggplot() +
  geom_point(aes(x=log2FoldChange, y=-log10(padj), col=significant))

vol_plot_data_source

ggsave(filename="vol_plot_data_source.png",vol_plot_data_source)
