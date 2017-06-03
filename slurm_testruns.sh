#!/bin/bash

#SBATCH --qos=short
#SBATCH --job-name=mag-submit
#SBATCH --output=magpietest-%j.out
#SBATCH --mail-type=END
#SBATCH --mem-per-cpu=32000

Rscript start_testruns.R 
