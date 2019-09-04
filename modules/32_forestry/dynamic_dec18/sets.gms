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

 ac_additional(ac)
 /ac0,ac5,ac10,ac15,ac20,ac25,ac30,ac35,ac40/

 ac_add_timestep(t,ac_additional) timestep length and additional acs to be planted

 rltype Rotation length sets
 /rlFAO_min,rlGTM,rlFAO_max/

 mgmt_type Type of forestry management
 /normal,high/

;

alias(ac,ac2);
alias(ac_sub,ac_sub2);
alias(t,t_alias);
*** EOF sets.gms ***
