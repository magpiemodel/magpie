#!/bin/bash

#SBATCH --qos=standby
#SBATCH --job-name=mag-run
#SBATCH --output=slurm.log
#SBATCH --mail-type=END
#SBATCH --cpus-per-task=16
#SBATCH --mem-per-cpu=0
#SBATCH --partition=priority
#SBATCH --time=24:00:00

Rscript submit.R
