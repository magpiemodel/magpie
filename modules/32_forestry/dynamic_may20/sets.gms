sets
***FORESTRY COST TYPES***

 fcostsALL forestry factor cost types
 /
 recur,mon,harv
 /

 fcosts32(fcostsALL) forestry factor cost per annum
 /
 recur,mon
 /

 type32 plantation type
 /
 aff, ndc, plant
 /

 pol32 afforestation policy type
 /
 none, npi, ndc
 /

 ini32(j,ac)

 mgmt_type Type of forestry management
 /normal,high/

 rotation_type Rotation type
 / min, low, def, high, bio /

 bgp32 biogeophysical effect (tCeq per ha) of afforestation on local climate
/ nobgp, ann, djf, jja /

aff_effect biochemical and local biophysical effect of afforestation on climate
/ bgc,bph /

;

*** EOF sets.gms ***
