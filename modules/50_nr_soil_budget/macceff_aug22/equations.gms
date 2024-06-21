*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations


*' For cropland the equation `q50_nr_bal_crp` balances the withdrawals of nitrogen with the share of all
*' incoming fluxes that can be uptaken by the crop.

 q50_nr_bal_crp(i2) ..
                 vm_nr_eff(i2) * v50_nr_inputs(i2)
                 =g= sum(kcr,v50_nr_withdrawals(i2,kcr));

*' q50_nr_inputs sums of all nitrogen inputs applied to croplands. Organic nitrogen inputs are
*' largely predefined by other modules.
*' Inorganic fertilizers are a free variable that allow to balance the nutrient inputs with requirements.

q50_nr_inputs(i2) ..
                v50_nr_inputs(i2) =e=
                vm_res_recycling(i2,"nr")
                  + sum((cell(i2,j2),kcr,w), vm_area(j2,kcr,w) * f50_nr_fix_area(kcr))
                  + sum(cell(i2,j2),vm_fallow(j2) * f50_nr_fix_area("tece"))
                  + vm_manure_recycling(i2,"nr")
                  + sum(kli, vm_manure(i2, kli, "stubble_grazing","nr"))
                  + vm_nr_inorg_fert_reg(i2,"crop")
                  + sum(cell(i2,j2),vm_nr_som_fertilizer(j2))
                  + sum(ct,f50_nitrogen_balanceflow(ct,i2))
                  + v50_nr_deposition(i2,"crop");

*' withdrawals from cropland consist of nitrogen in the harvested crop plus nitrogen in residues (above and below ground)
*' minus the part of nitrogen which is fixed within the crop, minus nitrogen inflow from seeds.
 q50_nr_withdrawals(i2,kcr) ..
                 v50_nr_withdrawals(i2,kcr) =e=
                 (1-sum(ct,f50_nr_fix_ndfa(ct,i2,kcr))) *
                 (vm_prod_reg(i2,kcr) * fm_attributes("nr",kcr)
                    + vm_res_biomass_ag(i2,kcr,"nr")
                    + vm_res_biomass_bg(i2,kcr,"nr"))
                 - vm_dem_seed(i2,kcr)  * fm_attributes("nr",kcr)
                 ;

*' The nitrogen surplus is defined as inputs minus withdrawals
 q50_nr_surplus(i2) ..
                 v50_nr_surplus_cropland(i2)
                 =e= v50_nr_inputs(i2)
                 - sum(kcr, v50_nr_withdrawals(i2,kcr));

*' For pasture land the equation `q50_nr_bal_pasture` balances nitrogen withdrawals from pasture production
*' with the nitrogen inputs, using a nitrogen use efficiency as scenario parameter
*' (or potentially an endogenous solution).

 q50_nr_bal_pasture(i2) ..
                    vm_nr_eff_pasture(i2) *
                    v50_nr_inputs_pasture(i2)
                    =g=
                    v50_nr_withdrawals_pasture(i2);

*' The nitrogen surplus of pastures is the difference between inputs and withdrawals:
q50_nr_surplus_pasture(i2) ..
                    v50_nr_surplus_pasture(i2)
                    =e=
                    v50_nr_inputs_pasture(i2)
                    - v50_nr_withdrawals_pasture(i2);

*' Inputs include manure excreted during grazing, inorganic fertilizers, atmospheric deposition and biological fixation
*' In contrast to crop land where the nitrogen fixation rates are crop specific and production-dependent (applied to
*' ton dry matter of crops produces) for pastures the fixation rates are given per area.
*' Again, this equation defines the amount of inorganic fertilizer required (`vm_nr_inorg_fert_reg`),
*' since all other influxes are given by other modules.

 q50_nr_inputs_pasture(i2) ..
                   v50_nr_inputs_pasture(i2)
                   =e=
                   sum(kli,vm_manure(i2, kli, "grazing", "nr"))
                   + vm_nr_inorg_fert_reg(i2,"past")
                   + sum((cell(i2,j2)), vm_land(j2,"past")) * sum(ct,f50_nr_fixation_rates_pasture(ct,i2))
                   + v50_nr_deposition(i2,"past");

*' Withdrawals include gras harvest by grazing animals and mowing
 q50_nr_withdrawals_pasture(i2) ..
            v50_nr_withdrawals_pasture(i2) =e=
            vm_prod_reg(i2,"pasture") * fm_attributes("nr","pasture");

*' For both crop land and pasture land, this equation gives the amount of nitrogen deposited from the atmosphere.
 q50_nr_deposition(i2,land) ..
                     v50_nr_deposition(i2,land) =e=
                     sum((ct,cell(i2,j2)),i50_atmospheric_deposition_rates(ct,j2,land) * vm_land(j2,land));

*' Having calculated the amount of nitrogen fertilizer required (see above) now the resulting cost are derived. They
*' are part of the objective function.
 q50_nr_cost_fert(i2) ..
                 vm_nr_inorg_fert_costs(i2) =e=
                 sum(land_ag,vm_nr_inorg_fert_reg(i2,land_ag)) * s50_fertilizer_costs
                 ;
