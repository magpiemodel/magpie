*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations

 q11_cost_glo .. vm_cost_glo =e= sum(i2, v11_cost_reg(i2));

*' The global costs of production are represented by the sum of regional
*' production costs of different production activities.

 q11_cost_reg(i2) .. v11_cost_reg(i2) =e= sum(factors,vm_cost_prod_crop(i2,factors))
                   + sum(kres,vm_cost_prod_kres(i2,kres))
                   + vm_cost_prod_past(i2)
                   + vm_cost_prod_fish(i2)
                   + sum(factors,vm_cost_prod_livst(i2,factors))
                   + sum((cell(i2,j2),land), vm_cost_landcon(j2,land))
                   + sum((cell(i2,j2),k), vm_cost_transp(j2,k))
                   + vm_tech_cost(i2)
                   + vm_rotation_penalty(i2)
                   + vm_nr_inorg_fert_costs(i2)
                   + vm_p_fert_costs(i2)
                   + vm_emission_costs(i2)
                   - vm_reward_cdr_aff(i2)
                   + sum(factors,vm_maccs_costs(i2,factors))
                   + vm_cost_AEI(i2)
                   + vm_cost_trade(i2)
                   + vm_cost_fore(i2)
                   + vm_cost_timber(i2)
                   + vm_cost_hvarea_natveg(i2)
                   + vm_cost_processing(i2)
                   + vm_bioenergy_utility(i2)
                   + vm_processing_substitution_cost(i2)
                   + vm_costs_additional_mon(i2)
                   + sum(cell(i2,j2),vm_cost_land_transition(j2))
                   + sum(cell(i2,j2), vm_peatland_cost(j2))
                   + sum(cell(i2,j2), vm_cost_cropland(j2))
                   + sum(cell(i2,j2),vm_cost_bv_loss(j2))
                   + sum(cell(i2,j2),vm_cost_urban(j2))
                   + sum(cell(i2,j2),vm_water_cost(i2))
;

*' The total regional production cost calculation is based on the sum of different
*' MAgPIE production activities. These individual costs are calculated by various
*' cost interfaces, which are in turn calculated inside their respective modules.
*' Different components of regional costs are as follows:
*' Factor costs ([38_factor_costs]),
*' land conversion costs ([39_landconversion]),
*' Transportation costs ([40_transport]),
*' Technological costs ([13_tc]),
*' Inorganic fertilizers ([50_nr_soil_budget]),
*' Emission costs ([56_ghg_policy]),
*' Rewarded CDR from afforestation (Benefits as negative costs) ([56_ghg_policy]),
*' Abatement costs ([57_maccs]),
*' Irrigation expansion costs ([41_area_equipped_for_irrigation]),
*' Trade costs (Transport and bilateral trade) ([21_trade]),
*' Forestry related costs (afforestation) ([32_forestry]),
*' Bioenergy costs ([60_bioenergy]),
*' Processing costs ([20_processing]),
*' Punish costs for overrate cropland differences ([59_som]).
*' Small costs for land transitions ([10_land]).
*' Peatland degradation and restoration costs ([58_peatland]).
*' Peatland emission costs ([56_ghg_policy]).
