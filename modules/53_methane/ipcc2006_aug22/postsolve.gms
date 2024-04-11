*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de



*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 oq53_emissionbal_ch4_ent_ferm(t,i,"marginal") = q53_emissionbal_ch4_ent_ferm.m(i);
 oq53_emissionbal_ch4_awms(t,i,"marginal")     = q53_emissionbal_ch4_awms.m(i);
 oq53_emissionbal_ch4_rice(t,i,"marginal")     = q53_emissionbal_ch4_rice.m(i);
 oq53_emissions_resid_burn(t,i,"marginal")     = q53_emissions_resid_burn.m(i);
 oq53_emissionbal_ch4_ent_ferm(t,i,"level")    = q53_emissionbal_ch4_ent_ferm.l(i);
 oq53_emissionbal_ch4_awms(t,i,"level")        = q53_emissionbal_ch4_awms.l(i);
 oq53_emissionbal_ch4_rice(t,i,"level")        = q53_emissionbal_ch4_rice.l(i);
 oq53_emissions_resid_burn(t,i,"level")        = q53_emissions_resid_burn.l(i);
 oq53_emissionbal_ch4_ent_ferm(t,i,"upper")    = q53_emissionbal_ch4_ent_ferm.up(i);
 oq53_emissionbal_ch4_awms(t,i,"upper")        = q53_emissionbal_ch4_awms.up(i);
 oq53_emissionbal_ch4_rice(t,i,"upper")        = q53_emissionbal_ch4_rice.up(i);
 oq53_emissions_resid_burn(t,i,"upper")        = q53_emissions_resid_burn.up(i);
 oq53_emissionbal_ch4_ent_ferm(t,i,"lower")    = q53_emissionbal_ch4_ent_ferm.lo(i);
 oq53_emissionbal_ch4_awms(t,i,"lower")        = q53_emissionbal_ch4_awms.lo(i);
 oq53_emissionbal_ch4_rice(t,i,"lower")        = q53_emissionbal_ch4_rice.lo(i);
 oq53_emissions_resid_burn(t,i,"lower")        = q53_emissions_resid_burn.lo(i);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################

