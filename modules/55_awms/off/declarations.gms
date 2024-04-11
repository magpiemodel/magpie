*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


positive variables
 vm_manure(i, kli, awms, npk) calculation of manure excreted in confinements (Tg nutrient)
 vm_manure_recycling(i, npk)   Manure being recycled to croplands (Tg nutrient)
 vm_manure_confinement(i,kli,awms_conf,npk) Manure excreted in confinements managed in different awms (Tg nutrient)
;
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_manure(t,i,kli,awms,npk,type)                  calculation of manure excreted in confinements (Tg nutrient)
 ov_manure_recycling(t,i,npk,type)                 Manure being recycled to croplands (Tg nutrient)
 ov_manure_confinement(t,i,kli,awms_conf,npk,type) Manure excreted in confinements managed in different awms (Tg nutrient)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
