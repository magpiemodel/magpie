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

 protect32(t,j,ac) Age classes which need to be protected during rotation

 harvest32(t,j,ac) Age classes which are available for harvest after rotation

 rltype Rotation length sets
 /rlFAO_min,rlGTM,rlFAO_max/

 mgmt_type Type of forestry management
 /normal,high/

 ac_additional(ac) Subset of ac to account for longer than five year time steps

 rotation_type Rotation type
 / min, low, def, high, bio /

 bgp32 biogeophysical effect (tCeq per ha) of afforestation on local climate
/ nobgp, ann, djf, jja /

aff_effect biochemical and local biophysical effect of afforestation on climate
/ bgc,bph /

;

alias(ac,ac2);
alias(ac_sub,ac_sub2);
alias(t,t_alias);
alias(t_all,t_all_alias);
alias(j,j_alias);
*** EOF sets.gms ***
