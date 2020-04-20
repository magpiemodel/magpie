#!/bin/bash

#SBATCH --qos=medium
#SBATCH --job-name=mag-run
#SBATCH --output=full.log
#SBATCH --mail-type=END
#SBATCH --cpus-per-task=3
#SBATCH --partition=standard

Rscript submit.R
