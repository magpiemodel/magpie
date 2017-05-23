$setglobal c32_aff_mask  noboreal
* options: unrestricted, noboreal, onlytropical

scalars
	s32_max_aff_area 	maximum total global afforestation in Mha    / Inf /
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

table f32_fac_req_ha(i,fcosts32) Afforestation factor requirement costs (US$ 2004 per ha)
$ondelim
$include "./modules/32_forestry/input/f32_fac_req_ha.csv"
$offdelim;
