*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de


*fix bioenergy demand to given values
vm_dem_bioen.fx(i,kall) = 0;

*' @code For first generation bioenergy, input is provided on regional level
*' fixing the bioenergy demand variable $vm\_dem\_bioen$ to the input values
*' $f60\_dem\_1stgen\_bioen$ (in `presolve.gms`).

vm_dem_bioen.fx(i,kall) = f60_1stgen_bioenergy_dem(t,i,"%c60_1stgen_biodem%",kall)
                          /fm_attributes("ge",kall);

*' The used first generation bioenergy trajectory contains demand until 2050
*' based on currently established and planned bioenergy policies
*' (@lotze-campen_impacts_2014). For the time
*' after 2050 it is assumed that bioenergy production will be fully transformed
*' to 2nd generation bioenergy crops and residues because of their higher 
*' estimated efficiency respectively their low costs.
*'
*' For second generation bioenergy (`kbe60` = bioenergy grasses and bioenergy
*' trees), input is given either on regional or global level (defined via switch
*' $c60\_biodem\_level$). As the bioenergy demand for all crop types was fixed in the
*' first step it now has to be released again for second generation bioenergy
*' crops (`kbe60`).

*relax boundaries for all crops which belong to kbe60 as their demand is
*calculated separately (see equations)
vm_dem_bioen.up(i,kbe60) = Inf;
vm_dem_bioen.lo(i,kbe60) = 0;

*' Relax the upper bound for residues.

vm_dem_bioen.up(i,kres) = Inf;

*' @stop
