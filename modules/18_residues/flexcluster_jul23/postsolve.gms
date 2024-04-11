*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

****** Residues

*** EOF postsolve.gms ***

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov18_prod_res(t,j,kres,"marginal")                     = v18_prod_res.m(j,kres);
 ov18_res_biomass_ag_clust(t,j,kcr,"marginal")          = v18_res_biomass_ag_clust.m(j,kcr);
 ov_res_biomass_ag(t,i,kcr,attributes,"marginal")       = vm_res_biomass_ag.m(i,kcr,attributes);
 ov_res_biomass_bg(t,i,kcr,dm_nr,"marginal")            = vm_res_biomass_bg.m(i,kcr,dm_nr);
 ov18_res_ag_removal(t,j,kcr,attributes,"marginal")     = v18_res_ag_removal.m(j,kcr,attributes);
 ov18_res_ag_removal_reg(t,i,kcr,attributes,"marginal") = v18_res_ag_removal_reg.m(i,kcr,attributes);
 ov18_res_ag_recycling(t,i,kcr,attributes,"marginal")   = v18_res_ag_recycling.m(i,kcr,attributes);
 ov_res_ag_burn(t,i,kcr,attributes,"marginal")          = vm_res_ag_burn.m(i,kcr,attributes);
 ov_res_recycling(t,i,npk,"marginal")                   = vm_res_recycling.m(i,npk);
 ov_cost_prod_kres(t,i,kres,"marginal")                 = vm_cost_prod_kres.m(i,kres);
 oq18_prod_res_ag_clust(t,j,kcr,"marginal")             = q18_prod_res_ag_clust.m(j,kcr);
 oq18_prod_res_ag_reg(t,i,kcr,attributes,"marginal")    = q18_prod_res_ag_reg.m(i,kcr,attributes);
 oq18_prod_res_bg_clust(t,i,kcr,dm_nr,"marginal")       = q18_prod_res_bg_clust.m(i,kcr,dm_nr);
 oq18_regional_removals(t,i,kcr,attributes,"marginal")  = q18_regional_removals.m(i,kcr,attributes);
 oq18_res_field_balance(t,i,kcr,attributes,"marginal")  = q18_res_field_balance.m(i,kcr,attributes);
 oq18_clust_field_constraint(t,j,kres,"marginal")       = q18_clust_field_constraint.m(j,kres);
 oq18_res_field_burn(t,i,kcr,attributes,"marginal")     = q18_res_field_burn.m(i,kcr,attributes);
 oq18_translate(t,j,kres,attributes,"marginal")         = q18_translate.m(j,kres,attributes);
 oq18_res_recycling_nr(t,i,"marginal")                  = q18_res_recycling_nr.m(i);
 oq18_res_recycling_pk(t,i,pk18,"marginal")             = q18_res_recycling_pk.m(i,pk18);
 oq18_cost_prod_res(t,i,kres,"marginal")                = q18_cost_prod_res.m(i,kres);
 oq18_prod_res_reg(t,i,kall,"marginal")                 = q18_prod_res_reg.m(i,kall);
 ov18_prod_res(t,j,kres,"level")                        = v18_prod_res.l(j,kres);
 ov18_res_biomass_ag_clust(t,j,kcr,"level")             = v18_res_biomass_ag_clust.l(j,kcr);
 ov_res_biomass_ag(t,i,kcr,attributes,"level")          = vm_res_biomass_ag.l(i,kcr,attributes);
 ov_res_biomass_bg(t,i,kcr,dm_nr,"level")               = vm_res_biomass_bg.l(i,kcr,dm_nr);
 ov18_res_ag_removal(t,j,kcr,attributes,"level")        = v18_res_ag_removal.l(j,kcr,attributes);
 ov18_res_ag_removal_reg(t,i,kcr,attributes,"level")    = v18_res_ag_removal_reg.l(i,kcr,attributes);
 ov18_res_ag_recycling(t,i,kcr,attributes,"level")      = v18_res_ag_recycling.l(i,kcr,attributes);
 ov_res_ag_burn(t,i,kcr,attributes,"level")             = vm_res_ag_burn.l(i,kcr,attributes);
 ov_res_recycling(t,i,npk,"level")                      = vm_res_recycling.l(i,npk);
 ov_cost_prod_kres(t,i,kres,"level")                    = vm_cost_prod_kres.l(i,kres);
 oq18_prod_res_ag_clust(t,j,kcr,"level")                = q18_prod_res_ag_clust.l(j,kcr);
 oq18_prod_res_ag_reg(t,i,kcr,attributes,"level")       = q18_prod_res_ag_reg.l(i,kcr,attributes);
 oq18_prod_res_bg_clust(t,i,kcr,dm_nr,"level")          = q18_prod_res_bg_clust.l(i,kcr,dm_nr);
 oq18_regional_removals(t,i,kcr,attributes,"level")     = q18_regional_removals.l(i,kcr,attributes);
 oq18_res_field_balance(t,i,kcr,attributes,"level")     = q18_res_field_balance.l(i,kcr,attributes);
 oq18_clust_field_constraint(t,j,kres,"level")          = q18_clust_field_constraint.l(j,kres);
 oq18_res_field_burn(t,i,kcr,attributes,"level")        = q18_res_field_burn.l(i,kcr,attributes);
 oq18_translate(t,j,kres,attributes,"level")            = q18_translate.l(j,kres,attributes);
 oq18_res_recycling_nr(t,i,"level")                     = q18_res_recycling_nr.l(i);
 oq18_res_recycling_pk(t,i,pk18,"level")                = q18_res_recycling_pk.l(i,pk18);
 oq18_cost_prod_res(t,i,kres,"level")                   = q18_cost_prod_res.l(i,kres);
 oq18_prod_res_reg(t,i,kall,"level")                    = q18_prod_res_reg.l(i,kall);
 ov18_prod_res(t,j,kres,"upper")                        = v18_prod_res.up(j,kres);
 ov18_res_biomass_ag_clust(t,j,kcr,"upper")             = v18_res_biomass_ag_clust.up(j,kcr);
 ov_res_biomass_ag(t,i,kcr,attributes,"upper")          = vm_res_biomass_ag.up(i,kcr,attributes);
 ov_res_biomass_bg(t,i,kcr,dm_nr,"upper")               = vm_res_biomass_bg.up(i,kcr,dm_nr);
 ov18_res_ag_removal(t,j,kcr,attributes,"upper")        = v18_res_ag_removal.up(j,kcr,attributes);
 ov18_res_ag_removal_reg(t,i,kcr,attributes,"upper")    = v18_res_ag_removal_reg.up(i,kcr,attributes);
 ov18_res_ag_recycling(t,i,kcr,attributes,"upper")      = v18_res_ag_recycling.up(i,kcr,attributes);
 ov_res_ag_burn(t,i,kcr,attributes,"upper")             = vm_res_ag_burn.up(i,kcr,attributes);
 ov_res_recycling(t,i,npk,"upper")                      = vm_res_recycling.up(i,npk);
 ov_cost_prod_kres(t,i,kres,"upper")                    = vm_cost_prod_kres.up(i,kres);
 oq18_prod_res_ag_clust(t,j,kcr,"upper")                = q18_prod_res_ag_clust.up(j,kcr);
 oq18_prod_res_ag_reg(t,i,kcr,attributes,"upper")       = q18_prod_res_ag_reg.up(i,kcr,attributes);
 oq18_prod_res_bg_clust(t,i,kcr,dm_nr,"upper")          = q18_prod_res_bg_clust.up(i,kcr,dm_nr);
 oq18_regional_removals(t,i,kcr,attributes,"upper")     = q18_regional_removals.up(i,kcr,attributes);
 oq18_res_field_balance(t,i,kcr,attributes,"upper")     = q18_res_field_balance.up(i,kcr,attributes);
 oq18_clust_field_constraint(t,j,kres,"upper")          = q18_clust_field_constraint.up(j,kres);
 oq18_res_field_burn(t,i,kcr,attributes,"upper")        = q18_res_field_burn.up(i,kcr,attributes);
 oq18_translate(t,j,kres,attributes,"upper")            = q18_translate.up(j,kres,attributes);
 oq18_res_recycling_nr(t,i,"upper")                     = q18_res_recycling_nr.up(i);
 oq18_res_recycling_pk(t,i,pk18,"upper")                = q18_res_recycling_pk.up(i,pk18);
 oq18_cost_prod_res(t,i,kres,"upper")                   = q18_cost_prod_res.up(i,kres);
 oq18_prod_res_reg(t,i,kall,"upper")                    = q18_prod_res_reg.up(i,kall);
 ov18_prod_res(t,j,kres,"lower")                        = v18_prod_res.lo(j,kres);
 ov18_res_biomass_ag_clust(t,j,kcr,"lower")             = v18_res_biomass_ag_clust.lo(j,kcr);
 ov_res_biomass_ag(t,i,kcr,attributes,"lower")          = vm_res_biomass_ag.lo(i,kcr,attributes);
 ov_res_biomass_bg(t,i,kcr,dm_nr,"lower")               = vm_res_biomass_bg.lo(i,kcr,dm_nr);
 ov18_res_ag_removal(t,j,kcr,attributes,"lower")        = v18_res_ag_removal.lo(j,kcr,attributes);
 ov18_res_ag_removal_reg(t,i,kcr,attributes,"lower")    = v18_res_ag_removal_reg.lo(i,kcr,attributes);
 ov18_res_ag_recycling(t,i,kcr,attributes,"lower")      = v18_res_ag_recycling.lo(i,kcr,attributes);
 ov_res_ag_burn(t,i,kcr,attributes,"lower")             = vm_res_ag_burn.lo(i,kcr,attributes);
 ov_res_recycling(t,i,npk,"lower")                      = vm_res_recycling.lo(i,npk);
 ov_cost_prod_kres(t,i,kres,"lower")                    = vm_cost_prod_kres.lo(i,kres);
 oq18_prod_res_ag_clust(t,j,kcr,"lower")                = q18_prod_res_ag_clust.lo(j,kcr);
 oq18_prod_res_ag_reg(t,i,kcr,attributes,"lower")       = q18_prod_res_ag_reg.lo(i,kcr,attributes);
 oq18_prod_res_bg_clust(t,i,kcr,dm_nr,"lower")          = q18_prod_res_bg_clust.lo(i,kcr,dm_nr);
 oq18_regional_removals(t,i,kcr,attributes,"lower")     = q18_regional_removals.lo(i,kcr,attributes);
 oq18_res_field_balance(t,i,kcr,attributes,"lower")     = q18_res_field_balance.lo(i,kcr,attributes);
 oq18_clust_field_constraint(t,j,kres,"lower")          = q18_clust_field_constraint.lo(j,kres);
 oq18_res_field_burn(t,i,kcr,attributes,"lower")        = q18_res_field_burn.lo(i,kcr,attributes);
 oq18_translate(t,j,kres,attributes,"lower")            = q18_translate.lo(j,kres,attributes);
 oq18_res_recycling_nr(t,i,"lower")                     = q18_res_recycling_nr.lo(i);
 oq18_res_recycling_pk(t,i,pk18,"lower")                = q18_res_recycling_pk.lo(i,pk18);
 oq18_cost_prod_res(t,i,kres,"lower")                   = q18_cost_prod_res.lo(i,kres);
 oq18_prod_res_reg(t,i,kall,"lower")                    = q18_prod_res_reg.lo(i,kall);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################

