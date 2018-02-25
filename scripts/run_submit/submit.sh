#!/bin/bash

#SBATCH --qos=short
#SBATCH --job-name=mag-run
#SBATCH --output=full.log
#SBATCH --mail-type=END
#SBATCH --cpus-per-task=2

Rscript submit.R

