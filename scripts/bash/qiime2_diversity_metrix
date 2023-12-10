 # Calculate alpha- and beta-diversity metrics
qiime diversity core-metrics-phylogenetic \
  --i-phylogeny ~/data/qiime/rooted-tree.qza \
  --i-table ~/data/qiime/table-no-mitochondria-no-chloroplast.qza \
  --p-sampling-depth 20810 \
  --m-metadata-file ~/data/project_metadata.tsv \
  --output-dir core-metrics-results

# Calculate alpha-group-significance
qiime diversity alpha-group-significance \
  --i-alpha-diversity faith_pd_vector.qza \
  --m-metadata-file ~/data/project_metadata.tsv \
  --o-visualization faith-pd-group-significance.qzv

qiime diversity alpha-group-significance \
  --i-alpha-diversity evenness_vector.qza \
  --m-metadata-file ~/data/project_metadata.tsv \
  --o-visualization evenness-group-significance.qzv
  
# Calculate beta-group-significance
qiime diversity beta-group-significance \
  --i-distance-matrix unweighted_unifrac_distance_matrix.qza \
  --m-metadata-file ~/data/project_metadata.tsv \
  --m-metadata-column mutated_isolation_source \
  --o-visualization unweighted-unifrac-mutated-isolation-source-significance.qzv \
  --p-pairwise

qiime diversity beta-group-significance \
  --i-distance-matrix unweighted_unifrac_distance_matrix.qza \
  --m-metadata-file ~/data/project_metadata.tsv \
  --m-metadata-column isolation_data_source \
  --o-visualization unweighted-unifrac-isolation-data-source-group-significance.qzv \
  --p-pairwise

  qiime diversity beta-group-significance \
  --i-distance-matrix unweighted_unifrac_distance_matrix.qza \
  --m-metadata-file ~/data/project_metadata.tsv \
  --m-metadata-column data_source \
  --o-visualization unweighted-unifrac-data-source-group-significance.qzv \
  --p-pairwise
