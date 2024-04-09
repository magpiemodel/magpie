*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


positive variables
 vm_res_biomass_ag(i,kcr,w,attributes)                 production of aboveground residues in each region (mio. tDM)
 vm_res_biomass_bg(i,kcr,w,dm_cnr)                     production of belowground residues in each region (mio. tDM)
 vm_res_recycling(i,kcr,w,attributes)                  residues recycled to croplands (mio tons nutrients)
 vm_res_ag_burn(i,kcr,w,attributes)                    Residues burned on fields in respective attribute units DM GJ Nr P K WM C (mio. tX)
 vm_cost_prod_kres(i,kres)                             Production costs of harvesting crop residues (mio. USD05MER per yr)
;


*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_res_biomass_ag(t,i,kcr,w,attributes,type) production of aboveground residues in each region (mio. tDM)
 ov_res_biomass_bg(t,i,kcr,w,dm_cnr,type)     production of belowground residues in each region (mio. tDM)
 ov_res_recycling(t,i,kcr,w,attributes,type)  residues recycled to croplands (mio tons nutrients)
 ov_res_ag_burn(t,i,kcr,w,attributes,type)    Residues burned on fields in respective attribute units DM GJ Nr P K WM C (mio. tX)
 ov_cost_prod_kres(t,i,kres,type)             Production costs of harvesting crop residues (mio. USD05MER per yr)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################

*** EOF declarations.gms ***
