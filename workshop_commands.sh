## SET UP
# set up conda and initialize settings
source $(conda info --base)/etc/profile.d/conda.sh
conda init
conda config --set auto_activate_base false

# shorten command prompt to $
echo "PS1='\w $ '" >> .bashrc

# re-start terminal for the changes to take effect (i.e., type 'exit' and then open a new terminal)

# activate base environment
conda activate base

# configure conda channels
conda config --show channels
conda list

# add bioconda channel
conda config --prepend channels bioconda
# check out channel priority changes
conda config --get channels
# add conda-forge channel
conda config --prepend channels https://conda.anaconda.org/conda-forge
# check out channel priority changes
conda config --get channels

## INSTALL SOFTWARE and CREATE CONDA ENVIRONMENTS
# search for software
conda search fastqc

# create conda environment and install fastqc
conda create -y --name fqc fastqc

# activate environment
conda activate fqc

# check fastqc version
fastqc --version

# Method 1: install software in existing environment
conda install -y trimmomatic=0.36
conda list # check installed software

# Method 2: install both software during environment creation
echo $PATH # check path for fqc environment
conda deactivate
conda create -y --name fqc_trim fastqc trimmomatic=0.36
conda activate fqc_trim 
conda list # check installed software
echo $PATH # check path for fqc_trim environment

# Method 3: specify software to install with a YAML file
conda deactivate
# click on test.yml in file directory to see how it is formatted
conda env create -f test.yml #since environment name specified in yml file, we do not need to use -n flag here
conda activate qc_yaml
conda list  # check installed software

# Look at conda environments 
conda env list

## FastQC DEMO
# activate environment
conda activate fqc

# check fastqc installed
fastqc --help

# Download data
curl -L https://osf.io/5daup/download -o ERR458493.fastq.gz

# Checkout the data!
# line count
gunzip -c ERR458493.fastq.gz | wc -l

# top of file
gunzip -c ERR458493.fastq.gz | head

# Run FastQC!
fastqc ERR458493.fastq.gz

## CLEANING UP
# to remove old conda environments
conda env remove --name fqc_trim










