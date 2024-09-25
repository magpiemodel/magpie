# MAgPIE - Modular open source framework for modeling global land-systems

[![DOI](https://zenodo.org/badge/135430060.svg)](https://zenodo.org/badge/latestdoi/135430060)
[![R build status](https://github.com/magpiemodel/magpie/workflows/check/badge.svg)](https://github.com/magpiemodel/magpie/actions)

## WHAT IS MAGPIE?
The *Model of Agricultural Production and its Impact on the Environment* (MAgPIE)
is a modular open source framework for modeling global land-systems, which is
coupled to the grid-based dynamic vegetation model LPJmL, with a spatial resolution
of 0.5°x0.5°. It takes regional economic conditions such as demand for agricultural
commodities, technological development and production costs as well as spatially
explicit data on potential crop yields, land and water constraints (from LPJmL) into
account. Based on these, the model derives specific land use patterns, yields and
total costs of agricultural production for each grid cell. The objective function of
the land use model is to minimize total cost of production for a given amount of
regional food and bioenergy demand. Regional food energy demand is defined for an
exogenously given population in 10 food energy categories, based on regional diets.
Future trends in food demand are derived from a cross-country regression analysis,
based on future scenarios on GDP and population growth.

https://www.pik-potsdam.de/research/projects/activities/land-use-modelling/magpie

## DOCUMENTATION
A framework description paper has been published in
Geoscientific Model Development (GMD): https://doi.org/10.5194/gmd-12-1299-2019

The model documentation for version 4.8.2 can be found at
https://rse.pik-potsdam.de/doc/magpie/4.8.2/

A most recent version of the documentation can also be extracted from the
model source code via the R package goxygen
(https://github.com/pik-piam/goxygen). To extract the documentation, install the
package and run the main function (goxygen) in the main folder of the model.
The resulting documentation can be found in the folder "doc".

Please find a set of tutorials here https://magpiemodel.github.io/tutorials/.
This guide will give you a brief technical introduction in how to install, run and use the model
and how to analyse the model output.

Please pay attention to the MAgPIE Coding Etiquette when you modify the code.
The Coding Etiquette you find at the beginning of the documentation mentioned above.
The Coding Etiquette explains also the naming conventions and other
structural characteristics.

## COPYRIGHT
Copyright 2008-2022 Potsdam Institute for Climate Impact Research (PIK)

## LICENSE
This program is free software: you can redistribute it and/or modify
it under the terms of the **GNU Affero General Public License** as published by
the Free Software Foundation, **version 3** of the License or later. You should
have received a copy of the GNU Affero General Public License along with this
program. See the LICENSE file in the root directory. If not, see
https://www.gnu.org/licenses/agpl.txt

Under Section 7 of AGPL-3.0, you are granted additional permissions described
in the MAgPIE License Exception, version 1.0 (see LICENSE file).

## NOTES
Following the principles of good scientific practice it is recommended
to make the source code available in the events of model based publications
or model-based consulting.

When using a modified version of **MAgPIE** which is not identical to versions
in the official main repository at https://github.com/magpiemodel add a suffix
to the name to allow distinguishing versions (format **MAgPIE-suffix**).

## HARDWARE REQUIREMENTS
The model is quite resource heavy and works best on machines with high CPU clock
and memory. Recommended is a machine with at least 16GB of memory and a Core i7 CPU or similar.

## HOW TO INSTALL
Commands formatted as `code` should generally be run in a terminal (PowerShell on Windows).

### List of Requirements
- license for gams incl. CONOPT solver
- gams >= 43.4.1
- git >= 2.16.1
- R >= 4.1.2 (+ matching Rtools on Windows)
- pandoc >= 2.14.2
- TeX >= 3.14159265

### OS specific setup
Choose your operating system and follow the instructions there. You can also
install requirements differently (e.g. using only installers on Windows), in
the end it is only important that all requirements are installed in a suitable
version and added to the PATH environment variable, so MAgPIE can use them.

#### Ubuntu
1. make sure you have a gams license incl. the CONOPT solver
1. [install gams](https://www.gams.com/46/docs/UG_UNIX_INSTALL.html)
1. install git, R, and pandoc with `sudo apt install git r-base pandoc`
1. install TinyTeX with `Rscript -e 'install.packages("tinytex"); tinytex::install_tinytex()'`

#### macOS
1. make sure you have a gams license incl. the CONOPT solver
1. [install gams](https://www.gams.com/46/docs/UG_MAC_INSTALL.html)
1. install git, R, and pandoc with `brew install git r pandoc`
1. install TinyTeX with `Rscript -e 'install.packages("tinytex"); tinytex::install_tinytex()'`

#### Windows
1. make sure you have a gams license incl. the CONOPT solver
1. [install gams](https://www.gams.com/46/docs/UG_WIN_INSTALL.html)
1. [download .msi pandoc file](https://github.com/jgm/pandoc/releases/latest) and run installer (`choco install pandoc` did not work in testing)
1. [install chocolatey](https://chocolatey.org/install)
1. install git, rig (R installer), and tinytex with `choco install -y git rig tinytex`
1. restart terminal
1. install R and Rtools with `rig add release; rig add rtools`

### check setup is complete
- restart terminal
- `gams` should print many lines including "The installed license is valid."
- `git --version`
- `Rscript --version`
- `pandoc --version`
- `tex --version`

If any of these are not found: Find the path to that executable
(gams/git/Rscript/pandoc/tex, on Windows ending in '.exe') and add it to your
PATH environment variable. Search for a tutorial online if you are unsure how to do that.

### download and run MAgPIE
1. download MAgPIE with `git clone https://github.com/magpiemodel/magpie.git`
1. go into the MAgPIE folder `cd magpie`
1. start a MAgPIE run with `Rscript start.R`, first time: installs all required R packages (takes a while)
1. choose "1" for a default run
1. then select "1" for direct execution

### troubleshooting
Please check [this discussion](https://github.com/magpiemodel/magpie/discussions/650) for known problems and solutions and to report new problems you encounter while setting up MAgPIE.

## DOCKER
To use Docker, copy your `gamslice.txt`
into the MAgPIE main directory, and build the magpie image using the command
```
sudo docker build -t magpie .
```
Basic usage: Run the container (note the use of an absolute path) using
```
sudo docker run -v /an/absolute/path/to/a/folder/:/home/magpie/output -it magpie
```
Note: this will run MAgPIE with the default settings, if you want to change them choose the

Advanced usage: Run the container interactively using
```
sudo docker run -v /an/absolute/path/to/a/folder/:/home/magpie/output -it magpie bash
```

## HOW TO CONFIGURE
Model run settings are set in `config/default.cfg` (or another config file of
the same structure). New model scenarios can be created by adding a column to
`config/scenario_config.csv`

## HOW TO RUN
To run the model execute `Rscript start.R` (or `source("start.R")` from within
R) in the main folder of the model.
This will give you a list of available run scripts you can choose from. You can
also add your own run scripts by saving them in the folder scripts/start. To run
a single model run with settings as stated in default.cfg you can choose start
script "default". Make sure that the config file has been set correctly before
starting the model.

## HOW TO CONTRIBUTE
We are interested in working with you! Just contact us through GitHub
(https://github.com/magpiemodel) or by mail (magpie@pik-potsdam.de) if you have
found and/or fixed a bug, developed a new model feature, have ideas for further
model development, suggestions for improvements or anything else. We are open to
any kind of contribution. Our aim is to develop an open, transparent and
meaningful model of the agricultural land use sector to get a better
understanding of the underlying processes and possible futures. Join us doing
so!

## DEPENDENCIES
Model dependencies **must be publicly available** and should be Open Source.
Development aim is to rather minimize than expand dependencies on non-free
and/or non open source software. That means that besides currently existing
dependencies on GAMS, the GDXRRW R package and the corresponding solvers there
should be no additional dependencies of this kind and that these existing
dependencies should be resolved in the future if possible.

If a new R package is added as dependency this package should fulfill the
following requirements:
* The package is published under an Open Source license
* The package is distributed through CRAN or PIK-CRAN (the PIK-based,
  but publicly available package repository).
* The package source code is available through a public, version controlled
  repository such as GitHub

For other dependencies comparable measures should apply. When a dependency is
added this dependency should be added to the *HOW TO INSTALL* section in the
README file of the model framework (mentioning the dependency and explaining
how it can be installed). If not all requirements can be fulfilled by the new
dependency this case should be discussed with the model maintainer
(magpie@pik-potsdam.de) to find a good solution for it.

## INPUT DATA

In order to allow other researchers to reproduce and use work done with MAgPIE
one needs to make sure that all components necessary to perform a run can be
shared. One of these components is the input data. As proprietary data usually
does not allow its free distribution it should generally be avoided.

When adding a new data source, make sure that it can be freely shared with
others. If this is not the case please consider using a different source or
solution.

Data preparation should ideally be performed with the **madrat** data processing
framework (https://github.com/pik-piam/madrat). This makes sure that the
processing is reproducible and links properly to the already existing data
processing for MAgPIE.

In case that these recommendations can not be followed we would be happy if you
could discuss that issue with the MAgPIE development team
(magpie@pik-potsdam.de).

## MODEL OUTPUT

By default the results of a model run are written to an individual results folder within the "output/" folder of the model. The two most important output files are the fulldata.gdx and the report.mif. The fulldata.gdx is the technical output of the GAMS optimization and contains all quantities that were used during the optimization in unchanged form. The mif-file is a csv file of a specific format and is synthetized from the fulldata.gdx by post-processing scripts. It can be read in any text editor or spreadsheet program and is well suited for a quick look at the results and for further analysis.

## CONTACT
magpie@pik-potsdam.de

## KNOWN BUGS

## TROUBLESHOOTING
Please contact magpie@pik-potsdam.de

## CITATION
See file CITATION.cff or the [How-to-Cite section](https://rse.pik-potsdam.de/doc/magpie/4.8.2/#how-to-cite) in the model documentation for information how to cite the model.

## AUTHORS
See list of authors in CITATION.cff

## CHANGELOG
See log on GitHub (https://github.com/magpiemodel)
