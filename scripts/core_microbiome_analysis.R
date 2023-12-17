#load packages
library(phyloseq)
library(tidyverse)
library(microbiome)
library(ggVennDiagram)


#load in already prepared relevant RData
load("space_project_final.RData")

iss_hiseas_RA <- transform_sample_counts(mpt_final, fun=function(x) x/sum(x))

#### Data Source ####

# Subset dataset into ISS and HISEAS
iss_data <- subset_samples(iss_hiseas_RA, data_source == "iss")
hiseas_data <- subset_samples(iss_hiseas_RA, data_source == "hiseas")

# Set a prevalence threshold and abundance threshold. Be prepared to justify
hiseas_ASVs <- core_members(hiseas_data, detection=0, prevalence = 0)
iss_ASVs <- core_members(iss_data, detection=0, prevalence = 0)

# Make a Venn-diagram
data_source_venn_diagram <- ggVennDiagram(x=list(HISEAS = hiseas_ASVs, ISS = iss_ASVs))
data_source_venn_diagram

ggsave("Data_Source_d0_p0.png"
       , data_source_venn_diagram
       , height=4, width=5)

#### Mutated Isolation Source ####

# Subset dataset into isolation sources (not differentiated by data source)
lab_equipment_data <- subset_samples(iss_hiseas_RA, mutated_isolation_source == "lab_equipment")
bed_room_and_common_area_data <- subset_samples(iss_hiseas_RA, mutated_isolation_source == "bed_room_and_common_area")
sanitary_station_data <- subset_samples(iss_hiseas_RA, mutated_isolation_source == "sanitary_station")
kitchen_and_dining_area_data <- subset_samples(iss_hiseas_RA, mutated_isolation_source == "kitchen_and_dining_area")

# Set a prevalence threshold and abundance threshold
lab_equipment_ASVs <- core_members(lab_equipment_data, detection=0, prevalence = 0)
bed_room_and_common_area_ASVs <- core_members(bed_room_and_common_area_data, detection=0, prevalence = 0)
kitchen_and_dining_area_ASVs <- core_members(kitchen_and_dining_area_data, detection=0, prevalence = 0)
sanitary_station_ASVs <- core_members(sanitary_station_data, detection=0, prevalence = 0)

# Make a Venn-diagram
mutated_isolation_source_venn_diagram <- ggVennDiagram(x=list(Lab_Equipment = lab_equipment_ASVs, Bed_Room_and_Common_Area = bed_room_and_common_area_ASVs, Kitchen_and_Dining_Area = kitchen_and_dining_area_ASVs, Sanitary_Station = sanitary_station_ASVs))
mutated_isolation_source_venn_diagram

#### Isolation Source ####

# Subset dataset into isolation sources 
lab_equipment_iss_data <- subset_samples(iss_hiseas_RA, isolation_data_source == "lab_equipment_iss")
bed_room_and_common_area_iss_data <- subset_samples(iss_hiseas_RA, isolation_data_source == "bed_room_and_common_area_iss")
sanitary_station_iss_data <- subset_samples(iss_hiseas_RA, isolation_data_source == "sanitary_station_iss")
kitchen_and_dining_area_iss_data <- subset_samples(iss_hiseas_RA, isolation_data_source == "kitchen_and_dining_area_iss")
lab_equipment_hiseas_data <- subset_samples(iss_hiseas_RA, isolation_data_source == "lab_equipment_hiseas")
bed_room_and_common_area_hiseas_data <- subset_samples(iss_hiseas_RA, isolation_data_source == "bed_room_and_common_area_hiseas")
sanitary_station_hiseas_data <- subset_samples(iss_hiseas_RA, isolation_data_source == "sanitary_station_hiseas")
kitchen_and_dining_area_hiseas_data <- subset_samples(iss_hiseas_RA, isolation_data_source == "kitchen_and_dining_area_hiseas")

# Set a prevalence threshold and abundance threshold
lab_equipment_iss_ASVs <- core_members(lab_equipment_iss_data, detection=0, prevalence = 0)
bed_room_and_common_area_iss_ASVs <- core_members(bed_room_and_common_area_iss_data, detection=0, prevalence = 0)
kitchen_and_dining_area_iss_ASVs <- core_members(kitchen_and_dining_area_iss_data, detection=0, prevalence = 0)
sanitary_station_iss_ASVs <- core_members(sanitary_station_iss_data, detection=0, prevalence = 0)
lab_equipment_hiseas_ASVs <- core_members(lab_equipment_hiseas_data, detection=0, prevalence = 0)
bed_room_and_common_area_hiseas_ASVs <- core_members(bed_room_and_common_area_hiseas_data, detection=0, prevalence = 0)
kitchen_and_dining_area_hiseas_ASVs <- core_members(kitchen_and_dining_area_hiseas_data, detection=0, prevalence = 0)
sanitary_station_hiseas_ASVs <- core_members(sanitary_station_hiseas_data, detection=0, prevalence = 0)

# Make a Venn-diagram
isolation_source_iss_venn_diagram <- ggVennDiagram(x=list(Lab_Equipment_ISS = lab_equipment_iss_ASVs, Bed_Room_and_Common_Area_ISS = bed_room_and_common_area_iss_ASVs, Kitchen_and_Dining_Area_ISS = kitchen_and_dining_area_iss_ASVs, Sanitary_Station_ISS = sanitary_station_iss_ASVs))
isolation_source_hiseas_venn_diagram <- ggVennDiagram(x=list(Lab_Equipment_HISEAS = lab_equipment_hiseas_ASVs, Bed_Room_and_Common_Area_HISEAS = bed_room_and_common_area_hiseas_ASVs, Kitchen_and_Dining_Area_HISEAS = kitchen_and_dining_area_hiseas_ASVs, Sanitary_Station_HISEAS = sanitary_station_hiseas_ASVs))
isolation_source_hiseas_venn_diagram
isolation_source_iss_venn_diagram


ggsave("Isolation_Source_ISS_d0_p0.png"
       , isolation_source_iss_venn_diagram 
       , height=4, width=5)

ggsave("Isolation_Source_HISEAS_d0_p0.png"
       , isolation_source_hiseas_venn_diagram 
       , height=4, width=5)

isolation_source_bed_room_and_common_area_venn_diagram <- ggVennDiagram(x=list(Bed_Room_and_Common_Area_ISS = bed_room_and_common_area_iss_ASVs, Bed_Room_and_Common_Area_HISEAS = bed_room_and_common_area_hiseas_ASVs))
isolation_source_bed_room_and_common_area_venn_diagram

# Make sure that you have a line that saves the Venn diagram as a png and this file is present within your project folder
ggsave("VennDiagram.png"
       , gg_venn_diagram
       , height=4, width=5)
