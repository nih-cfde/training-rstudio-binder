# Books

These books were downloaded from [Project Gutenberg](https://www.gutenberg.org/ebooks/) using the following commands. 

```
curl https://www.gutenberg.org/files/98/98-0.txt -o book.txt
curl https://www.gutenberg.org/files/98/98-0.txt -o A-tale-of-two-cities.txt
curl https://www.gutenberg.org/files/11/11-0.txt -o Alice_in_wonderland.txt
curl https://www.gutenberg.org/files/16/16-0.txt -o PeterPan.txt
curl https://www.gutenberg.org/files/55/55-0.txt -o WizardOfOz.txt
gzip WizardOfOz.txt
```

Try using UNIX commands to answer the following questions?

- How many lines of text are in each book? 
- What are the chapter titles for each book?
- What sentences start with "The"?

Additionally, a file containing all the protein-coding genes in the yeast, _Saccharomyces cerevisiae_, genome were downloaded and saved using the following command. This file can be used to illustrate the utility of the UNIX command `find` to find files in unlikely places. 

```
curl http://ftp.ensembl.org/pub/release-105/fasta/saccharomyces_cerevisiae/cds/Saccharomyces_cerevisiae.R64-1-1.cds.all.fa.gz -o yeast.fasta

```