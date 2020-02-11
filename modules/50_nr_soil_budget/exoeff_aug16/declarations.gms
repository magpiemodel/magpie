*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


positive variables
 vm_nr_inorg_fert_reg(i,land_ag)  inorganic fertilizer application (Tg N per yr)
 vm_nr_inorg_fert_costs(i)        cost of inorganic fertilizers (mio. USD05MER per yr)
 v50_nr_eff(i)                    cropland nutrient uptake efficiency (Tg N per yr)
 v50_nr_eff_pasture(i)            pasture nutrient uptake efficiency (Tg N per yr)
 v50_nr_withdrawals(i,kcr)        withdrawals of Nr from soils (Tg N per yr)
 v50_nr_deposition(i,land)        atmospheric deposition (Tg N per yr)
;

equations
 q50_nr_cost_fert(i)        fertilizer costs (mio. USD05MER per yr)
 q50_nr_bal_crp(i)          cropland nutrient inputs have to equal withdrawals and losses (Tg N per yr)
 q50_nr_withdrawals(i,kcr)  calculating nr withdrawals (Tg N per yr)
 q50_nr_bal_pasture(i)      nitrogen balance pasture lands (Tg N per yr)
 q50_nr_deposition(i,land)  atmospheric deposition (Tg N per yr)
;

parameters
 i50_atmospheric_deposition_rates(t,i,land)   atmospheric deposition rate (t N per ha)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_nr_inorg_fert_reg(t,i,land_ag,type) inorganic fertilizer application (Tg N per yr)
 ov_nr_inorg_fert_costs(t,i,type)       cost of inorganic fertilizers (mio. USD05MER per yr)
 ov50_nr_eff(t,i,type)                  cropland nutrient uptake efficiency (Tg N per yr)
 ov50_nr_eff_pasture(t,i,type)          pasture nutrient uptake efficiency (Tg N per yr)
 ov50_nr_withdrawals(t,i,kcr,type)      withdrawals of Nr from soils (Tg N per yr)
 ov50_nr_deposition(t,i,land,type)      atmospheric deposition (Tg N per yr)
 oq50_nr_cost_fert(t,i,type)            fertilizer costs (mio. USD05MER per yr)
 oq50_nr_bal_crp(t,i,type)              cropland nutrient inputs have to equal withdrawals and losses (Tg N per yr)
 oq50_nr_withdrawals(t,i,kcr,type)      calculating nr withdrawals (Tg N per yr)
 oq50_nr_bal_pasture(t,i,type)          nitrogen balance pasture lands (Tg N per yr)
 oq50_nr_deposition(t,i,land,type)      atmospheric deposition (Tg N per yr)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
