library(phyloseq)
library(microbiome)
library(ggVennDiagram)

space_RA <- transform_sample_counts(mpt_final, fun=function(x) x/sum(x))

#filter data by data_source
space_iss <- subset_samples(space_RA, data_source == "iss")
space_hiseas <- subset_samples(space_RA, data_source == "hiseas")

iss_ASVs <- core_members(space_iss, detection=0, prevalence = 0)
hiseas_ASVs <- core_members(space_hiseas, detection=0, prevalence = 0)

data_source_venn <- ggVennDiagram(x=list(HISEAS = hiseas_ASVs, ISS = iss_ASVs))
data_source_venn

ggsave("Data_Source.png"
       , data_source_venn
       , height=4, width=5)
#
#
#
#filter data by isolation_data_source
space_lab_equipment_iss <- subset_samples(space_RA, isolation_data_source == "lab_equipment_iss")
space_bed_room_and_common_area_iss <- subset_samples(space_RA, isolation_data_source == "bed_room_and_common_area_iss")
space_sanitary_station_iss <- subset_samples(space_RA, isolation_data_source == "sanitary_station_iss")
space_kitchen_and_dining_area_iss <- subset_samples(space_RA, isolation_data_source == "kitchen_and_dining_area_iss")
space_lab_equipment_hiseas <- subset_samples(space_RA, isolation_data_source == "lab_equipment_hiseas")
space_bed_room_and_common_area_hiseas <- subset_samples(space_RA, isolation_data_source == "bed_room_and_common_area_hiseas")
space_sanitary_station_hiseas <- subset_samples(space_RA, isolation_data_source == "sanitary_station_hiseas")
space_kitchen_and_dining_area_hiseas <- subset_samples(space_RA, isolation_data_source == "kitchen_and_dining_area_hiseas")


lab_equipment_iss_ASVs <- core_members(space_lab_equipment_iss, detection=0, prevalence = 0)
bed_room_and_common_area_iss_ASVs <- core_members(space_bed_room_and_common_area_iss, detection=0, prevalence = 0)
sanitary_station_iss_ASVs <- core_members(space_sanitary_station_iss, detection=0, prevalence = 0)
kitchen_and_dining_area_iss_ASVs <- core_members(space_kitchen_and_dining_area_iss, detection=0, prevalence = 0)
lab_equipment_hiseas_ASVs <- core_members(space_lab_equipment_hiseas, detection=0, prevalence = 0)
bed_room_and_common_area_hiseas_ASVs <- core_members(space_bed_room_and_common_area_hiseas, detection=0, prevalence = 0)
sanitary_station_hiseas_ASVs <- core_members(space_sanitary_station_hiseas, detection=0, prevalence = 0)
kitchen_and_dining_area_hiseas_ASVs <- core_members(space_kitchen_and_dining_area_hiseas, detection=0, prevalence = 0)


isolation_data_source_iss_venn <- ggVennDiagram(x=list(Lab_Equipment_ISS = lab_equipment_iss_ASVs, Bed_Room_and_Common_Area_ISS = bed_room_and_common_area_iss_ASVs, Kitchen_and_Dining_Area_ISS = kitchen_and_dining_area_iss_ASVs, Sanitary_Station_ISS = sanitary_station_iss_ASVs))
isolation_data_source_hiseas_venn <- ggVennDiagram(x=list(Lab_Equipment_HISEAS = lab_equipment_hiseas_ASVs, Bed_Room_and_Common_Area_HISEAS = bed_room_and_common_area_hiseas_ASVs, Kitchen_and_Dining_Area_HISEAS = kitchen_and_dining_area_hiseas_ASVs, Sanitary_Station_HISEAS = sanitary_station_hiseas_ASVs))
isolation_data_source_hiseas_venn
isolation_data_source_iss_venn

ggsave("Isolation_Data_Source_HISEAS.png"
       , isolation_data_source_hiseas_venn
       , height=4, width=5)

ggsave("Isolation_Data_Source_ISS.png"
       , isolation_data_source_iss_venn
       , height=4, width=5)
#
#
#
#filter data by mutated_isolation_source

space_lab_equipment <- subset_samples(space_RA, mutated_isolation_source == "lab_equipment")
space_bed_room_and_common_area <- subset_samples(space_RA, mutated_isolation_source == "bed_room_and_common_area")
space_sanitary_station <- subset_samples(space_RA, mutated_isolation_source == "sanitary_station")
space_kitchen_and_dining_area <- subset_samples(space_RA, mutated_isolation_source == "kitchen_and_dining_area")


lab_equipment_ASVs <- core_members(space_lab_equipment, detection=0, prevalence = 0)
bed_room_and_common_area_ASVs <- core_members(space_bed_room_and_common_area, detection=0, prevalence = 0)
sanitary_station_ASVs <- core_members(space_sanitary_station, detection=0, prevalence = 0)
kitchen_and_dining_area_ASVs <- core_members(space_kitchen_and_dining_area, detection=0, prevalence = 0)

mutated_isolation_source_venn <- ggVennDiagram(x=list(Lab_Equipment = lab_equipment_ASVs, Bed_Room_and_Common_Area = bed_room_and_common_area_ASVs, Kitchen_and_Dining_Area = kitchen_and_dining_area_ASVs, Sanitary_Station = sanitary_station_ASVs))
mutated_isolation_source_venn

ggsave("Mutated_Isolation_Source.png"
       , mutated_isolation_source_venn
       , height=4, width=5)
