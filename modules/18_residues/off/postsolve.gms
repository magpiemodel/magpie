*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_res_biomass_ag(t,i,kcr,attributes,"marginal") = vm_res_biomass_ag.m(i,kcr,attributes);
 ov_res_biomass_bg(t,i,kcr,dm_nr,"marginal")      = vm_res_biomass_bg.m(i,kcr,dm_nr);
 ov_res_recycling(t,i,npk,"marginal")             = vm_res_recycling.m(i,npk);
 ov_res_biomass_ag(t,i,kcr,attributes,"level")    = vm_res_biomass_ag.l(i,kcr,attributes);
 ov_res_biomass_bg(t,i,kcr,dm_nr,"level")         = vm_res_biomass_bg.l(i,kcr,dm_nr);
 ov_res_recycling(t,i,npk,"level")                = vm_res_recycling.l(i,npk);
 ov_res_biomass_ag(t,i,kcr,attributes,"upper")    = vm_res_biomass_ag.up(i,kcr,attributes);
 ov_res_biomass_bg(t,i,kcr,dm_nr,"upper")         = vm_res_biomass_bg.up(i,kcr,dm_nr);
 ov_res_recycling(t,i,npk,"upper")                = vm_res_recycling.up(i,npk);
 ov_res_biomass_ag(t,i,kcr,attributes,"lower")    = vm_res_biomass_ag.lo(i,kcr,attributes);
 ov_res_biomass_bg(t,i,kcr,dm_nr,"lower")         = vm_res_biomass_bg.lo(i,kcr,dm_nr);
 ov_res_recycling(t,i,npk,"lower")                = vm_res_recycling.lo(i,npk);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
