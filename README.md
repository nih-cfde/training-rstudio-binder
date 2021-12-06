# training-rstudio-binder

This repository holds the files to create a custom computing environment that has all the data and software needed for [Binder](https://mybinder.org/). 

Click the [![Binder](https://binder.pangeo.io/badge_logo.svg)](https://mybinder.org/v2/gh/nih-cfde/training-rstudio-binder/data?urlpath=rstudio) to generate a Binder from the `data` branch of this repository.

<!--  Commenting out Binders on other branches 

- [![Binder](https://binder.pangeo.io/badge_logo.svg)](https://binder.pangeo.io/v2/gh/nih-cfde/training-rstudio-binder/basic-rstudio?urlpath=rstudio) This binder on the `basic-rstudio` branch has only has R installed:



- [![Binder](https://binder.pangeo.io/badge_logo.svg) This binder on the `rstudio-snakemake-workflow`branch has R, snakemake-minimal, and some variant calling software installed:


- [![Binder](https://binder.pangeo.io/badge_logo.svg) This binder on the`conda-workshop-march2021`branch has Rstudio, and includes example code files for conda workshop:


## Adding new binders *from this repo*

**For CFDE trainers:** if you'd like to build a new Rstudio binder with other installations from this repo - 

1) create a new branch
2) edit `environment.yml` file in the [./binder](./binder) directory
3) build a [new pangeo binder](https://binder.pangeo.io/) - remember to enter the correct Github branch!

![](./images/rstudio-binder-setup.png)

4) add the binder badge + brief description to this readme doc (including the repo branch)

**Important reminders:**

- `r-base` or some r package (e.g., `r-ggplot2`) needs to be in the `environment.yml` file so that R is installed during binder build
- in the pangeo binder form:
  - specify Github branch to point binder to
  - change "Path to a notebook file (optional)" dropdown to "URL" from "File". Type `rstudio` so the binder opens Rstudio.
- do not merge branches to `main` or delete branches that existing binders are pointing to, otherwise those binders will not work anymore!

-->
