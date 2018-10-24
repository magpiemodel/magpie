*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @equations


*' For cropland the equation `q50_nr_bal_crp` balances the withdrawls (see below) with the share of all
*' incoming fluxes that can be uptaken by the crop land. Since all other inflows except `vm_nr_inorg_fert_reg`
*' are given (by other modules) this equation defines the amount of inorganic fertilizer required.
 q50_nr_bal_crp(i2) ..
                 v50_nr_eff(i2) *
                 ( vm_res_recycling(i2,"nr")
                   + sum((cell(i2,j2),kcr,w), vm_area(j2,kcr,w) * f50_nr_fix_area(kcr))
                   + vm_manure_recycling(i2,"nr")
                   + sum(kli, vm_manure(i2, kli, "stubble_grazing","nr"))
                   + vm_nr_inorg_fert_reg(i2,"crop")
                   + sum(cell(i2,j2),vm_nr_som(j2))
                   + sum(ct,f50_nitrogen_balanceflow(ct,i2))
                   + v50_nr_deposition(i2,"crop"))
                 =g= sum(kcr,v50_nr_withdrawals(i2,kcr));


*' Withdrawls from crop land consist of nitrogen that can not be fixed by crop production
*' or by residues (above and below ground), less the nitrogen inflow from seeds.
 q50_nr_withdrawals(i2,kcr) ..
                 v50_nr_withdrawals(i2,kcr) =e=
                 (1-sum(ct,f50_nr_fix_ndfa(ct,i2,kcr))) *
                 (vm_prod_reg(i2,kcr) * fm_attributes("nr",kcr)
                    + vm_res_biomass_ag(i2,kcr,"nr")
                    + vm_res_biomass_bg(i2,kcr,"nr"))
                 - vm_dem_seed(i2,kcr)  * fm_attributes("nr",kcr)
                 ;


*' For pasture land the equation `q50_nr_bal_pasture` balances nitrogen discharge from pasture production
*' with the share of all inflows that can be uptaken by pasture land such as manure, plant fixation, and atmospheric deposition.
*' In contrast to crop land where the nitrogen fixation rates are crop specific (applied to
*' ton dry matter of crops produces) for paste the fixation rates are given per area.
*' Again, this equation defines the amount of inorganic fertilizer required (`vm_nr_inorg_fert_reg`),
*' since all other influxes are given (by other modules).
 q50_nr_bal_pasture(i2) ..
                    v50_nr_eff_pasture(i2) *
					(sum(kli,vm_manure(i2, kli, "grazing", "nr"))
                     + vm_nr_inorg_fert_reg(i2,"past")
                     + sum((cell(i2,j2)), vm_land(j2,"past")) * sum(ct,f50_nr_fixation_rates_pasture(ct,i2))
                     + v50_nr_deposition(i2,"past"))
                    =g= vm_prod_reg(i2,"pasture") * fm_attributes("nr","pasture");

*' For both crop land and pasture land, this equation gives the amount of nitrogen deposited from the atmosphere.
 q50_nr_deposition(i2,land) ..
                     v50_nr_deposition(i2,land) =e=
                     sum(cell(i2,j2),ic50_atmospheric_deposition_rates(i2,land) * vm_land(j2,land));

*' Having calculated the amount of nitrogen fertilizer required (see above) now the resulting cost are derived. They
*' are part of the objective function.
 q50_nr_cost_fert(i2) ..
                 vm_nr_inorg_fert_costs(i2) =e=
                 sum(land_ag,vm_nr_inorg_fert_reg(i2,land_ag)) * s50_fertilizer_costs
                 ;