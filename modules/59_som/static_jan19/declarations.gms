*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

parameters
        i59_topsoilc_density(t_all,j)      Topsoil carbon density of a hectare of cropland (tC per ha)
        i59_subsoilc_density(t_all,j)      Subsoil carbon density of a hectare of land (tC per ha)
        i59_nr_som_exogenous_per_ha(t_all,i)      Exogenous nr release due to som release per ha (tN per ha)
;

variables
        vm_nr_som(j)                        Release of soil organic matter (Mt N per yr)
        vm_nr_som_fertilizer(j)             Uptake of soil organic matter from plants (Mt N per yr)
;

equations
         q59_soilcarbon_cropland(j,stockType)               Cropland soil carbon content calculation (mio. tC)
         q59_soilcarbon_regular(j,regularland59,stockType)  Regular soil carbon content calculation (mio. tC)
         q59_soilcarbon_other(j,stockType)  Other land soil carbon content calculation (mio. tC)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_nr_som(t,j,type)                                       Release of soil organic matter (Mt N per yr)
 ov_nr_som_fertilizer(t,j,type)                            Uptake of soil organic matter from plants (Mt N per yr)
 oq59_soilcarbon_cropland(t,j,stockType,type)              Cropland soil carbon content calculation (mio. tC)
 oq59_soilcarbon_regular(t,j,regularland59,stockType,type) Regular soil carbon content calculation (mio. tC)
 oq59_soilcarbon_other(t,j,stockType,type)                 Other land soil carbon content calculation (mio. tC)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
