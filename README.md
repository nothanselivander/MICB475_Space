# MICB475_Space

### Team Meetings

#### October 5
##### Agenda for Team Meeting 
* Discuss and evaluate the datasets we have available for the ISS
* Review project proposal guidelines 
* Discuss what aim/s and question/s we would like to investigate
* Deciding if we'll push through with abiotic surfaces 
* Discuss how we'll compare the HI-SEAS and dataset/s of choice (i.e. by what metrics)
* Start formatting README file
##### Meeting Minutes 
Discussed locations, materials as potential comparison categories
Discussed combining ISS and Hi-SEAS datasets
* find what terminology means in ISS dataset (eg node)
* discussed combining columns
  
Create 2 files
* Manifest
* Revised metadata file (potentially combining both Hi-SEAS and ISS data)

Come up with aims for next team meeting 

#### October 11
##### Meeting Minutes
Planning on merging ISS and HI-SEAS data

Removing the human swab samples

Deciding on columns to be kept

HI-SEAS
* #SampleID
* collection_device
* collection_timestamp
* orig_env_material

ISS
* sample-id
* collection_date
* isolation_source
* library name
* samp_collect_device

Agreeing on common terminology for locations of samples

Matching up locations based on purpose
* waste & hygiene compartment on ISS = toilet for HI-SEAS
* kitchen counter on Hi-SEAS = dining table Node 1 on ISS

Drafted potential research objectives and experimental aims - recorded on proposal document

#### October 12
##### Agenda for Team Meeting 
* Go over research objectives and experimental aims

    Aim 1: General Diversity Comparison
        Aim 1 combines both alpha and beta diversity to compare the overall diversity across datasets. Remove sub-aim 1.
        
    Aim 2: Abiotic Surface Nuances
        In Aim 2, delve into the nuances of abiotic surfaces and compare microbial diversity.
    
    Aim 3: Location-Specific Analysis
        Include taxonomic information through core microbiome analysis and taxa bar plots. Create a Venn diagram for visualization.

    Aim 4: General and Location Comparison
        Introduce indicator taxa analysis. Ideally, we should get very few unique results which indicates both locations have a lot in common.
        Validate findings through differential abundance analysis, which focuses on shared species and their abundance. 

* Consult about changes made to metadata files (data removed, data columns merged, etc)

    The columns we kept are good.
    Before we trim in the denoising, we need to send Evelyn the demux file to check the quality score and then she will help us determine the trimming parameters.
    Rarefraction analysis will be done after our proposal. 

 #### October 13
 * demux file confirmed received
 * 293 confirmed as good right trim parameter
 * denoise started
