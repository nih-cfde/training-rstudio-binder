#!/bin/bash

# replaces the html formatting output with hackmd friendly formatting for callout boxes

sed -i -e 's/<div class="info">/:::info/g' r4rnaseq-workshop.md
sed -i -e 's/<div class="success">/:::success/g' r4rnaseq-workshop.md
sed -i -e 's/<div class="warning">/:::warning/g' r4rnaseq-workshop.md
sed -i -e 's/<div class="spoiler">/:::spoiler/g' r4rnaseq-workshop.md

sed -i -e 's|</div>|:::|g' r4rnaseq-workshop.md 

rm r4rnaseq-workshop.md-e