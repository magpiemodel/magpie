#!/bin/bash

#SBATCH --qos=short
#SBATCH --job-name=mag-submit
#SBATCH --output=magpietest-%j.out
#SBATCH --mail-type=END

Rscript start_testruns.R 
