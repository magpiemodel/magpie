*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de
$setglobal c32_aff_mask  noboreal
* options: unrestricted, noboreal, onlytropical
$setglobal c32_aff_policy  none

scalars
	s32_max_aff_area 	maximum total global afforestation in Mha    / Inf /
;

parameter f32_aff_mask(j) afforestation mask (binary)
/
$ondelim
$Ifi "%c32_aff_mask%" == "unrestricted" $include "./modules/32_forestry/input/aff_unrestricted.cs2"
$Ifi "%c32_aff_mask%" == "noboreal" $include "./modules/32_forestry/input/aff_noboreal.cs2"
$Ifi "%c32_aff_mask%" == "onlytropical" $include "./modules/32_forestry/input/aff_onlytropical.cs2"
$offdelim
/;

table f32_fac_req_ha(i,fcosts32) Afforestation factor requirement costs (US Dollar 2004 per ha)
$ondelim
$include "./modules/32_forestry/input/f32_fac_req_ha.csv"
$offdelim
;

table f32_aff_pol(t_all,j,pol32) npi+indc afforestation policy (Mha new forest wrt to 2010)
$ondelim
$include "./modules/32_forestry/input/indc_aff_pol.cs3"
$offdelim
;
