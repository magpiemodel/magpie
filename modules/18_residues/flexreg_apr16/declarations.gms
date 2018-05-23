*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de


positive variables
 vm_res_biomass_ag(i,kcr,attributes)        production of aboveground residues in each region (mio. tDM)
 vm_res_biomass_bg(i,kcr,dm_nr)             production of belowground residues in each region (mio. tDM)
 v18_res_ag_removal(i,kcr,attributes)       removal of crop residues  (mio. t attributes)
 v18_res_ag_recycling(i,kcr,attributes)     recylcing of crop residues to soils  (mio. t attributes)
 v18_res_ag_burn(i,kcr,attributes)          residues burned on fields (mio. t attributes)
 vm_res_recycling(i,npk)                    residues recycled to croplands (mio. t nutrients)
;

equations

 q18_prod_res_ag_reg(i,kcr,attributes)     production constraint of aboveground residues (mio. tDM)
 q18_prod_res_bg_reg(i,kcr,dm_nr)          production constraint of belowground residues (mio. tDM)

 q18_res_field_balance(i,kcr,attributes)   calculates the amount recycled to soils (mio. tDM)
 q18_res_field_burn(i,kcr,attributes)      fixes the amount burned in a region (mio. t attributes)
 q18_translate(i,kres,attributes)          transforms the multiple crop residues into kres (mio. t attributes)

 q18_res_recycling_nr(i)                   nutrient recycling nr (mio. t nutrients)
 q18_res_recycling_pk(i,pk18)              nutrient recycling pk (mio. t attributes)
 q18_cost_prod_res(i,kres)                 production costs of harvesting crop residues (mio. USD)

;


*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_res_biomass_ag(t,i,kcr,attributes,type)      production of aboveground residues in each region (mio. tDM)
 ov_res_biomass_bg(t,i,kcr,dm_nr,type)           production of belowground residues in each region (mio. tDM)
 ov18_res_ag_removal(t,i,kcr,attributes,type)    removal of crop residues  (mio. t attributes)
 ov18_res_ag_recycling(t,i,kcr,attributes,type)  recylcing of crop residues to soils  (mio. t attributes)
 ov18_res_ag_burn(t,i,kcr,attributes,type)       residues burned on fields (mio. t attributes)
 ov_res_recycling(t,i,npk,type)                  residues recycled to croplands (mio. t nutrients)
 oq18_prod_res_ag_reg(t,i,kcr,attributes,type)   production constraint of aboveground residues (mio. tDM)
 oq18_prod_res_bg_reg(t,i,kcr,dm_nr,type)        production constraint of belowground residues (mio. tDM)
 oq18_res_field_balance(t,i,kcr,attributes,type) calculates the amount recycled to soils (mio. tDM)
 oq18_res_field_burn(t,i,kcr,attributes,type)    fixes the amount burned in a region (mio. t attributes)
 oq18_translate(t,i,kres,attributes,type)        transforms the multiple crop residues into kres (mio. t attributes)
 oq18_res_recycling_nr(t,i,type)                 nutrient recycling nr (mio. t nutrients)
 oq18_res_recycling_pk(t,i,pk18,type)            nutrient recycling pk (mio. t attributes)
 oq18_cost_prod_res(t,i,kres,type)               production costs of harvesting crop residues (mio. USD)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################

*** EOF declarations.gms ***
