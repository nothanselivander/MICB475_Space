#Load packages
library(phyloseq)
library(ape)
library(tidyverse)
library(vegan)

#### Load data ####
metafp <- "space_export/project_metadata.tsv"
meta <- read_delim(metafp, delim="\t")

otufp <- "space_export/table_export_correct/feature-table.txt"
otu <- read_delim(file = otufp, delim="\t", skip=1)

taxfp <- "space_export/taxonomy_export/taxonomy.tsv"
tax <- read_delim(taxfp, delim="\t")

phylotreefp <- "space_export/rooted_tree_export/tree.nwk"
phylotree <- read.tree(phylotreefp)


#Format OTU table 
otu_mat <- as.matrix(otu[,-1])
rownames(otu_mat) <- otu$`#OTU ID`
OTU <- otu_table(otu_mat, taxa_are_rows = TRUE) 
class(OTU)

#Format sample metadata
samp_df <- as.data.frame(meta[,-1])
rownames(samp_df)<- meta$'sample id'
SAMP <- sample_data(samp_df)
class(SAMP)

#### Formatting taxonomy ####
tax_mat <- tax %>% select(-Confidence)%>%
  separate(col=Taxon, sep="; "
           , into = c("Domain","Phylum","Class","Order","Family","Genus","Species")) %>%
  as.matrix() 
tax_mat <- tax_mat[,-1]
rownames(tax_mat) <- tax$`Feature ID`
TAX <- tax_table(tax_mat)
class(TAX)

#### Create phyloseq object ####
space <- phyloseq(OTU, SAMP, TAX, phylotree)

#### Adjusting phyloseq files ####
space_filt <- subset_taxa(space, Domain =="d__Bacteria" & Class !="c__Chloroplast" & Family !="f__Mitochondria")
space_nolow <- filter_taxa(space_filt, function(x) sum(x)>5, prune = TRUE)
space_nolow_samp <- prune_samples(sample_sums(space_nolow)>100, space_nolow)
space_final <- space_nolow_samp

space_final_rare <- rarefy_even_depth(space_final, rngseed = 1, sample.size=20000)


save(space_final_rare, file='space_rare.RData')
save(space_final, file='space_final.RData')



