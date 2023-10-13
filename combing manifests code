library(tidyverse)

hisease_mani <- "hiseas_manifest.txt"
hisease <- read_delim(file=hisease_mani, delim="\t")

space_mani <- "space_station_manifest.txt"
space <- read_delim(file=space_mani, delim="\t")

hisease$`sample-id`<-gsub(".fastq.gz","",as.character(hisease$`sample-id`))

hisease_space_manifest <- rbind(space, hisease)

write.csv(hisease_space_manifest, "hisease_space_manifest.csv", row.names=FALSE)
