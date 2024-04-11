*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


parameters
 i55_manure_recycling_share(i,kli,awms_conf,npk)  Share of manure recycled (tNr per tNr)
 ic55_manure_fuel_shr(i,kli)                      Share of manure excreted on pastures used for fuel (tNr per tNr)
 ic55_awms_shr(i,kli,awms_conf)                   Share of manure Nr managed in each animal waste management systems (tNr per tNr)
 p55_region_shr(t_all,i)                          AWM scenario share of the region (1)
 p55_country_dummy(iso)                           Dummy parameter indicating whether country is affected by selected awm scenario (1)
;


positive variables
 vm_manure(i, kli, awms, npk)                 Calculation of manure excreted in confinements (mio t X)
 v55_feed_intake(i, kli, awms, npk)           Calculation of manure excreted in confinements (mio t X)
 vm_manure_recycling(i, npk)                  Manure being recycled to croplands (mio t X)
 vm_manure_confinement(i,kli,awms_conf,npk)   Manure excreted in confinements managed in different awms (mio t X)
;


equations
 q55_bal_intake_grazing_pasture(i,kli, npk)   Nutrient balance for intake of grazing animals on pastures (mio t X)
 q55_bal_intake_confinement(i,kli, npk)       Nutrient balance for intake in confinement  (mio t X)
 q55_bal_intake_grazing_cropland(i,kli, npk)  Nutrient balance for intake of grazing animals on cropland  (mio t X)
 q55_bal_intake_fuel(i,kli, npk)              Nutrient balance for intake of grazing animals on pasture whose excreate are collected for household fuel (mio t X)
 q55_bal_manure(i,kli,awms,npk)               Calculation of manure (mio t X)
 q55_manure_confinement(i,kli,awms_conf,npk)  Manure from animals in confinement managed in different awms (mio t X)
 q55_manure_recycling(i, npk)                 Manure from animals in confinement recycling to cropland (mio t X)
;



*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_manure(t,i,kli,awms,npk,type)                    Calculation of manure excreted in confinements (mio t X)
 ov55_feed_intake(t,i,kli,awms,npk,type)             Calculation of manure excreted in confinements (mio t X)
 ov_manure_recycling(t,i,npk,type)                   Manure being recycled to croplands (mio t X)
 ov_manure_confinement(t,i,kli,awms_conf,npk,type)   Manure excreted in confinements managed in different awms (mio t X)
 oq55_bal_intake_grazing_pasture(t,i,kli,npk,type)   Nutrient balance for intake of grazing animals on pastures (mio t X)
 oq55_bal_intake_confinement(t,i,kli,npk,type)       Nutrient balance for intake in confinement  (mio t X)
 oq55_bal_intake_grazing_cropland(t,i,kli,npk,type)  Nutrient balance for intake of grazing animals on cropland  (mio t X)
 oq55_bal_intake_fuel(t,i,kli,npk,type)              Nutrient balance for intake of grazing animals on pasture whose excreate are collected for household fuel (mio t X)
 oq55_bal_manure(t,i,kli,awms,npk,type)              Calculation of manure (mio t X)
 oq55_manure_confinement(t,i,kli,awms_conf,npk,type) Manure from animals in confinement managed in different awms (mio t X)
 oq55_manure_recycling(t,i,npk,type)                 Manure from animals in confinement recycling to cropland (mio t X)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
