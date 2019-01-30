*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de



*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_nr_som(t,j,"marginal")                  = vm_nr_som.m(j);
 ov_costs_overrate_cropdiff(t,i,"marginal") = vm_costs_overrate_cropdiff.m(i);
 oq59_soilcarbon_cropland(t,j,"marginal")   = q59_soilcarbon_cropland.m(j);
 ov_nr_som(t,j,"level")                     = vm_nr_som.l(j);
 ov_costs_overrate_cropdiff(t,i,"level")    = vm_costs_overrate_cropdiff.l(i);
 oq59_soilcarbon_cropland(t,j,"level")      = q59_soilcarbon_cropland.l(j);
 ov_nr_som(t,j,"upper")                     = vm_nr_som.up(j);
 ov_costs_overrate_cropdiff(t,i,"upper")    = vm_costs_overrate_cropdiff.up(i);
 oq59_soilcarbon_cropland(t,j,"upper")      = q59_soilcarbon_cropland.up(j);
 ov_nr_som(t,j,"lower")                     = vm_nr_som.lo(j);
 ov_costs_overrate_cropdiff(t,i,"lower")    = vm_costs_overrate_cropdiff.lo(i);
 oq59_soilcarbon_cropland(t,j,"lower")      = q59_soilcarbon_cropland.lo(j);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################

