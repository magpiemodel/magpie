*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de


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
