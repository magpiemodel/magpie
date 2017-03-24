*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

****** Residues

*** EOF postsolve.gms ***

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_res_biomass_ag(t,i,kcr,attributes,"marginal")      = vm_res_biomass_ag.m(i,kcr,attributes);
 ov_res_biomass_bg(t,i,kcr,dm_nr,"marginal")           = vm_res_biomass_bg.m(i,kcr,dm_nr);
 ov18_res_ag_removal(t,i,kcr,attributes,"marginal")    = v18_res_ag_removal.m(i,kcr,attributes);
 ov18_res_ag_recycling(t,i,kcr,attributes,"marginal")  = v18_res_ag_recycling.m(i,kcr,attributes);
 ov18_res_ag_burn(t,i,kcr,attributes,"marginal")       = v18_res_ag_burn.m(i,kcr,attributes);
 ov_res_recycling(t,i,npk,"marginal")                  = vm_res_recycling.m(i,npk);
 oq18_prod_res_ag_reg(t,i,kcr,attributes,"marginal")   = q18_prod_res_ag_reg.m(i,kcr,attributes);
 oq18_prod_res_bg_reg(t,i,kcr,dm_nr,"marginal")        = q18_prod_res_bg_reg.m(i,kcr,dm_nr);
 oq18_res_field_balance(t,i,kcr,attributes,"marginal") = q18_res_field_balance.m(i,kcr,attributes);
 oq18_res_field_burn(t,i,kcr,attributes,"marginal")    = q18_res_field_burn.m(i,kcr,attributes);
 oq18_translate(t,i,kres,attributes,"marginal")        = q18_translate.m(i,kres,attributes);
 oq18_res_recycling_nr(t,i,"marginal")                 = q18_res_recycling_nr.m(i);
 oq18_res_recycling_pk(t,i,pk18,"marginal")            = q18_res_recycling_pk.m(i,pk18);
 ov_res_biomass_ag(t,i,kcr,attributes,"level")         = vm_res_biomass_ag.l(i,kcr,attributes);
 ov_res_biomass_bg(t,i,kcr,dm_nr,"level")              = vm_res_biomass_bg.l(i,kcr,dm_nr);
 ov18_res_ag_removal(t,i,kcr,attributes,"level")       = v18_res_ag_removal.l(i,kcr,attributes);
 ov18_res_ag_recycling(t,i,kcr,attributes,"level")     = v18_res_ag_recycling.l(i,kcr,attributes);
 ov18_res_ag_burn(t,i,kcr,attributes,"level")          = v18_res_ag_burn.l(i,kcr,attributes);
 ov_res_recycling(t,i,npk,"level")                     = vm_res_recycling.l(i,npk);
 oq18_prod_res_ag_reg(t,i,kcr,attributes,"level")      = q18_prod_res_ag_reg.l(i,kcr,attributes);
 oq18_prod_res_bg_reg(t,i,kcr,dm_nr,"level")           = q18_prod_res_bg_reg.l(i,kcr,dm_nr);
 oq18_res_field_balance(t,i,kcr,attributes,"level")    = q18_res_field_balance.l(i,kcr,attributes);
 oq18_res_field_burn(t,i,kcr,attributes,"level")       = q18_res_field_burn.l(i,kcr,attributes);
 oq18_translate(t,i,kres,attributes,"level")           = q18_translate.l(i,kres,attributes);
 oq18_res_recycling_nr(t,i,"level")                    = q18_res_recycling_nr.l(i);
 oq18_res_recycling_pk(t,i,pk18,"level")               = q18_res_recycling_pk.l(i,pk18);
 ov_res_biomass_ag(t,i,kcr,attributes,"upper")         = vm_res_biomass_ag.up(i,kcr,attributes);
 ov_res_biomass_bg(t,i,kcr,dm_nr,"upper")              = vm_res_biomass_bg.up(i,kcr,dm_nr);
 ov18_res_ag_removal(t,i,kcr,attributes,"upper")       = v18_res_ag_removal.up(i,kcr,attributes);
 ov18_res_ag_recycling(t,i,kcr,attributes,"upper")     = v18_res_ag_recycling.up(i,kcr,attributes);
 ov18_res_ag_burn(t,i,kcr,attributes,"upper")          = v18_res_ag_burn.up(i,kcr,attributes);
 ov_res_recycling(t,i,npk,"upper")                     = vm_res_recycling.up(i,npk);
 oq18_prod_res_ag_reg(t,i,kcr,attributes,"upper")      = q18_prod_res_ag_reg.up(i,kcr,attributes);
 oq18_prod_res_bg_reg(t,i,kcr,dm_nr,"upper")           = q18_prod_res_bg_reg.up(i,kcr,dm_nr);
 oq18_res_field_balance(t,i,kcr,attributes,"upper")    = q18_res_field_balance.up(i,kcr,attributes);
 oq18_res_field_burn(t,i,kcr,attributes,"upper")       = q18_res_field_burn.up(i,kcr,attributes);
 oq18_translate(t,i,kres,attributes,"upper")           = q18_translate.up(i,kres,attributes);
 oq18_res_recycling_nr(t,i,"upper")                    = q18_res_recycling_nr.up(i);
 oq18_res_recycling_pk(t,i,pk18,"upper")               = q18_res_recycling_pk.up(i,pk18);
 ov_res_biomass_ag(t,i,kcr,attributes,"lower")         = vm_res_biomass_ag.lo(i,kcr,attributes);
 ov_res_biomass_bg(t,i,kcr,dm_nr,"lower")              = vm_res_biomass_bg.lo(i,kcr,dm_nr);
 ov18_res_ag_removal(t,i,kcr,attributes,"lower")       = v18_res_ag_removal.lo(i,kcr,attributes);
 ov18_res_ag_recycling(t,i,kcr,attributes,"lower")     = v18_res_ag_recycling.lo(i,kcr,attributes);
 ov18_res_ag_burn(t,i,kcr,attributes,"lower")          = v18_res_ag_burn.lo(i,kcr,attributes);
 ov_res_recycling(t,i,npk,"lower")                     = vm_res_recycling.lo(i,npk);
 oq18_prod_res_ag_reg(t,i,kcr,attributes,"lower")      = q18_prod_res_ag_reg.lo(i,kcr,attributes);
 oq18_prod_res_bg_reg(t,i,kcr,dm_nr,"lower")           = q18_prod_res_bg_reg.lo(i,kcr,dm_nr);
 oq18_res_field_balance(t,i,kcr,attributes,"lower")    = q18_res_field_balance.lo(i,kcr,attributes);
 oq18_res_field_burn(t,i,kcr,attributes,"lower")       = q18_res_field_burn.lo(i,kcr,attributes);
 oq18_translate(t,i,kres,attributes,"lower")           = q18_translate.lo(i,kres,attributes);
 oq18_res_recycling_nr(t,i,"lower")                    = q18_res_recycling_nr.lo(i);
 oq18_res_recycling_pk(t,i,pk18,"lower")               = q18_res_recycling_pk.lo(i,pk18);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################

