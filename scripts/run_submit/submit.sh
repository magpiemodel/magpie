#!/bin/bash

#SBATCH --qos=priority
#SBATCH --job-name=mag-run
#SBATCH --output=full.log
#SBATCH --mail-type=END
#SBATCH --cpus-per-task=12
#SBATCH --partition=standard
#SBATCH --mem=32000

Rscript submit.R

