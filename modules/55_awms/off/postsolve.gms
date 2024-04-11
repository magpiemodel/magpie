*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de




*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_manure(t,i,kli,awms,npk,"marginal")                  = vm_manure.m(i,kli,awms,npk);
 ov_manure_recycling(t,i,npk,"marginal")                 = vm_manure_recycling.m(i,npk);
 ov_manure_confinement(t,i,kli,awms_conf,npk,"marginal") = vm_manure_confinement.m(i,kli,awms_conf,npk);
 ov_manure(t,i,kli,awms,npk,"level")                     = vm_manure.l(i,kli,awms,npk);
 ov_manure_recycling(t,i,npk,"level")                    = vm_manure_recycling.l(i,npk);
 ov_manure_confinement(t,i,kli,awms_conf,npk,"level")    = vm_manure_confinement.l(i,kli,awms_conf,npk);
 ov_manure(t,i,kli,awms,npk,"upper")                     = vm_manure.up(i,kli,awms,npk);
 ov_manure_recycling(t,i,npk,"upper")                    = vm_manure_recycling.up(i,npk);
 ov_manure_confinement(t,i,kli,awms_conf,npk,"upper")    = vm_manure_confinement.up(i,kli,awms_conf,npk);
 ov_manure(t,i,kli,awms,npk,"lower")                     = vm_manure.lo(i,kli,awms,npk);
 ov_manure_recycling(t,i,npk,"lower")                    = vm_manure_recycling.lo(i,npk);
 ov_manure_confinement(t,i,kli,awms_conf,npk,"lower")    = vm_manure_confinement.lo(i,kli,awms_conf,npk);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################

