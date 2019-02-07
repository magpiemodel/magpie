*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de


parameters
 i60_bioenergy_dem(t,i)                           Regional bioenergy demand per year (mio. GJ per yr)
 i60_res_2ndgenBE_dem(t,i)                        Regional residue demand for 2nd generation bioenergy per year (mio. GJ per yr)
 i60_1stgen_bioenergy_dem(t,i,kall)               Regional 1st generation bioenergy demand (mio. GJ per yr)
;

positive variables
 vm_dem_bioen(i,kall)               Regional bioenergy demand  (mio. tDM per yr)
 v60_2ndgen_bioenergy_dem_dedicated(i,kall) bioenergy demand which can come from different regions (mio. GJ per yr)
 v60_2ndgen_bioenergy_dem_residues(i,kall) bioenergy demand which can come from different product types (mio. GJ per yr)
;

variables
  vm_bioenergy_utility(i)  Utility as negative costs for producing bioenergy (USD05MER per yr)
;

equations
 q60_bioenergy(i,kall)                     Global total bioenergy demand (mio. GJ per yr)
 q60_bioenergy_glo                         Global 2nd generation dedicated bioenergy demand (mio. GJ per yr)
 q60_bioenergy_reg(i)                      Regional 2nd generation dedicated bioenergy demand (mio. GJ per yr)
 q60_res_2ndgenBE(i)                       Regional residue demand for 2nd generation bioenergy (mio. GJ per yr)
 q60_bioenergy_incentive(i)                Incentive to produce bioenergy (mio. USD05MER per yr)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_dem_bioen(t,i,kall,type)                        Regional bioenergy demand  (mio. tDM per yr)
 ov60_2ndgen_bioenergy_dem_dedicated(t,i,kall,type) bioenergy demand which can come from different regions(mio. tDM per yr)
 ov60_2ndgen_bioenergy_dem_residues(t,i,kall,type)  bioenergy demand which can come from different product types(mio. tDM per yr)
 ov_bioenergy_utility(t,i,type)                     Utility as negative costs for producing bioenergy (USD05MER per yr)
 oq60_bioenergy(t,i,kall,type)                      Global total bioenergy demand (mio. GJ per yr)
 oq60_bioenergy_glo(t,type)                         Global 2nd generation dedicated bioenergy demand (mio. GJ per yr)
 oq60_bioenergy_reg(t,i,type)                       Regional 2nd generation dedicated bioenergy demand (mio. GJ per yr)
 oq60_res_2ndgenBE(t,i,type)                        Regional residue demand for 2nd generation bioenergy (mio. GJ per yr)
 oq60_bioenergy_incentive(t,i,type)                 Incentive to produce bioenergy (mio. USD05MER per yr)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
