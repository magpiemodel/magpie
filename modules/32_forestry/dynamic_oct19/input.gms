*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de
$setglobal c32_aff_mask  noboreal
* options: unrestricted, noboreal, onlytropical
$setglobal c32_aff_policy  npi
* options: none, npi, ndc
$setglobal c32_aff_bgp  djf
* options: ann,djf,jja,nobgp
$setglobal c32_bgp_ac  ac30
* options: ac0,ac10,ac20,ac30

scalars
	s32_max_aff_area 	Maximum global endogenous afforestation (mio. ha)    / Inf /
	s32_planing_horizon Afforestation planing horizon (years)            / 50 /
 	s32_aff_plantation switch for using natveg (0) or plantation (1) growth curves for afforestation / 0 /
;

parameter f32_aff_mask(j) Afforestation mask (1)
/
$ondelim
$Ifi "%c32_aff_mask%" == "unrestricted" $include "./modules/32_forestry/input/aff_unrestricted.cs2"
$Ifi "%c32_aff_mask%" == "noboreal" $include "./modules/32_forestry/input/aff_noboreal.cs2"
$Ifi "%c32_aff_mask%" == "onlytropical" $include "./modules/32_forestry/input/aff_onlytropical.cs2"
$offdelim
/;

table f32_fac_req_ha(i,fcosts32) Afforestation factor requirement costs per ha (USD04MER per ha)
$ondelim
$include "./modules/32_forestry/input/f32_fac_req_ha.csv"
$offdelim
;

table f32_aff_pol(t_all,j,pol32) Exogenous afforestation scenario (mio. ha)
$ondelim
$include "./modules/32_forestry/input/npi_ndc_aff_pol.cs3"
$offdelim
;

table f32_aff_bgp(j,bgp32) Biogeophysical temperature change of afforestation translated to tC for annual DJF JJA nobgp (tC per ha)
$ondelim
$include "./modules/32_forestry/input/refordefor_bgp_median.cs3"
$ondelim
;
