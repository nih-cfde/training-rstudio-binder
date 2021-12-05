#!/bin/bash
curl -O https://www.gutenberg.org/files/98/98-0.txt 
mv 98-0.txt book.txt
curl -O https://www.gutenberg.org/files/98/98-0.txt 
mv 98-0.txt A-tale-of-two-cities.txt
curl -O https://www.gutenberg.org/files/11/11-0.txt 
mv 11-0.txt  Alice_in_wonderland.txt
curl -O https://www.gutenberg.org/files/16/16-0.txt 
mv 16-0.txt  PeterPan.txt
curl -O https://www.gutenberg.org/files/55/55-0.txt
mv 55-0.txt TheWonderfulWizardOfOz.txt
gzip TheWonderfulWizardOfOz.txt