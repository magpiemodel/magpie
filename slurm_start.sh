#!/bin/bash

#SBATCH --qos=short
#SBATCH --job-name=mag-submit
#SBATCH --output=magpie-%j.out
#SBATCH --mail-type=END

Rscript start.R config=default.cfg
