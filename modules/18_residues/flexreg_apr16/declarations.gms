*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de


positive variables
 vm_res_biomass_ag(i,kcr,attributes)        Production of aboveground residues in each region (mio. tDM)
 vm_res_biomass_bg(i,kcr,dm_nr)             Production of belowground residues in each region (mio. tDM)
 v18_res_ag_removal(i,kcr,attributes)       Removal of crop residues in respective attribute units (mio. tX)
 v18_res_ag_recycling(i,kcr,attributes)     Recylcing of crop residues to soils in respective attribute units (mio. tX)
 v18_res_ag_burn(i,kcr,attributes)          Residues burned on fields in respective attribute units (mio. tX)
 vm_res_recycling(i,npk)                    Residues recycled to croplands in respective nutrients units(mio. tX)
;

equations

 q18_prod_res_ag_reg(i,kcr,attributes)     Production constraint of aboveground residues (mio. tDM)
 q18_prod_res_bg_reg(i,kcr,dm_nr)          Production constraint of belowground residues (mio. tDM)

 q18_res_field_balance(i,kcr,attributes)   Calculation of the residues amount recycled to soils (mio. tDM)
 q18_res_field_burn(i,kcr,attributes)      Fixing of the residues amount burned in a region in respective attribute units (mio. tX)
 q18_translate(i,kres,attributes)          Transformation of the multiple crop residues into supply balance crop redisues in respective attribute units (mio. tX)

 q18_res_recycling_nr(i)                   Nutrient recycling of reaactive nitrogen (mio. tNr)
 q18_res_recycling_pk(i,pk18)              Nutrient recycling of potash (mio. tPk)
 q18_cost_prod_res(i,kres)                 Production costs of harvesting crop residues (mio. USD)

;

parameters
 i18_res_use_burn(t_all,dev18,kcr)         Share of residues burned on field (1)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_res_biomass_ag(t,i,kcr,attributes,type)      Production of aboveground residues in each region (mio. tDM)
 ov_res_biomass_bg(t,i,kcr,dm_nr,type)           Production of belowground residues in each region (mio. tDM)
 ov18_res_ag_removal(t,i,kcr,attributes,type)    Removal of crop residues in respective attribute units (mio. tX)
 ov18_res_ag_recycling(t,i,kcr,attributes,type)  Recylcing of crop residues to soils in respective attribute units (mio. tX)
 ov18_res_ag_burn(t,i,kcr,attributes,type)       Residues burned on fields in respective attribute units (mio. tX)
 ov_res_recycling(t,i,npk,type)                  Residues recycled to croplands in respective nutrients units(mio. tX)
 oq18_prod_res_ag_reg(t,i,kcr,attributes,type)   Production constraint of aboveground residues (mio. tDM)
 oq18_prod_res_bg_reg(t,i,kcr,dm_nr,type)        Production constraint of belowground residues (mio. tDM)
 oq18_res_field_balance(t,i,kcr,attributes,type) Calculation of the residues amount recycled to soils (mio. tDM)
 oq18_res_field_burn(t,i,kcr,attributes,type)    Fixing of the residues amount burned in a region in respective attribute units (mio. tX)
 oq18_translate(t,i,kres,attributes,type)        Transformation of the multiple crop residues into supply balance crop redisues in respective attribute units (mio. tX)
 oq18_res_recycling_nr(t,i,type)                 Nutrient recycling of reaactive nitrogen (mio. tNr)
 oq18_res_recycling_pk(t,i,pk18,type)            Nutrient recycling of potash (mio. tPk)
 oq18_cost_prod_res(t,i,kres,type)               Production costs of harvesting crop residues (mio. USD)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################

*** EOF declarations.gms ***
