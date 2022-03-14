#!/bin/bash

# replace html formatting with hackmd formatting

#replace '<div class="info">' ':::info' -- ./r4rnaseq-workshop.md
#replace '<div class="success">' ':::success' -- ./r4rnaseq-workshop.md
#replace '<div class="warning">' ':::warning' -- ./r4rnaseq-workshop.md
#replace '</div>' ':::' -- ./r4rnaseq-workshop.md

sed -i -e 's/<div class="info">/:::info/g' r4rnaseq-workshop.md
sed -i -e 's/<div class="success">/:::success/g' r4rnaseq-workshop.md
sed -i -e 's/<div class="warning">/:::warning/g' r4rnaseq-workshop.md
sed -i -e 's|</div>|:::|g' r4rnaseq-workshop.md 
