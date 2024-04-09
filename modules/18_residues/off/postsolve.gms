*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_res_biomass_ag(t,i,kcr,w,attributes,"marginal") = vm_res_biomass_ag.m(i,kcr,w,attributes);
 ov_res_biomass_bg(t,i,kcr,w,dm_cnr,"marginal")     = vm_res_biomass_bg.m(i,kcr,w,dm_cnr);
 ov_res_recycling(t,i,kcr,w,attributes,"marginal")  = vm_res_recycling.m(i,kcr,w,attributes);
 ov_res_ag_burn(t,i,kcr,w,attributes,"marginal")    = vm_res_ag_burn.m(i,kcr,w,attributes);
 ov_cost_prod_kres(t,i,kres,"marginal")             = vm_cost_prod_kres.m(i,kres);
 ov_res_biomass_ag(t,i,kcr,w,attributes,"level")    = vm_res_biomass_ag.l(i,kcr,w,attributes);
 ov_res_biomass_bg(t,i,kcr,w,dm_cnr,"level")        = vm_res_biomass_bg.l(i,kcr,w,dm_cnr);
 ov_res_recycling(t,i,kcr,w,attributes,"level")     = vm_res_recycling.l(i,kcr,w,attributes);
 ov_res_ag_burn(t,i,kcr,w,attributes,"level")       = vm_res_ag_burn.l(i,kcr,w,attributes);
 ov_cost_prod_kres(t,i,kres,"level")                = vm_cost_prod_kres.l(i,kres);
 ov_res_biomass_ag(t,i,kcr,w,attributes,"upper")    = vm_res_biomass_ag.up(i,kcr,w,attributes);
 ov_res_biomass_bg(t,i,kcr,w,dm_cnr,"upper")        = vm_res_biomass_bg.up(i,kcr,w,dm_cnr);
 ov_res_recycling(t,i,kcr,w,attributes,"upper")     = vm_res_recycling.up(i,kcr,w,attributes);
 ov_res_ag_burn(t,i,kcr,w,attributes,"upper")       = vm_res_ag_burn.up(i,kcr,w,attributes);
 ov_cost_prod_kres(t,i,kres,"upper")                = vm_cost_prod_kres.up(i,kres);
 ov_res_biomass_ag(t,i,kcr,w,attributes,"lower")    = vm_res_biomass_ag.lo(i,kcr,w,attributes);
 ov_res_biomass_bg(t,i,kcr,w,dm_cnr,"lower")        = vm_res_biomass_bg.lo(i,kcr,w,dm_cnr);
 ov_res_recycling(t,i,kcr,w,attributes,"lower")     = vm_res_recycling.lo(i,kcr,w,attributes);
 ov_res_ag_burn(t,i,kcr,w,attributes,"lower")       = vm_res_ag_burn.lo(i,kcr,w,attributes);
 ov_cost_prod_kres(t,i,kres,"lower")                = vm_cost_prod_kres.lo(i,kres);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
