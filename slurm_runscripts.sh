#!/bin/bash

#SBATCH --qos=short
#SBATCH --job-name=mag-submit
#SBATCH --output=magpietest-%j.out
#SBATCH --mail-type=END
#SBATCH --mem-per-cpu=32000

echo select one of the following runscripts by name:
ls scripts/runscripts/
read runscript
Rscript scripts/runscripts/"$runscript" 
