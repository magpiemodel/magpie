#!/bin/bash

#SBATCH --qos=priority
#SBATCH --job-name=mag-run
#SBATCH --output=slurm.log
#SBATCH --mail-type=END
#SBATCH --cpus-per-task=3
#SBATCH --partition=priority
#SBATCH --time=24:00:00

Rscript submit.R
