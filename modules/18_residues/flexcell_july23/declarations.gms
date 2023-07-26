*** |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


positive variables
 v18_prod_res(j,kres)                       Cellular production of residues (mio. tDM)
 v18_res_biomass_ag_cell(j,kcr,attributes)  Production of aboveground residues in each cell (mio. tDM)
 vm_res_biomass_ag(i,kcr,attributes)        Production of aboveground residues in each region (mio. tDM)
 vm_res_biomass_bg(i,kcr,dm_nr)             Production of belowground residues in each region (mio. tDM)

 v18_res_ag_removal(j,kcr,attributes)       Removal of crop residues in respective attribute units DM GJ Nr P K WM C (mio. tX)
 v18_res_ag_recycling(i,kcr,attributes)     Recylcing of crop residues to soils in respective attribute units DM GJ Nr P K WM C (mio. tX)
 vm_res_ag_burn(i,kcr,attributes)           Regional residues burned on fields in respective attribute units DM GJ Nr P K WM C (mio. tX)

 vm_res_recycling(i,npk)                    Residues recycled to croplands in respective nutrients Nr P K units (mio. tX)
 vm_cost_prod_kres(i,kres)                  Production costs of harvesting crop residues (mio. USD05MER per yr)
;

equations

 q18_prod_res_ag_cell(j,kcr,attributes)    Cellular production constraint of aboveground residues (mio. tDM)
 q18_prod_res_ag_reg(i,kcr,attributes)     Regional production constraint of aboveground residues (mio. tDM)

 q18_prod_res_bg_cell(i,kcr,dm_nr)         Cellular production constraint of belowground residues (mio. tDM)

 q18_res_field_balance(i,kcr,attributes)      Calculation of the residues amount recycled to soils (mio. tDM)
 q18_cell_field_constraint(j,kcr,attributes)  Make sure the amount removed in any cell does not exceet the amoutn available
 q18_res_field_burn(i,kcr,attributes)         Fixing of the residues amount burned in a region in respective attribute units DM GJ Nr P K WM C (mio. tX)
 q18_translate(j,kres,attributes)             Transformation of the multiple crop residues into supply balance crop redisues in respective attribute units DM GJ Nr P K WM C (mio. tX)

 q18_res_recycling_nr(i)                   Nutrient recycling of reaactive nitrogen (mio. tNr)
 q18_res_recycling_pk(i,pk18)              Nutrient recycling of phosphorus and potash (mio. tX)
 q18_cost_prod_res(i,kres)                 Production costs of harvesting crop residues (mio. USD05MER)

 q18_prod_res_reg(i,kall)                 Regional production of residues (mio. tDM)

;

parameters
 i18_res_use_burn(t_all,dev18,kcr)         Share of residues burned on field (1)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov18_prod_res(t,j,kres,type)                        Cellular production of residues (mio. tDM)
 ov18_res_biomass_ag_cell(t,j,kcr,attributes,type)   Production of aboveground residues in each cell (mio. tDM)
 ov_res_biomass_ag(t,i,kcr,attributes,type)          Production of aboveground residues in each region (mio. tDM)
 ov_res_biomass_bg(t,i,kcr,dm_nr,type)               Production of belowground residues in each region (mio. tDM)
 ov18_res_ag_removal(t,j,kcr,attributes,type)        Removal of crop residues in respective attribute units DM GJ Nr P K WM C (mio. tX)
 ov18_res_ag_recycling(t,i,kcr,attributes,type)      Recylcing of crop residues to soils in respective attribute units DM GJ Nr P K WM C (mio. tX)
 ov_res_ag_burn(t,i,kcr,attributes,type)             Regional residues burned on fields in respective attribute units DM GJ Nr P K WM C (mio. tX)
 ov_res_recycling(t,i,npk,type)                      Residues recycled to croplands in respective nutrients Nr P K units (mio. tX)
 ov_cost_prod_kres(t,i,kres,type)                    Production costs of harvesting crop residues (mio. USD05MER per yr)
 oq18_prod_res_ag_cell(t,j,kcr,attributes,type)      Cellular production constraint of aboveground residues (mio. tDM)
 oq18_prod_res_ag_reg(t,i,kcr,attributes,type)       Regional production constraint of aboveground residues (mio. tDM)
 oq18_prod_res_bg_cell(t,i,kcr,dm_nr,type)           Cellular production constraint of belowground residues (mio. tDM)
 oq18_res_field_balance(t,i,kcr,attributes,type)     Calculation of the residues amount recycled to soils (mio. tDM)
 oq18_cell_field_constraint(t,j,kcr,attributes,type) Make sure the amount removed in any cell does not exceet the amoutn available
 oq18_res_field_burn(t,i,kcr,attributes,type)        Fixing of the residues amount burned in a region in respective attribute units DM GJ Nr P K WM C (mio. tX)
 oq18_translate(t,j,kres,attributes,type)            Transformation of the multiple crop residues into supply balance crop redisues in respective attribute units DM GJ Nr P K WM C (mio. tX)
 oq18_res_recycling_nr(t,i,type)                     Nutrient recycling of reaactive nitrogen (mio. tNr)
 oq18_res_recycling_pk(t,i,pk18,type)                Nutrient recycling of phosphorus and potash (mio. tX)
 oq18_cost_prod_res(t,i,kres,type)                   Production costs of harvesting crop residues (mio. USD05MER)
 oq18_prod_res_reg(t,i,kall,type)                    Regional production of residues (mio. tDM)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################

*** EOF declarations.gms ***