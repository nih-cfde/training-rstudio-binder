# README

These data are a subset of the dataset from [Kozich et al. (2013)](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3753973/), Development of a dual-index sequencing strategy and curation pipeline for analyzing amplicon sequence data on the MiSeq Illumina sequencing platform, Applied and Environmental Microbiology, 79(17):5112-20. 

The data was downloaded from the [Schloss lab tutorial for Mauther](https://mothur.org/wiki/miseq_sop/) using the commands below and then uploaded to GitHub.

```
curl -O https://mothur.s3.us-east-2.amazonaws.com/wiki/miseqsopdata.zip
unzip miseqsopdata.zip
mv MiSeq_SOP MiSeq
```

The [Mauther tutorial](https://mothur.org/wiki/miseq_sop/) provides an overview of the total number of reads for each RNA sequencing sample. 

![numread](../images/MiSeq-readcount-Mothur.png)


Using UNIX commands, confirm that the R1 and R2 reads for each sample contain the number of reads listed in the image above.