###Recreating alpha diversity analysis (Shannon's, Observed Features)

#Load packages
library(phyloseq)
library(ape)
library(tidyverse)
library(picante)

#Load data
load("space_final_rare.RData")
samp_dat_wdiv <- data.frame(sample_data(space_final_rare), estimate_richness(space_final_rare))

####Alpha Diversity -Data Source####
### Shannon and Observed features analyses for Data Source
gg_richness_data_source <- plot_richness(space_final_rare, x= "data_source", measures = c("Shannon", "Observed")) +
  xlab("Data Source") +
  geom_boxplot()
gg_richness_data_source

#Kruskal-Wallis
alphadiv <- estimate_richness(space_final_rare) #richness and abundance
samp_dat <- sample_data(space_final_rare)
samp_dat_wdiv <- data.frame(samp_dat, alphadiv)

kruskal.test(Observed ~ `data_source`, data = samp_dat_wdiv)
kruskal.test(Shannon ~ `data_source`, data = samp_dat_wdiv)


######Alpha-Diversity - Mutated Isolation Source ####
#Shannon analysis for Mutated Isolation Source
gg_shannon_mutated_isolation_source <- plot_richness(space_final_rare, x= "mutated_isolation_source", measures = c("Shannon")) +
  xlab("Mutated Isolation Source") + ylab ("Shannon Diversity Index") + facet_wrap(.~data_source, scales = "free_x")+
  geom_boxplot()
gg_shannon_mutated_isolation_source

#Observed features
gg_observed_mutated_isolation_source <- plot_richness(space_final_rare, x= "mutated_isolation_source", measures = c("Observed")) +
  xlab("Mutated Isolation Source") + ylab ("ShannonFeatures") + facet_wrap(.~data_source, scales = "free_x")+
  geom_boxplot()
gg_observed_mutated_isolation_source

# 2-Way ANOVA 
ml_datasource_mutloc <- lm(Shannon ~ `data_source`*`mutated_isolation_source`, data=samp_dat_wdiv)
summary(aov(ml_datasource_mutloc))
TukeyHSD(aov(ml_datasource_mutloc))

obs_datasource_mutloc <- lm(Observed ~ `data_source`*`mutated_isolation_source`, data=samp_dat_wdiv)
summary(aov(obs_datasource_mutloc))
TukeyHSD(aov(ml_datasource_mutloc))

#### Beta diversity data source and isolation data source#####
wu_dm <- distance(space_final_rare, method="wunifrac")
pcoa_wu <- ordinate(space_final_rare, method="PCoA", distance=wu_dm)

gg_pcoa_data_source <-plot_ordination(space_final_rare, pcoa_wu, color = "data_source", shape = "data_source") + labs (col = "Data Source") + stat_ellipse(type = "norm")
gg_pcoa_data_source

gg_pcoa_isolation <-plot_ordination(space_final_rare, pcoa_wu, color = "isolation_data_source") + labs (col = "Isolation Source") + stat_ellipse(type = "norm")
gg_pcoa_isolation 

#PERMANOVA on the above matrix for weighted unifrac
adonis2(dm_unifrac ~ `isolation_data_source`, data=samp_dat_wdiv)
adonis2(dm_unifrac ~ `data_source`*mutated_isolation_source, data=samp_dat_wdiv)


#save
ggsave(filename = "plot_richness_data_source.png"
       , gg_richness_data_source
       , height=4, width=6, dpi = 300)

ggsave(filename = "plot_shannon_mutated_isolation_source.png"
       , gg_shannon_mutated_isolation_source
       , height=4, width=6,  dpi = 300)

ggsave(filename = "plot_observed_mutated_isolation_source.png"
       , gg_observed_mutated_isolation_source
       , height=4, width=6,  dpi = 300)

ggsave("plot_wu_pcoa_isolation_source.png"
       , gg_pcoa_isolation
       , height=4, width=7, dpi = 300)

ggsave("plot_wu_pcoa_data_source.png"
       , gg_pcoa_data_source
       , height=4, width=5, dpi = 300)

