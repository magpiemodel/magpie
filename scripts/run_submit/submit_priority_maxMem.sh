#!/bin/bash

#SBATCH --qos=priority
#SBATCH --job-name=mag-run
#SBATCH --output=full.log
#SBATCH --mail-type=END
#SBATCH --cpus-per-task=16
#SBATCH --mem-per-cpu=0
#SBATCH --partition=priority

Rscript submit.R
