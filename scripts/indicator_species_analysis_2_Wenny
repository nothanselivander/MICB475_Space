library(tidyverse)
library(phyloseq)
library(indicspecies)

load("../space_project/space_project_final.RData")
space_final <- mpt_final

# glom to Genus
space_genus <- tax_glom(space_final, "Genus", NArm = FALSE)
space_genus_RA <- transform_sample_counts(space_genus, fun=function(x) x/sum(x))

#ISA data_source
isa_space <- multipatt(t(otu_table(space_genus_RA)), cluster = sample_data(space_genus_RA)$`data_source`)
summary(isa_space)
taxtable <- tax_table(space_final) %>% as.data.frame() %>% rownames_to_column(var="ASV")
isa_space$sign %>%
  rownames_to_column(var="ASV") %>%
  left_join(taxtable) %>%
  filter(p.value<0.05) %>% View()

#isolation_data_source
isa_space_isolation_data_source <- multipatt(t(otu_table(space_genus_RA)), cluster = sample_data(space_genus_RA)$`isolation_data_source`)
summary(isa_space_isolation_data_source)
isa_space_isolation_data_source$sign %>%
  rownames_to_column(var="ASV") %>%
  left_join(taxtable) %>%
  filter(p.value<0.05) %>% View()

#mutated_isolation_source
isa_space_mutated_isolation_source <- multipatt(t(otu_table(space_genus_RA)), cluster = sample_data(space_genus_RA)$`mutated_isolation_source`)
summary(isa_space_mutated_isolation_source)
isa_space_mutated_isolation_source$sign %>%
  rownames_to_column(var="ASV") %>%
  left_join(taxtable) %>%
  filter(p.value<0.05) %>% View()
