#!/bin/bash

#SBATCH --qos=priority
#SBATCH --job-name=mag-run
#SBATCH --output=slurm.log
#SBATCH --mail-type=END,FAIL
#SBATCH --cpus-per-task=16
#SBATCH --mem-per-cpu=5G

Rscript submit.R
