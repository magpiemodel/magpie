*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations

*' The AG crop residue biomass `vm_res_biomass_ag` is calculated as a function
*' of harvested area `vm_area` and production `vm_prod_reg`. `f18_cgf` contains
*' slope and intercept parameters of the CGFs.

 q18_prod_res_ag_reg(i2,kcr,attributes) ..
                 vm_res_biomass_ag(i2,kcr,attributes)
                 =e=
                 (sum((cell(i2,j2),w), vm_area(j2,kcr,w)) * sum(ct,f18_multicropping(ct,i2)) * f18_cgf("intercept",kcr)
                 + vm_prod_reg(i2,kcr) * f18_cgf("slope",kcr))
                 * f18_attributes_residue_ag(attributes,kcr);

*' The BG crop residue biomass `vm_res_biomass_bg` is calculated as a function of
*' total aboveground biomass.

 q18_prod_res_bg_reg(i2,kcr,dm_nr) ..
                 vm_res_biomass_bg(i2,kcr,dm_nr)
                 =e=
                 (vm_prod_reg(i2,kcr) + vm_res_biomass_ag(i2,kcr,"dm")) * f18_cgf("bg_to_ag",kcr)
                 * f18_attributes_residue_bg(dm_nr,kcr);

*' In contrast to AG biomass, AG production `vm_res_biomass_ag(i,kcr,attributes)`
*' is defined as the part of residues which is removed from the field. The
*' difference between biomass and production is either burned on field or
*' remains on the fields (either incorporated in soils or not) and decays.
*' The field balance equations ensures that the production of AG residues
*' `vm_res_biomass_ag(i,kcr,attributes)` is properly assigned to different uses:
*' removal, on-field burning and recycling of AG residues.

 q18_res_field_balance(i2,kcr,attributes) ..
                  vm_res_biomass_ag(i2,kcr,attributes)
                  =e=
                  v18_res_ag_removal(i2,kcr,attributes)
                  + vm_res_ag_burn(i2,kcr,attributes)
                  + v18_res_ag_recycling(i2,kcr,attributes);

*' The amount of residues burned on fields in a region `vm_res_ag_burn` is
*' determined by the share (ic18_res_use_min_shr) of AG residue biomass.
*' Based on @smil_nitrogen_1999, residue burning is fixed to 15% of total AG
*' crop residue dry matter in developed and 25% in developing regions for each
*' crop. For future time steps, these rates are scenario dependent, and either
*' kept constant or reduced to 10% and 0% in 2050.

 q18_res_field_burn(i2,kcr,attributes) ..
                  vm_res_ag_burn(i2,kcr,attributes)
                  =e=
                  sum(ct, im_development_state(ct,i2) * i18_res_use_burn(ct,"high_income",kcr)
                  + (1-im_development_state(ct,i2)) * i18_res_use_burn(ct,"low_income",kcr))
                  * vm_res_biomass_ag(i2,kcr,attributes);


*' While the residue biomass is estiamted with a crop-specific nutrient
*' composition (which is required for consistent nutrient budgets), the
*' removed residues are assumed to have homogeneous properties
*' (to reduce the number of commodities in MAgPIE) within three crop residue
*' groups (cereal straw, fibrous residues that cannot be digested
*' by monogastrics, and non-fibrous residues that can be digested).
*' The following constraint, in combination with the field balance equation,
*' guarantees that mass balances are not violated while a homogeneous
*' good is extracted from heterogeneous goods.

 q18_translate(i2,kres,attributes)..
                  sum(kres_kcr(kres,kcr), v18_res_ag_removal(i2,kcr,attributes))
                  =e=
                  vm_prod_reg(i2,kres) * fm_attributes(attributes,kres);

*' Amount produced at cellular level is flexible, can be distributed as it wants 
 q18_prod_res_cell(j2,kres)..
                  sum(cell(i2,j2), vm_prod_reg(i2,kres))
                  =e=
                  v18_prod_res(j2,kres) ;


*' Residues recycled to croplands in nutrients `vm_res_recycling(i2,"nr")` are
*' calcualted based on the amount of AG residues left on field for recycling, the
*' nutrients coming from burned residues, and on biomass that is left in
*' BG residues. They are calculated to be transmitted to the nitrogen budget
*' module [50_nr_soil_budget].

 q18_res_recycling_nr(i2) ..
                  vm_res_recycling(i2,"nr")
                  =e=
                  sum(kcr,  v18_res_ag_recycling(i2,kcr,"nr")
                    + vm_res_ag_burn(i2,kcr,"nr")*(1-f18_res_combust_eff(kcr))
                    + vm_res_biomass_bg(i2,kcr,"nr")
                  );

*' Similar to the recycled nutrients, the potash recycling is determined by the
*' amount of AG residues with the potash content and the amounts of potash from
*' burning residues. As P and K are not volatile and hardly water soluble, only
*' removed aboveground crop residues have to be considered, while nutrients from
*' burned AG as well as BG stay on the field.

 q18_res_recycling_pk(i2,pk18) ..
                  vm_res_recycling(i2,pk18)
                  =e=
                  sum(kcr,
                    v18_res_ag_recycling(i2,kcr,pk18)
                    + vm_res_ag_burn(i2,kcr,pk18)
                  );

*' Costs of residues production are determined as factor costs per ton
*' assuming 15 USD per ton, using the lower range from
*' [this source](hwww1.agric.gov.ab.ca/$Department/deptdocs.nsf/All/faq7514),
*' 10USD baling costs per large round bale plus 2USD pro bale stocking and hauling,
*' 1 large round bale is approximately 500 kg, resulting in 24USD per ton,
*' for developing prices see [here](citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.557.5823&rep=rep1&type=pdf).
*' Tha calcuated factor costs per ton are therefore 24 for `res_cereals`, `res_fibrous`
*' and `res_nonfibrous`.

 q18_cost_prod_res(i2,kres) ..
                  vm_cost_prod_kres(i2,kres)
                  =e=
                  vm_prod_reg(i2,kres) * fm_attributes("wm",kres) *  f18_fac_req_kres(kres);

*' Trade of AG residues is not considered, so that all produced AG residues have
*' to be assigned to uses within the respective world region.

*** EOF constraints.gms ***
