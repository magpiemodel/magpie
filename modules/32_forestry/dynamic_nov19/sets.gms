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
 aff, indc, plant
 /

 pol32 afforestation policy type
 /
 none, npi, ndc
 /

 protect32(t,j,ac) mapping age class - land type

 harvest32(t,j,ac) mapping age class - land type

 rltype Rotation length sets
 /rlFAO_min,rlGTM,rlFAO_max/

 mgmt_type Type of forestry management
 /normal,high/

 ac_additional(ac) Subset of ac to account for longer than five year time steps

 forest_type forest type
 /plantations, natveg/

 rotation_type Rotation type
 / min, low, def, high, bio /

 int_to_rl(rotation_type,scen12) mapping between ac and ac_poulter
 /
 min   .  (15pc)
 low   .  (high)
 def   .  (medium)
 high  .  (low)
 bio   .  (1pc)
 /

 area_prod_forests Area and production indicators from FAO
 / forestry_prod, forestry_area, natveg_prod, natveg_area /

;

alias(ac,ac2);
alias(ac_sub,ac_sub2);
alias(t,t_alias);
*** EOF sets.gms ***
