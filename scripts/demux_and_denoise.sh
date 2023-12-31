#**data/qiime - location of the files**

#importing manifest file from local computer to server
scp hisease_manifest.txt root@10.19.139.170:/data
scp iss_manifest.txt root@10.19.139.170:/data
scp project_metadata.tsv root@10.19.139.170:/data

# importing the data using the created manifest, demultiplexing it, and creating a demux file 
qiime tools import \
  --type "SampleData[SequencesWithQuality]" \
  --input-format SingleEndFastqManifestPhred33V2 \
  --input-path /data/hisease_manifest.txt \
  --output-path ./demux_seqs.qza

# import ISS data using manifest, dumultiplexing it, outputting a demux file
qiime tools import \
  --type "SampleData[SequencesWithQuality]" \
  --input-format SingleEndFastqManifestPhred33V2 \
  --input-path /data/iss_manifest.txt \
  --output-path ./demux_seqs.qza


# converting the file from qza to qzv to view the contents 
qiime demux summarize \
  --i-data demux_seqs.qza \
  --o-visualization demux_seqs.qzv

# move file from server to personal computer
scp root@10.19.139.170:/data/qiime/demux_seqs.qzv .
scp root@10.19.139.170:/data/space_project/hiseas/demux_seqs_hiseas.qzv .
scp root@10.19.139.170:/data/space_project/iss_qiime/demux_seqs_iss.qzv .

# denoise data using dada2; trim sequences using the value obtained from the demux_seqs.qzv visualisation on https://view.qiime2.org/
# nothing was trimmed on the left; 293 was used as trim parameter for the right
qiime dada2 denoise-single \
  --i-demultiplexed-seqs demux_seqs.qza \
  --p-trim-left 0 \
  --p-trunc-len 292 \
  --o-representative-sequences rep-seqs.qza \
  --o-table table.qza \
  --o-denoising-stats stats.qza

# denoise for ISS data
qiime dada2 denoise-single \
  --i-demultiplexed-seqs demux_seqs.qza \
  --p-trim-left 0 \
  --p-trunc-len 150 \
  --o-representative-sequences rep-seqs.qza \
  --o-table table.qza \
  --o-denoising-stats stats.qza

# Merging ISS and HI-SEAS table.qza and rep-seqs.qza files together
qiime feature-table merge \
  --i-tables /data/space_project/iss/table_iss.qza \
  --i-tables /data/space_project/hiseas/table_hiseas.qza \
  --o-merged-table table_iss_hiseas.qza
qiime feature-table merge-seqs \
  --i-data /data/space_project/iss/rep-seqs_iss.qza \
  --i-data /data/space_project/hiseas/rep-seqs_hiseas.qza \
  --o-merged-data rep-seqs_iss_hiseas.qza

# Visualize ASVs stats
qiime feature-table summarize \
  --i-table table_iss_hiseas.qza \
  --o-visualization table_iss_hiseas.qzv \
  --m-sample-metadata-file /data/project_metadata.tsv
  
qiime feature-table tabulate-seqs \
  --i-data rep-seqs_iss_hiseas.qza \
  --o-visualization rep-seqs_iss_hiseas.qzv

#transferring files over from server to personal computer
scp root@10.19.139.170:/data/space_project/combined_iss_hiseas/table_iss_hiseas.qzv .
scp root@10.19.139.170:/data/space_project/combined_iss_hiseas/rep-seqs_iss_hiseas.qzv .
