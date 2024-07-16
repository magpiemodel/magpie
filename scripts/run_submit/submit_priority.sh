#!/bin/bash

#SBATCH --qos=priority
#SBATCH --job-name=mag-run
#SBATCH --output=slurm.log
#SBATCH --mail-type=END,FAIL
#SBATCH --cpus-per-task=3

Rscript submit.R
