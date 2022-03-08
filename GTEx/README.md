# README 

Data obtained from the SigCom LINCS site at https://maayanlab.cloud/sigcom-lincs/#/Download

After downloading data, only gene expression results from brain, breast, and heart were kept for teaching purposes.

```
curl -O https://lincs-dcic.s3.amazonaws.com/GTEx_AgeComparison_Tissue_Signatures.zip
unzip GTEx_AgeComparison_Tissue_Signatures.zip
mkdir data
cd GTEx_AgeComparison_Tissue_filtered
mv GTEx_Br* ../data
mv GTEx_Heart_20-29_vs_* ../data
rm -rf GTEx_AgeComparison_Tissue_*
```