#!/bin/bash

echo "select one of the following runscripts by name:"

ls scripts/runscripts/
read runscript

echo "test $runscript"
sbatch  --qos=short --job-name=mag-submit --output=magpietest-%j.out --mail-type=END --mem-per-cpu=32000 Rscript scripts/runscripts/"$runscript"
