#!/bin/bash

#SBATCH --qos=short
#SBATCH --job-name=mag-run
#SBATCH --output=full.log
#SBATCH --mail-type=END
#SBATCH --partition=standard

Rscript submit.R

