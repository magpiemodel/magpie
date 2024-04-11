*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


positive variables
 vm_nr_inorg_fert_reg(i,land_ag)  Inorganic fertilizer application (Tg N per yr)
 vm_nr_inorg_fert_costs(i)        Cost of inorganic fertilizers (mio. USD05MER per yr)
 vm_nr_eff(i)                    Cropland nutrient uptake efficiency (Tg N per yr)
 vm_nr_eff_pasture(i)            Pasture nutrient uptake efficiency (Tg N per yr)
 v50_nr_inputs(i)                Total inputs to croplands (Tg N per yr)
 v50_nr_withdrawals(i,kcr)        Withdrawals of Nr from cropland soils (Tg N per yr)
 v50_nr_surplus_cropland(i)      Total Nr surplus on cropland soils (Tg N per yr)
 v50_nr_inputs_pasture(i)        Total inputs to croplands (Tg N per yr)
 v50_nr_withdrawals_pasture(i)   Withdrawals of Nr from pasture soils (Tg N per yr)
 v50_nr_surplus_pasture(i)       Total Nr surplus on pasture soils (Tg N per yr)
 v50_nr_deposition(i,land)        Atmospheric deposition (Tg N per yr)
;

equations
 q50_nr_cost_fert(i)           Fertilizer costs (mio. USD05MER per yr)
 q50_nr_bal_crp(i)             Cropland nutrient inputs have to equal withdrawals and losses (Tg N per yr)
 q50_nr_withdrawals(i,kcr)     Calculating nr withdrawals (Tg N per yr)
 q50_nr_inputs(i)              Calculating nr withdrawals (Tg N per yr)
 q50_nr_surplus(i)             Calculating nr surplus (Tg N per yr)
 q50_nr_bal_pasture(i)         Nitrogen balance pasture lands (Tg N per yr)
 q50_nr_inputs_pasture(i)      Nitrogen inputs to pastures (Tg N per yr)
 q50_nr_withdrawals_pasture(i) Nitrogen withdrawals from pastures (Tg N per yr)
 q50_nr_surplus_pasture(i)     Nitrogen surplus on pastures (Tg N per yr)
 q50_nr_deposition(i,land)     Atmospheric deposition (Tg N per yr)
;

parameters
 i50_atmospheric_deposition_rates(t,j,land)   Atmospheric deposition rate (t N per ha)
* country-specific scenario switch
 p50_country_dummy_cropneff(iso)           Dummy parameter indicating whether country is affected by crop neff scenario (1)
 p50_country_dummy_pastneff(iso)           Dummy parameter indicating whether country is affected by pasture neff scenario (1)
 p50_cropneff_region_shr(t,i)              Weighted share of region with regards to crop neff scenario of countries (1)
 p50_pastneff_region_shr(t,i)              Weighted share of region with regards to pasture neff scenario of countries (1)
 i50_nr_eff_bau(t_all,i)                   Business as usual soil nitrogen uptake efficiency before MACCs mitigation (1)
 i50_nr_eff_pasture_bau(t_all,i)           Business as usual pasture nitrogen use efficiency before MACCs mitigation (1)
 i50_maccs_mitigation_transf(t,i)          Transformed marginal abatement cost curves to be consistent with cropland SNuPE implementaton (1)
 i50_maccs_mitigation_pasture_transf(t,i)  Transformed marginal abatement cost curves to be consistent with pasture NUE implementaton (1)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_nr_inorg_fert_reg(t,i,land_ag,type) Inorganic fertilizer application (Tg N per yr)
 ov_nr_inorg_fert_costs(t,i,type)       Cost of inorganic fertilizers (mio. USD05MER per yr)
 ov_nr_eff(t,i,type)                    Cropland nutrient uptake efficiency (Tg N per yr)
 ov_nr_eff_pasture(t,i,type)            Pasture nutrient uptake efficiency (Tg N per yr)
 ov50_nr_inputs(t,i,type)               Total inputs to croplands (Tg N per yr)
 ov50_nr_withdrawals(t,i,kcr,type)      Withdrawals of Nr from cropland soils (Tg N per yr)
 ov50_nr_surplus_cropland(t,i,type)     Total Nr surplus on cropland soils (Tg N per yr)
 ov50_nr_inputs_pasture(t,i,type)       Total inputs to croplands (Tg N per yr)
 ov50_nr_withdrawals_pasture(t,i,type)  Withdrawals of Nr from pasture soils (Tg N per yr)
 ov50_nr_surplus_pasture(t,i,type)      Total Nr surplus on pasture soils (Tg N per yr)
 ov50_nr_deposition(t,i,land,type)      Atmospheric deposition (Tg N per yr)
 oq50_nr_cost_fert(t,i,type)            Fertilizer costs (mio. USD05MER per yr)
 oq50_nr_bal_crp(t,i,type)              Cropland nutrient inputs have to equal withdrawals and losses (Tg N per yr)
 oq50_nr_withdrawals(t,i,kcr,type)      Calculating nr withdrawals (Tg N per yr)
 oq50_nr_inputs(t,i,type)               Calculating nr withdrawals (Tg N per yr)
 oq50_nr_surplus(t,i,type)              Calculating nr surplus (Tg N per yr)
 oq50_nr_bal_pasture(t,i,type)          Nitrogen balance pasture lands (Tg N per yr)
 oq50_nr_inputs_pasture(t,i,type)       Nitrogen inputs to pastures (Tg N per yr)
 oq50_nr_withdrawals_pasture(t,i,type)  Nitrogen withdrawals from pastures (Tg N per yr)
 oq50_nr_surplus_pasture(t,i,type)      Nitrogen surplus on pastures (Tg N per yr)
 oq50_nr_deposition(t,i,land,type)      Atmospheric deposition (Tg N per yr)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
