*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de


parameters
 i55_manure_recycling_share(i,kli,awms_conf,npk)               share of manure recycled (1)
 ic55_manure_fuel_shr(i,kli)                                   share of manure excreted on pastures used for fuel()
 ic55_awms_shr(i,kli,awms_conf)                                share of manure Nr managed in each animal waste management systems (1)
;

positive variables
 vm_manure(i, kli, awms, npk) calculation of manure excreted in confinements (Tg nutrient)
 v55_feed_intake(i, kli, awms, npk) calculation of manure excreted in confinements (Tg nutrient)
 vm_manure_recycling(i, npk)   Manure being recycled to croplands (Tg nutrient)
 vm_manure_confinement(i,kli,awms_conf,npk) Manure excreted in confinements managed in different awms (Tg nutrient)
;


equations
 q55_bal_intake_grazing_pasture(i,kli, npk) nutrient balance for intake of grazing animals on pastures
 q55_bal_intake_confinement(i,kli, npk) nutrient balance for intake in confinement
 q55_bal_intake_grazing_cropland(i,kli, npk) nutrient balance for intake of grazing animals on cropland
 q55_bal_intake_fuel(i,kli, npk)       nutrient balance for intake of grazing animals on pasture whose excreate are collected for household fuel

 q55_bal_manure(i,kli,awms,npk)    calculation of manure
 q55_manure_confinement(i,kli,awms_conf,npk) manure from animals in confinement managed in different awms
 q55_manure_recycling(i, npk)      manure from animals in confinement recycling to cropland
;



*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_manure(t,i,kli,awms,npk,type)                    calculation of manure excreted in confinements (Tg nutrient)
 ov55_feed_intake(t,i,kli,awms,npk,type)             calculation of manure excreted in confinements (Tg nutrient)
 ov_manure_recycling(t,i,npk,type)                   Manure being recycled to croplands (Tg nutrient)
 ov_manure_confinement(t,i,kli,awms_conf,npk,type)   Manure excreted in confinements managed in different awms (Tg nutrient)
 oq55_bal_intake_grazing_pasture(t,i,kli,npk,type)   nutrient balance for intake of grazing animals on pastures
 oq55_bal_intake_confinement(t,i,kli,npk,type)       nutrient balance for intake in confinement
 oq55_bal_intake_grazing_cropland(t,i,kli,npk,type)  nutrient balance for intake of grazing animals on cropland
 oq55_bal_intake_fuel(t,i,kli,npk,type)              nutrient balance for intake of grazing animals on pasture whose excreate are collected for household fuel
 oq55_bal_manure(t,i,kli,awms,npk,type)              calculation of manure
 oq55_manure_confinement(t,i,kli,awms_conf,npk,type) manure from animals in confinement managed in different awms
 oq55_manure_recycling(t,i,npk,type)                 manure from animals in confinement recycling to cropland
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
