*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

parameters
        i59_topsoilc_density(t_all,j)      Topsoil carbon density of a hectare of cropland (tC per ha)
        i59_subsoilc_density(t_all,j)      Subsoil carbon density of a hectare of land (tC per ha)
;

variables
        vm_nr_som(j)                        Release of soil organic matter (Mt N per yr)
        vm_nr_som_fertilizer(j)             Uptake of soil organic matter from plants (Mt N per yr)
;

equations
         q59_soilcarbon_cropland(j)          Cropland soil carbon content calculation (mio. tC)
         q59_soilcarbon_noncropland(j)       Non-cropland soil carbon content calculation (mio. tC)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_nr_som(t,j,type)                Release of soil organic matter (Mt N per yr)
 ov_nr_som_fertilizer(t,j,type)     Uptake of soil organic matter from plants (Mt N per yr)
 oq59_soilcarbon_cropland(t,j,type) Cropland soil carbon content calculation (mio. tC)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
