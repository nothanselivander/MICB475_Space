library(tidyverse)

####READ FILES####
hiseas_md_fp <- "hiseas_metadata.csv"
hiseas_md <- read.delim(hiseas_md_fp, sep=',')

iss_md_fp <- "iss_metadata.csv"
iss_md <- read.delim(iss_md_fp, sep=',')

###HISEAS_MD DATA WRANGLING####
hiseas_md <- unite(hiseas_md, col="collection_date", c('sampling_year', 'sampling_month', 'sampling_day'), sep="-", remove=TRUE) 
  
hiseas_md <- hiseas_md[hiseas_md$description %in% c('bed_room', 'kitchen_counter', 'main_room', 'toilet_bowl', 'PCR-NC'),] %>% 
  select(c('X.SampleID','description','collection_date','material', 'collection_device')) %>%
  rename("sample_id"="X.SampleID", "isolation_source"="description", "samp_collect_device"="collection_device") %>%
  mutate(data_source="hiseas")

hiseas_md<-hiseas_md %>%
  mutate(mutated_isolation_source = case_when (
    (hiseas_md$isolation_source == "bed_room" ) ~ "bed_room_and_common_area",
    (hiseas_md$isolation_source == "main_room" ) ~ "bed_room_and_common_area",
    (hiseas_md$isolation_source == "toilet_bowl") ~ "sanitary_station",
    (hiseas_md$isolation_source == "kitchen_counter" ) ~ "kitchen_and_dining_area",
    (hiseas_md$isolation_source == "PCR-NC" ) ~ "lab_equipment"
  ))

hiseas_md <- mutate(hiseas_md, isolation_data_source = paste(mutated_isolation_source, data_source, sep="_"))

hiseas_md$`sample_id`<-gsub(".fastq.gz","",as.character(hiseas_md$`sample_id`))

###ISS_MD DATA WRANGLING####
iss_md$`isolation_source` <- gsub("\\\\", "",as.character(iss_md$`isolation_source`))

iss_md <- subset(iss_md, isolation_source != "International Space Station, environmental surface") %>% 
  select(c('sample.id','collection_date','isolation_source','Library.Name', 'samp_collect_device')) %>%
  rename("sample_id"="sample.id", "library_name" = "Library.Name") %>%
  mutate(data_source="iss") 

iss_md<-iss_md %>%
  mutate (mutated_isolation_source = case_when (
    (iss_md$isolation_source == "Advanced resistive exercise device (ARED) foot platform Node 3" ) ~ "bed_room_and_common_area",
    (iss_md$isolation_source == "Port crew quarters, bump out exterior aft wall Node 2" ) ~ "bed_room_and_common_area",
    (iss_md$isolation_source == "Port panel next to cupola Node 3" ) ~ "bed_room_and_common_area",
    (iss_md$isolation_source == "Waste and hygiene compartment Node 3 'F4'") ~ "sanitary_station",
    (iss_md$isolation_source == "Dining table Node 1" ) ~ "kitchen_and_dining_area",
    (iss_md$isolation_source == "Overhead 4 Node 1" ) ~ "kitchen_and_dining_area",
    (iss_md$isolation_source == "Lab 3 overhead LAB" ) ~ "lab_equipment"
  ))

iss_md <- mutate(iss_md, isolation_data_source = paste(mutated_isolation_source,data_source, sep="_"))

####COMBINE MD####
combined_md <- bind_rows(iss_md,hiseas_md)
samples <- as.data.frame(combined_md$sample_id)

####SAVE METADATA AS TSV####
write.table(combined_md, file='hiseas_iss_md.tsv', row.names = FALSE, sep='\t')
write.table(samples, file = "samples.tsv", row.names=FALSE, sep="\t")
  





