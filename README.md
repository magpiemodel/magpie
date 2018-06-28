# MAgPIE 4.0-beta

This is an unvalidated beta version. Do not use it for productive runs!

  <https://www.pik-potsdam.de/research/projects/activities/land-use-modelling/magpie>

## WHAT IS MAGPIE?
The *Model of Agricultural Production and its Impact on the Environment* (MAgPIE)
is a global land use allocation model framework, which is coupled to the grid-based
dynamic vegetation model LPJmL, with a spatial resolution of 0.5°x0.5°. It takes
regional economic conditions such as demand for agricultural commodities, technological
development and production costs as well as spatially explicit data on potential
crop yields, land and water constraints (from LPJmL) into account. Based on these,
the model derives specific land use patterns, yields and total costs of
agricultural production for each grid cell. The objective function of the land use
model is to minimize total cost of production for a given amount of regional food
and bioenergy demand. Regional food energy demand is defined for an exogenously
given population in 10 food energy categories, based on regional diets. Future
trends in food demand are derived from a cross-country regression analysis, based
on future scenarios on GDP and population growth.

## DOCUMENTATION
An incomplete preview of the model documentation for version 4 can be found at
https://rse.pik-potsdam.de/magpie/version4_documentation_preview/

Please pay attentions to the MAgPIE Coding Etiquette when you modify the code.
The Coding Etiquette you find at
https://redmine.pik-potsdam.de/projects/pik-model-operations/wiki/Coding_Etiquette
The Coding Etiquette explains also the used name conventions and other
structural characteristics.

## COPYRIGHT
Copyright 2008-2018 Potsdam Institute for Climate Impact Research (PIK)

## LICENSE
This program is free software: you can redistribute it and/or modify
it under the terms of the **GNU Affero General Public License** as published by
the Free Software Foundation, **version 3** of the License. You should have
received a copy of the GNU Affero General Public License along with this
program. See the LICENSE file in the root directory. If not, see
http://www.gnu.org/licenses/

## NOTES
Besides distribution and software-as-a-service applications the source code
should also be made available in the events of model based publications or
model-based consulting.

When using a modified version of **MAgPIE** which is not identical to versions
in the official main repository at https://github.com/magpiemodel add a suffix
to the name to allow distinguishing versions (format **MAgPIE-suffix**).

## HOW TO INSTALL
MAgPIE requires *GAMS* (https://www.gams.com/) including licenses for the
solvers *CONOPT* and *CPLEX* for its core calculations. Please make sure that
the GAMS installation path is added to the PATH variable of the system.

In addition *R* (https://www.r-project.org/) is required for pre- and
postprocessing and run management (needs to be added to the PATH variable
as well).

For R some packages are required to run MAgPIE. All except of one (`gdxrrw`) are
either distributed via the offical R CRAN or via a separate repository hosted at
PIK (PIK-CRAN). Before proceeding PIK-CRAN should be added to the list of
available repositories via:
```
options(repos = c(CRAN = "@CRAN@", pik = "http://rse.pik-potsdam.de/r/packages"))
```

The `gdxrrw` package has to be downloaded directly from GAMS via
```
download.file("https://support.gams.com/_media/gdxrrw:gdxrrw_1.0.2.zip",
              "gdxrrw_1.0.2.zip")
install.packages(“reshape2”)
install.packages("gdxrrw_1.0.2.zip",repos = NULL)
```
In some cases it can happen that `gdxrrw` does not return an error message during
installation but also did not install properly. To verify a successful
installation try to load the package via `library(gdxrrw)`.

--------------------------------------------------------------------------------

If loading of the package fails you need to install the package from source.
Under Windows this requires to install Rtools
(https://cran.r-project.org/bin/windows/Rtools/) and to add it to the PATH
variable. After that you can run the following lines of code:

```
download.file("https://support.gams.com/_media/gdxrrw:gdxrrw_1.0.2.tar.gz",
              "gdxrrw_1.0.2.tar.gz")
install.packages("gdxrrw_1.0.2.tar.gz",repos = NULL, type="source")
```

--------------------------------------------------------------------------------


After that all remaining packages can be installed via `install.packages`

```
pkgs <- c("ggplot2",
          "curl",
          "gdx",
          "magclass",
          "madrat",
          "mip",
          "lucode",
          "magpie4",
          "magpiesets",
          "lusweave",
          "luscale")
install.packages(pkgs)
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

## AUTHORS
See file `AUTHORS`

## CHANGELOG
See log on GitHub (https://github.com/magpiemodel)
