BiocManager::install("DESeq2")


#### Load Packages ####
library(DESeq2)
library(phyloseq)

load("space_project_final.RData")


####DESeq####
mpt_final_plus1 <- transform_sample_counts(mpt_final, function(x) x+1)
mpt_deseq <- phyloseq_to_deseq2(mpt_final_plus1, ~data_source)
DESEQ_mpt <- DESeq(mpt_deseq)

res <- results(DESEQ_mpt, tidy=TRUE, 
               contrast = c("data_source","iss","hiseas"))
view(res)

##### Volcano Plot#####
ggplot(res) +
  geom_point(aes(x=log2FoldChange, y=-log10(padj)))

vol_plot <- res %>%
  mutate(significant = padj<0.01 & abs(log2FoldChange)>2) %>%
  ggplot() +
  geom_point(aes(x=log2FoldChange, y=-log10(padj), col=significant))

ggsave(filename="vol_plot.png",vol_plot)

######################

sigASVs <- res %>% 
  filter(padj<0.01 & abs(log2FoldChange)>2) %>%
  dplyr::rename(ASV=row)
View(sigASVs)

sigASVs_vec <- sigASVs %>%
  pull(ASV)

mpt_DESeq <- prune_taxa(sigASVs_vec,mpt_final)
sigASVs <- tax_table(mpt_DESeq) %>% as.data.frame() %>%
  rownames_to_column(var="ASV") %>%
  right_join(sigASVs) %>%
  arrange(log2FoldChange) %>%
  mutate(Genus = make.unique(Genus)) %>%
  mutate(Genus = factor(Genus, levels=unique(Genus)))

ggplot(sigASVs) +
  geom_bar(aes(x=Genus, y=log2FoldChange), stat="identity")+
  geom_errorbar(aes(x=Genus, ymin=log2FoldChange-lfcSE, ymax=log2FoldChange+lfcSE)) +
  theme(axis.text.x = element_text(angle=90, hjust=1, vjust=0.5))

