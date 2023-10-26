# Extract the amplicon of interest from the reference database
qiime feature-classifier extract-reads \
  --i-sequences ~/data/silva/silva-138-99-seqs.qza \
  --p-f-primer AGRGTTTGATCMTGGCTCAG \
  --p-r-primer GGWTACCTTGTTACGACTT \
  --p-trunc-len 292 \
  --o-reads ref-seqs-trimmed.qza

# Train classifier with your new ref-seq file
qiime feature-classifier fit-classifier-naive-bayes \
  --i-reference-reads ref-seqs-trimmed.qza \
  --i-reference-taxonomy ~/data/silva/silva-138-99-tax.qza \
  --o-classifier classifier.qza

# Use the trained classifier to assign taxonomy to your reads (rep-seqs.qza)
qiime feature-classifier classify-sklearn \
  --i-classifier classifier.qza \
  --i-reads ~/data/space_project/combined_iss_hiseas/rep-seqs_iss_hiseas.qza \
  --o-classification taxonomy.qza

qiime taxa filter-table \
  --i-table ~/data/space_project/combined_iss_hiseas/table_iss_hiseas.qza \
  --i-taxonomy taxonomy.qza \
  --p-exclude mitochondria,chloroplast \
  --o-filtered-table table-no-mitochondria-no-chloroplast.qza
  
qiime feature-table summarize \
  --i-table table-no-mitochondria-no-chloroplast.qza \
  --o-visualization table-no-mitochondria-no-chloroplast.qzv \
  --m-sample-metadata-file ~/data/project_metadata.tsv

# Generate a tree for phylogenetic diversity analyses
qiime phylogeny align-to-tree-mafft-fasttree \
  --i-sequences ~/data/space_project/combined_iss_hiseas/rep-seqs_iss_hiseas.qza \
  --o-alignment aligned-rep-seqs.qza \
  --o-masked-alignment masked-aligned-rep-seqs.qza \
  --o-tree unrooted-tree.qza \
  --o-rooted-tree rooted-tree.qza 

qiime diversity alpha-rarefaction \
  --i-table ~/data/space_project/combined_iss_hiseas/table_iss_hiseas.qza \
  --i-phylogeny rooted-tree.qza \
  --p-max-depth 20810 \
  --m-metadata-file ~/data/project_metadata.tsv \
  --o-visualization alpha-rarefaction.qzv
