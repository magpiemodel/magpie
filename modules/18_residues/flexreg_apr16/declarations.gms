*** |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


positive variables
 v18_prod_res(j,kres)                       Cellular production of residues (mio. tDM)
 vm_res_biomass_ag(i,kcr,w,attributes)      Production of aboveground residues in each region (mio. tDM)
 vm_res_biomass_bg(i,kcr,w,dm_cnr)          Production of belowground residues in each region (mio. tDM)
 v18_res_ag_removal(i,kcr,w,attributes)     Removal of crop residues in respective attribute units DM GJ Nr P K WM C (mio. tX)
 v18_res_ag_recycling(i,kcr,w,attributes)   Recylcing of crop residues to soils in respective attribute units DM GJ Nr P K WM C (mio. tX)
 vm_res_ag_burn(i,kcr,w,attributes)         Residues burned on fields in respective attribute units DM GJ Nr P K WM C (mio. tX)
 vm_res_recycling(i,kcr,w,attributes)       Residues recycled to croplands in respective nutrients Nr P K units (mio. tX)
 vm_cost_prod_kres(i,kres)                  Production costs of harvesting crop residues (mio. USD05MER per yr)
;

equations

 q18_prod_res_ag_reg(i,kcr,w,attributes)    Production constraint of aboveground residues (mio. tDM)
 q18_prod_res_bg_reg(i,kcr,w,dm_cnr)        Production constraint of belowground residues (mio. tDM)

 q18_res_field_balance(i,kcr,w,attributes)  Calculation of the residues amount recycled to soils (mio. tDM)
 q18_res_field_burn(i,kcr,w,attributes)     Fixing of the residues amount burned in a region in respective attribute units DM GJ Nr P K WM C (mio. tX)
 q18_translate(i,kres,attributes)           Transformation of the multiple crop residues into supply balance crop redisues in respective attribute units DM GJ Nr P K WM C (mio. tX)
 q18_prod_res_cell(j,kres)                 Allows for distribution of residues to cellular level (mio. tDM)

 q18_res_recycling_cnr(i,kcr,w,c_nr)        Nutrient recycling of carbon and reaactive nitrogen (mio. tX)
 q18_res_recycling_pk(i,kcr,w,pk18)         Nutrient recycling of phosphorus and potash (mio. tX)
 q18_cost_prod_res(i,kres)                  Production costs of harvesting crop residues (mio. USD05MER)

;

parameters
 i18_res_use_burn(t_all,dev18,kcr)          Share of residues burned on field (1)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_res_biomass_ag(t,i,kcr,w,attributes,type)      Production of aboveground residues in each region (mio. tDM)
 ov_res_biomass_bg(t,i,kcr,w,dm_cnr,type)          Production of belowground residues in each region (mio. tDM)
 ov18_res_ag_removal(t,i,kcr,w,attributes,type)    Removal of crop residues in respective attribute units DM GJ Nr P K WM C (mio. tX)
 ov18_res_ag_recycling(t,i,kcr,w,attributes,type)  Recylcing of crop residues to soils in respective attribute units DM GJ Nr P K WM C (mio. tX)
 ov_res_ag_burn(t,i,kcr,w,attributes,type)         Residues burned on fields in respective attribute units DM GJ Nr P K WM C (mio. tX)
 ov_res_recycling(t,i,kcr,w,attributes,type)       Residues recycled to croplands in respective nutrients Nr P K units (mio. tX)
 ov_cost_prod_kres(t,i,kres,type)                  Production costs of harvesting crop residues (mio. USD05MER per yr)
 oq18_prod_res_ag_reg(t,i,kcr,w,attributes,type)   Production constraint of aboveground residues (mio. tDM)
 oq18_prod_res_bg_reg(t,i,kcr,w,dm_cnr,type)       Production constraint of belowground residues (mio. tDM)
 oq18_res_field_balance(t,i,kcr,w,attributes,type) Calculation of the residues amount recycled to soils (mio. tDM)
 oq18_res_field_burn(t,i,kcr,w,attributes,type)    Fixing of the residues amount burned in a region in respective attribute units DM GJ Nr P K WM C (mio. tX)
 oq18_translate(t,i,kres,attributes,type)          Transformation of the multiple crop residues into supply balance crop redisues in respective attribute units DM GJ Nr P K WM C (mio. tX)
 oq18_res_recycling_cnr(t,i,kcr,w,c_nr,type)       Nutrient recycling of carbon and reaactive nitrogen (mio. tX)
 oq18_res_recycling_pk(t,i,kcr,w,pk18,type)        Nutrient recycling of phosphorus and potash (mio. tX)
 oq18_cost_prod_res(t,i,kres,type)                 Production costs of harvesting crop residues (mio. USD05MER)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################

*** EOF declarations.gms ***
