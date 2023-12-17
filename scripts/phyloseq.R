#within~/data/ 
mkdir space_export

#export table.qza
qiime tools export \
--input-path /data/qiime/table.qza \
--output-path table_export 

#convert biome to txt (within the table_export file)
biom convert \
-i feature-table.biom \
--to-tsv \
-o feature-table.txt

#import convert taxonomy.qza
qiime tools export \
--input-path /data/qiime/taxonomy.qza \
--output-path taxonomy_export 

#import convert rooted-tree.qza
qiime tools export \
--input-path /data/qiime/rooted-tree.qza \
--output-path rooted_tree_expor

mv rooted_tree_expor/ rooted_tree_export/


#transfer to local computer
scp -r root@10.19.139.170:/data/space_export .

scp root@10.19.139.170:/data/project_metadata.tsv .



----- #corrected code

#export table.qza
qiime tools export \
--input-path /data/space_project/combined_iss_hiseas/table_iss_hiseas.qza \
--output-path table_export_correct

biom convert \
-i feature-table.biom \
--to-tsv \
-o feature-table.txt

scp -r root@10.19.139.170:/data/space_export/table_export_correct .

