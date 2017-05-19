*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de



 q18_prod_res_ag_reg(i2,kcr,attributes) ..
                 vm_res_biomass_ag(i2,kcr,attributes)
                 =e=
                 (sum((cell(i2,j2),w), vm_area(j2,kcr,w)) * sum(ct,f18_multicropping(ct,i2)) * f18_cgf("intercept",kcr)
                 + vm_prod_reg(i2,kcr)*f18_cgf("slope",kcr))
                 *  f18_attributes_residue_ag(attributes,kcr);


  q18_res_field_balance(i2,kcr,attributes) ..
                  vm_res_biomass_ag(i2,kcr,attributes)
                  =e=
                  v18_res_ag_removal(i2,kcr,attributes)
                  + v18_res_ag_burn(i2,kcr,attributes)
                  + v18_res_ag_recycling(i2,kcr,attributes);

   q18_res_field_burn(i2,kcr,attributes) ..
                  v18_res_ag_burn(i2,kcr,attributes)
                  =e=
                  sum(ct, im_development_state(ct,i2) * f18_res_use_burn("high_income",kcr)
                  + (1-im_development_state(ct,i2)) * f18_res_use_burn("low_income",kcr))
                  * vm_res_biomass_ag(i2,kcr,attributes);

  q18_translate(i2,kres,attributes)..
                  sum(kres_kcr(kres,kcr), v18_res_ag_removal(i2,kcr,attributes))
                  =e=
                  vm_prod_reg(i2,kres) * fm_attributes(attributes,kres);


 q18_prod_res_bg_reg(i2,kcr,dm_nr) ..
                 vm_res_biomass_bg(i2,kcr,dm_nr)
                 =e=
                 (vm_prod_reg(i2,kcr) + vm_res_biomass_ag(i2,kcr,"dm"))*f18_cgf("bg_to_ag",kcr)
                 * f18_attributes_residue_bg(dm_nr,kcr);


  q18_res_recycling_nr(i2) ..
                  vm_res_recycling(i2,"nr")
                  =e=
                  sum(kcr,  v18_res_ag_recycling(i2,kcr,"nr")
                    + v18_res_ag_burn(i2,kcr,"nr")*(1-f18_res_combust_eff(kcr))
                    + vm_res_biomass_bg(i2,kcr,"nr")
                  );

  q18_res_recycling_pk(i2,pk18) ..
                  vm_res_recycling(i2,pk18)
                  =e=
                  sum(kcr,
                    v18_res_ag_recycling(i2,kcr,pk18)
                    + v18_res_ag_burn(i2,kcr,pk18)
                  );
*** EOF constraints.gms ***
