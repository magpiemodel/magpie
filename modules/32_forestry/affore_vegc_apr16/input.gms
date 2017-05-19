*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

$setglobal c32_aff_mask  noboreal
* options: unrestricted, noboreal, onlytropical
 
scalars
	s32_afforest_policy Switch for afforestation policy based on historic afforestation rates    / 0 /
	s32_max_aff_area 	maximum total global afforestation in Mha    / 0 /
;

parameters
f32_aff_mask(j) afforestation mask (binary)
/
$ondelim
$Ifi "%c32_aff_mask%" == "unrestricted" $include "./modules/32_forestry/input/aff_unrestricted.cs2"
$Ifi "%c32_aff_mask%" == "noboreal" $include "./modules/32_forestry/input/aff_noboreal.cs2"
$Ifi "%c32_aff_mask%" == "onlytropical" $include "./modules/32_forestry/input/aff_onlytropical.cs2"
$offdelim
/

f32_afforest_policy(t_all) relative increase in annual afforestation rate [baseyear = 2010]
/
$ondelim
$include "./modules/32_forestry/affore_vegc_apr16/input/f32_afforest_policy.csv"
$offdelim
/


f32_max_aff(t_all) maximum annual afforestation rate (Mha per yr)
/
$ondelim
$include "./modules/32_forestry/affore_vegc_apr16/input/f32_max_aff.csv"
$offdelim
/
;

table f32_fac_req_ha(i,fcosts32) Afforestation factor requirement costs (US$ 2004 per ha)
$ondelim
$include "./modules/32_forestry/input/f32_fac_req_ha.csv"
$offdelim;
