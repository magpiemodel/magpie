*** |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

****** Residues

*** EOF postsolve.gms ***

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov18_prod_res(t,j,kres,"marginal")                    = v18_prod_res.m(j,kres);
 ov_res_biomass_ag(t,i,kcr,w,attributes,"marginal")      = vm_res_biomass_ag.m(i,kcr,w,attributes);
 ov_res_biomass_bg(t,i,kcr,w,dm_cnr,"marginal")          = vm_res_biomass_bg.m(i,kcr,w,dm_cnr);
 ov18_res_ag_removal(t,i,kcr,w,attributes,"marginal")    = v18_res_ag_removal.m(i,kcr,w,attributes);
 ov18_res_ag_recycling(t,i,kcr,w,attributes,"marginal")  = v18_res_ag_recycling.m(i,kcr,w,attributes);
 ov_res_ag_burn(t,i,kcr,w,attributes,"marginal")         = vm_res_ag_burn.m(i,kcr,w,attributes);
 ov_res_recycling(t,i,kcr,w,attributes,"marginal")       = vm_res_recycling.m(i,kcr,w,attributes);
 ov_cost_prod_kres(t,i,kres,"marginal")                  = vm_cost_prod_kres.m(i,kres);
 oq18_prod_res_ag_reg(t,i,kcr,w,attributes,"marginal")   = q18_prod_res_ag_reg.m(i,kcr,w,attributes);
 oq18_prod_res_bg_reg(t,i,kcr,w,dm_cnr,"marginal")       = q18_prod_res_bg_reg.m(i,kcr,w,dm_cnr);
 oq18_res_field_balance(t,i,kcr,w,attributes,"marginal") = q18_res_field_balance.m(i,kcr,w,attributes);
 oq18_res_field_burn(t,i,kcr,w,attributes,"marginal")    = q18_res_field_burn.m(i,kcr,w,attributes);
 oq18_translate(t,i,kres,attributes,"marginal")          = q18_translate.m(i,kres,attributes);
 oq18_res_recycling_cnr(t,i,kcr,w,c_nr,"marginal")       = q18_res_recycling_cnr.m(i,kcr,w,c_nr);
 oq18_res_recycling_pk(t,i,kcr,w,pk18,"marginal")        = q18_res_recycling_pk.m(i,kcr,w,pk18);
 oq18_cost_prod_res(t,i,kres,"marginal")                 = q18_cost_prod_res.m(i,kres);
 ov_res_biomass_ag(t,i,kcr,w,attributes,"level")         = vm_res_biomass_ag.l(i,kcr,w,attributes);
 ov_res_biomass_bg(t,i,kcr,w,dm_cnr,"level")             = vm_res_biomass_bg.l(i,kcr,w,dm_cnr);
 ov18_res_ag_removal(t,i,kcr,w,attributes,"level")       = v18_res_ag_removal.l(i,kcr,w,attributes);
 ov18_res_ag_recycling(t,i,kcr,w,attributes,"level")     = v18_res_ag_recycling.l(i,kcr,w,attributes);
 ov_res_ag_burn(t,i,kcr,w,attributes,"level")            = vm_res_ag_burn.l(i,kcr,w,attributes);
 ov_res_recycling(t,i,kcr,w,attributes,"level")          = vm_res_recycling.l(i,kcr,w,attributes);
 ov_cost_prod_kres(t,i,kres,"level")                     = vm_cost_prod_kres.l(i,kres);
 oq18_prod_res_ag_reg(t,i,kcr,w,attributes,"level")      = q18_prod_res_ag_reg.l(i,kcr,w,attributes);
 oq18_prod_res_bg_reg(t,i,kcr,w,dm_cnr,"level")          = q18_prod_res_bg_reg.l(i,kcr,w,dm_cnr);
 oq18_res_field_balance(t,i,kcr,w,attributes,"level")    = q18_res_field_balance.l(i,kcr,w,attributes);
 oq18_res_field_burn(t,i,kcr,w,attributes,"level")       = q18_res_field_burn.l(i,kcr,w,attributes);
 oq18_translate(t,i,kres,attributes,"level")             = q18_translate.l(i,kres,attributes);
 oq18_res_recycling_cnr(t,i,kcr,w,c_nr,"level")          = q18_res_recycling_cnr.l(i,kcr,w,c_nr);
 oq18_res_recycling_pk(t,i,kcr,w,pk18,"level")           = q18_res_recycling_pk.l(i,kcr,w,pk18);
 oq18_cost_prod_res(t,i,kres,"level")                    = q18_cost_prod_res.l(i,kres);
 ov_res_biomass_ag(t,i,kcr,w,attributes,"upper")         = vm_res_biomass_ag.up(i,kcr,w,attributes);
 ov_res_biomass_bg(t,i,kcr,w,dm_cnr,"upper")             = vm_res_biomass_bg.up(i,kcr,w,dm_cnr);
 ov18_res_ag_removal(t,i,kcr,w,attributes,"upper")       = v18_res_ag_removal.up(i,kcr,w,attributes);
 ov18_res_ag_recycling(t,i,kcr,w,attributes,"upper")     = v18_res_ag_recycling.up(i,kcr,w,attributes);
 ov_res_ag_burn(t,i,kcr,w,attributes,"upper")            = vm_res_ag_burn.up(i,kcr,w,attributes);
 ov_res_recycling(t,i,kcr,w,attributes,"upper")          = vm_res_recycling.up(i,kcr,w,attributes);
 ov_cost_prod_kres(t,i,kres,"upper")                     = vm_cost_prod_kres.up(i,kres);
 oq18_prod_res_ag_reg(t,i,kcr,w,attributes,"upper")      = q18_prod_res_ag_reg.up(i,kcr,w,attributes);
 oq18_prod_res_bg_reg(t,i,kcr,w,dm_cnr,"upper")          = q18_prod_res_bg_reg.up(i,kcr,w,dm_cnr);
 oq18_res_field_balance(t,i,kcr,w,attributes,"upper")    = q18_res_field_balance.up(i,kcr,w,attributes);
 oq18_res_field_burn(t,i,kcr,w,attributes,"upper")       = q18_res_field_burn.up(i,kcr,w,attributes);
 oq18_translate(t,i,kres,attributes,"upper")             = q18_translate.up(i,kres,attributes);
 oq18_res_recycling_cnr(t,i,kcr,w,c_nr,"upper")          = q18_res_recycling_cnr.up(i,kcr,w,c_nr);
 oq18_res_recycling_pk(t,i,kcr,w,pk18,"upper")           = q18_res_recycling_pk.up(i,kcr,w,pk18);
 oq18_cost_prod_res(t,i,kres,"upper")                    = q18_cost_prod_res.up(i,kres);
 ov_res_biomass_ag(t,i,kcr,w,attributes,"lower")         = vm_res_biomass_ag.lo(i,kcr,w,attributes);
 ov_res_biomass_bg(t,i,kcr,w,dm_cnr,"lower")             = vm_res_biomass_bg.lo(i,kcr,w,dm_cnr);
 ov18_res_ag_removal(t,i,kcr,w,attributes,"lower")       = v18_res_ag_removal.lo(i,kcr,w,attributes);
 ov18_res_ag_recycling(t,i,kcr,w,attributes,"lower")     = v18_res_ag_recycling.lo(i,kcr,w,attributes);
 ov_res_ag_burn(t,i,kcr,w,attributes,"lower")            = vm_res_ag_burn.lo(i,kcr,w,attributes);
 ov_res_recycling(t,i,kcr,w,attributes,"lower")          = vm_res_recycling.lo(i,kcr,w,attributes);
 ov_cost_prod_kres(t,i,kres,"lower")                     = vm_cost_prod_kres.lo(i,kres);
 oq18_prod_res_ag_reg(t,i,kcr,w,attributes,"lower")      = q18_prod_res_ag_reg.lo(i,kcr,w,attributes);
 oq18_prod_res_bg_reg(t,i,kcr,w,dm_cnr,"lower")          = q18_prod_res_bg_reg.lo(i,kcr,w,dm_cnr);
 oq18_res_field_balance(t,i,kcr,w,attributes,"lower")    = q18_res_field_balance.lo(i,kcr,w,attributes);
 oq18_res_field_burn(t,i,kcr,w,attributes,"lower")       = q18_res_field_burn.lo(i,kcr,w,attributes);
 oq18_translate(t,i,kres,attributes,"lower")             = q18_translate.lo(i,kres,attributes);
 oq18_res_recycling_cnr(t,i,kcr,w,c_nr,"lower")          = q18_res_recycling_cnr.lo(i,kcr,w,c_nr);
 oq18_res_recycling_pk(t,i,kcr,w,pk18,"lower")           = q18_res_recycling_pk.lo(i,kcr,w,pk18);
 oq18_cost_prod_res(t,i,kres,"lower")                    = q18_cost_prod_res.lo(i,kres);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################

