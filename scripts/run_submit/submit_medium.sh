#!/bin/bash

#SBATCH --qos=medium
#SBATCH --job-name=mag-run
#SBATCH --output=slurm.log
#SBATCH --mail-type=END,FAIL
#SBATCH --cpus-per-task=3

Rscript submit.R
