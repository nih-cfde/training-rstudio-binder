# README 

Open the `GETx.Rproj` file to set the working directory to `~/GTEx`.

The RNA-seq counts were imported into R using recount3 and processed using the script `./scripts/recount3.Rmd`.

The files containing the results of a differential gene expression analysis were obtained from the SigCom LINCS site at https://maayanlab.cloud/sigcom-lincs/#/Download. After downloading data, only gene expression results from brain, breast, and heart were kept for teaching purposes.

```
curl -O https://lincs-dcic.s3.amazonaws.com/GTEx_AgeComparison_Tissue_Signatures.zip
unzip GTEx_AgeComparison_Tissue_Signatures.zip
mkdir data/
cd GTEx_AgeComparison_Tissue_filtered
mv GTEx_Br* data/
mv GTEx_Heart_20-29_vs_* data/
rm -rf GTEx_AgeComparison_Tissue_*
```

The workshop notes for using this repository to teach an Introduction to R for RNA-seq are crated with the file `r4rnaseq-workshop.Rmd`. After knitting to markdown, the script `cleanmd.sh` is run to convert some of the html output to HackMd formatting. The lesson notes can be viewed at <https://hackmd.io/@raynamharris/r4rnaseq-workshop>.