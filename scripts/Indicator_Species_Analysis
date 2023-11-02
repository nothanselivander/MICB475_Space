###ISA###
library(indicspecies)
mpt_genus <- tax_glom(mpt_final, "Genus", NArm = FALSE)
mpt_genus_RA <- transform_sample_counts(mpt_genus, fun=function(x) x/sum(x))

#based on data_source (hiseas vs iss)
isa_data_source <- multipatt(t(otu_table(mpt_genus_RA)), cluster = sample_data(mpt_genus_RA)$data_source)
summary(isa_data_source)
taxtable <- tax_table(mpt_final) %>% as.data.frame() %>% rownames_to_column(var="ASV")
isa_data_source$sign %>%
  rownames_to_column(var="ASV") %>%
  left_join(taxtable) %>%
  filter(p.value<0.05) %>% View()

#based on mutated_isolation_source
isa_mutated_isolation_source <- multipatt(t(otu_table(mpt_genus_RA)), cluster = sample_data(mpt_genus_RA)$mutated_isolation_source)
summary(isa_mutated_isolation_source)
isa_mutated_isolation_source$sign %>%
  rownames_to_column(var="ASV") %>%
  left_join(taxtable) %>%
  filter(p.value<0.05) %>% View()

#based on isolation_data_source
isa_isolation_data_source <- multipatt(t(otu_table(mpt_genus_RA)), cluster = sample_data(mpt_genus_RA)$isolation_data_source)
summary(isa_isolation_data_source)
isa_isolation_data_source$sign %>%
  rownames_to_column(var="ASV") %>%
  left_join(taxtable) %>%
  filter(p.value<0.05) %>% View()
