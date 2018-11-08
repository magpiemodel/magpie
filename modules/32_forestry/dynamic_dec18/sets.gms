sets
***FORESTRY COST TYPES***

   fcostsALL forestry factor cost types
           / recur,mon,harv /

   fcosts32(fcostsALL) forestry factor cost per annum
           / recur,mon /

   fcosts32H(fcostsALL) forestry harvest cost
           / harv /

  type32 plantation type
    / aff, indc, plant /

  pol32 afforestation policy type
    / none, npi, ndc/

   protect32(j,ac) mapping age class - land type

   harvest32(j,ac) mapping age class - land type

   rltype
   /rlFAO_min,rlGTM,rlFAO_max,init,hybrid/

   tstart32(t_all)
    / y1995, y2000, y2005, y2010 /

  gs_calib
  /p75,avg/

;

alias(ac_sub,ac_sub2);
alias(t,t_alias);
*** EOF sets.gms ***
