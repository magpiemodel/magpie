sets
***FORESTRY COST TYPES***

 fcostsALL forestry factor cost types
 / recur, mon, harv /

 fcosts32(fcostsALL) forestry factor cost per annum
 / recur, mon /

 type32 plantation type
 / aff, ndc, plant /

 pol32 afforestation policy type
 / none, npi, ndc /

 ini32(j,ac) subset for initialization of timber plantations 

 rotation_type Rotation type
 / min, low, def, high, bio /

 bgp32 biogeophysical effect (degree C) of afforestation on local surface temperature
/ nobgp, ann_bph /

tcre32 transient surface temperature response to CO2 emission (degree C per tC)
/ ann_TCREmean, ann_TCREhigh, ann_TCRElow /

aff_effect biochemical and local biophysical effect of afforestation on climate
/ bgc, bph /

ac_bph(ac) fade-in of bph effect over age-classes

;

*** EOF sets.gms ***
