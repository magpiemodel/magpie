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

;

alias(ac,ac2);
alias(ac_sub,ac_sub2);
alias(t,t_alias);
*** EOF sets.gms ***
