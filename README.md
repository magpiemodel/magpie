# MAgPIE - Modular open source framework for modeling global land-systems

  <https://www.pik-potsdam.de/research/projects/activities/land-use-modelling/magpie>

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

## DOCUMENTATION
A framework description paper has been published in
Geoscientific Model Development (GMD): https://doi.org/10.5194/gmd-12-1299-2019

The model documentation for version 4.1 can be found at
https://rse.pik-potsdam.de/doc/magpie/4.1/

A most recent version of the documentation can also be extracted from the
model source code via the R package goxygen
(https://github.com/pik-piam/goxygen). To extract the documentation, install the
package and run the main function (goxygen) in the main folder of the model.
The resulting documentation can be found in the folder "doc".

Please find a set of tutorials here https://github.com/magpiemodel/tutorials. 
This guide will give you a brief technical introduction in how to install, run and use the model
and how to analyse the model output.

Please pay attentions to the MAgPIE Coding Etiquette when you modify the code.
The Coding Etiquette you find at the beginning of the documentation mentioned above.
The Coding Etiquette explains also the naming conventions and other
structural characteristics.

## COPYRIGHT
Copyright 2008-2019 Potsdam Institute for Climate Impact Research (PIK)

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

## SYSTEM REQUIREMENTS
The model is quite resource heavy and works best on machines with high CPU clock
and memory. Recommended is a machine with Windows, MacOS or Linux, with at least
16GB of memory and a Core i7 CPU or similar.

## HOW TO INSTALL
MAgPIE requires *GAMS* (https://www.gams.com/) including licenses for the
solvers *CONOPT* and (optionally) *CPLEX* for its core calculations. As the model
benefits significantly of recent improvements in *GAMS* and *CONOPT4* it is
recommended to work with the most recent versions of both.
Please make sure that the GAMS installation path is added to the PATH variable
of the system.

In addition *R* (https://www.r-project.org/) is required for pre- and
postprocessing and run management (needs to be added to the PATH variable
as well).

Some R packages are required to run MAgPIE. All are either distributed via 
the offical R CRAN or via a separate repository hosted at
PIK (PIK-CRAN). Before proceeding PIK-CRAN should be added to the list of
available repositories via:
```
options(repos = c(CRAN = "@CRAN@", pik = "https://rse.pik-potsdam.de/r/packages"))
```

Under Windows you need to install Rtools
(https://cran.r-project.org/bin/windows/Rtools/) and to add it to the PATH
variable. After that you can run the following lines of code:

```
pkgs <- c("gdxrrw",
          "ggplot2",
          "curl",
          "gdx",
          "magclass",
          "madrat",
          "mip",
          "lucode",
          "magpie4",
          "magpiesets",
          "lusweave",
          "luscale",
          "goxygen",
          "luplot")
install.packages(pkgs)
```
For post-processing model outputs *Latex* is required
(https://www.latex-project.org/get/). To be seen by the model it also needs to
added to the PATH variable of your system.

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
README file of the model framework (mentioning the depencendy and explaining
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

## CONTACT
magpie@pik-potsdam.de

## KNOWN BUGS

## TROUBLESHOOTING
Please contact magpie@pik-potsdam.de

## CITATION
See file CITATION.cff or the documentation of the model for information how
to cite the model.

[![DOI](https://zenodo.org/badge/135430060.svg)](https://zenodo.org/badge/latestdoi/135430060)

## AUTHORS
See list of authors in CITATION.cff

## CHANGELOG
See log on GitHub (https://github.com/magpiemodel)
