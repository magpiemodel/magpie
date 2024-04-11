*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

 

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_manure(t,i,kli,awms,npk,"marginal")                    = vm_manure.m(i,kli,awms,npk);
 ov55_feed_intake(t,i,kli,awms,npk,"marginal")             = v55_feed_intake.m(i,kli,awms,npk);
 ov_manure_recycling(t,i,npk,"marginal")                   = vm_manure_recycling.m(i,npk);
 ov_manure_confinement(t,i,kli,awms_conf,npk,"marginal")   = vm_manure_confinement.m(i,kli,awms_conf,npk);
 oq55_bal_intake_grazing_pasture(t,i,kli,npk,"marginal")   = q55_bal_intake_grazing_pasture.m(i,kli,npk);
 oq55_bal_intake_confinement(t,i,kli,npk,"marginal")       = q55_bal_intake_confinement.m(i,kli,npk);
 oq55_bal_intake_grazing_cropland(t,i,kli,npk,"marginal")  = q55_bal_intake_grazing_cropland.m(i,kli,npk);
 oq55_bal_intake_fuel(t,i,kli,npk,"marginal")              = q55_bal_intake_fuel.m(i,kli,npk);
 oq55_bal_manure(t,i,kli,awms,npk,"marginal")              = q55_bal_manure.m(i,kli,awms,npk);
 oq55_manure_confinement(t,i,kli,awms_conf,npk,"marginal") = q55_manure_confinement.m(i,kli,awms_conf,npk);
 oq55_manure_recycling(t,i,npk,"marginal")                 = q55_manure_recycling.m(i,npk);
 ov_manure(t,i,kli,awms,npk,"level")                       = vm_manure.l(i,kli,awms,npk);
 ov55_feed_intake(t,i,kli,awms,npk,"level")                = v55_feed_intake.l(i,kli,awms,npk);
 ov_manure_recycling(t,i,npk,"level")                      = vm_manure_recycling.l(i,npk);
 ov_manure_confinement(t,i,kli,awms_conf,npk,"level")      = vm_manure_confinement.l(i,kli,awms_conf,npk);
 oq55_bal_intake_grazing_pasture(t,i,kli,npk,"level")      = q55_bal_intake_grazing_pasture.l(i,kli,npk);
 oq55_bal_intake_confinement(t,i,kli,npk,"level")          = q55_bal_intake_confinement.l(i,kli,npk);
 oq55_bal_intake_grazing_cropland(t,i,kli,npk,"level")     = q55_bal_intake_grazing_cropland.l(i,kli,npk);
 oq55_bal_intake_fuel(t,i,kli,npk,"level")                 = q55_bal_intake_fuel.l(i,kli,npk);
 oq55_bal_manure(t,i,kli,awms,npk,"level")                 = q55_bal_manure.l(i,kli,awms,npk);
 oq55_manure_confinement(t,i,kli,awms_conf,npk,"level")    = q55_manure_confinement.l(i,kli,awms_conf,npk);
 oq55_manure_recycling(t,i,npk,"level")                    = q55_manure_recycling.l(i,npk);
 ov_manure(t,i,kli,awms,npk,"upper")                       = vm_manure.up(i,kli,awms,npk);
 ov55_feed_intake(t,i,kli,awms,npk,"upper")                = v55_feed_intake.up(i,kli,awms,npk);
 ov_manure_recycling(t,i,npk,"upper")                      = vm_manure_recycling.up(i,npk);
 ov_manure_confinement(t,i,kli,awms_conf,npk,"upper")      = vm_manure_confinement.up(i,kli,awms_conf,npk);
 oq55_bal_intake_grazing_pasture(t,i,kli,npk,"upper")      = q55_bal_intake_grazing_pasture.up(i,kli,npk);
 oq55_bal_intake_confinement(t,i,kli,npk,"upper")          = q55_bal_intake_confinement.up(i,kli,npk);
 oq55_bal_intake_grazing_cropland(t,i,kli,npk,"upper")     = q55_bal_intake_grazing_cropland.up(i,kli,npk);
 oq55_bal_intake_fuel(t,i,kli,npk,"upper")                 = q55_bal_intake_fuel.up(i,kli,npk);
 oq55_bal_manure(t,i,kli,awms,npk,"upper")                 = q55_bal_manure.up(i,kli,awms,npk);
 oq55_manure_confinement(t,i,kli,awms_conf,npk,"upper")    = q55_manure_confinement.up(i,kli,awms_conf,npk);
 oq55_manure_recycling(t,i,npk,"upper")                    = q55_manure_recycling.up(i,npk);
 ov_manure(t,i,kli,awms,npk,"lower")                       = vm_manure.lo(i,kli,awms,npk);
 ov55_feed_intake(t,i,kli,awms,npk,"lower")                = v55_feed_intake.lo(i,kli,awms,npk);
 ov_manure_recycling(t,i,npk,"lower")                      = vm_manure_recycling.lo(i,npk);
 ov_manure_confinement(t,i,kli,awms_conf,npk,"lower")      = vm_manure_confinement.lo(i,kli,awms_conf,npk);
 oq55_bal_intake_grazing_pasture(t,i,kli,npk,"lower")      = q55_bal_intake_grazing_pasture.lo(i,kli,npk);
 oq55_bal_intake_confinement(t,i,kli,npk,"lower")          = q55_bal_intake_confinement.lo(i,kli,npk);
 oq55_bal_intake_grazing_cropland(t,i,kli,npk,"lower")     = q55_bal_intake_grazing_cropland.lo(i,kli,npk);
 oq55_bal_intake_fuel(t,i,kli,npk,"lower")                 = q55_bal_intake_fuel.lo(i,kli,npk);
 oq55_bal_manure(t,i,kli,awms,npk,"lower")                 = q55_bal_manure.lo(i,kli,awms,npk);
 oq55_manure_confinement(t,i,kli,awms_conf,npk,"lower")    = q55_manure_confinement.lo(i,kli,awms_conf,npk);
 oq55_manure_recycling(t,i,npk,"lower")                    = q55_manure_recycling.lo(i,npk);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################

