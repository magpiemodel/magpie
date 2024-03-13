*** |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

* Growth of trees on cropland is modelled by shifting age-classes according to time step length.
s61_shift = m_timestep_length_forestry/5;
* example: ac10 in t = ac5 (ac10-1) in t-1 for a 5 yr time step (s61_shift = 1)
    p61_treecover(t,j,ac)$(ord(ac) > s61_shift) = pc61_treecover(j,ac-s61_shift);
* account for cases at the end of the age class set (s61_shift > 1) which are not shifted by the above calculation
    p61_treecover(t,j,"acx") = p61_treecover(t,j,"acx")
                  + sum(ac$(ord(ac) > card(ac)-s61_shift), pc61_treecover(j,ac));

pc61_treecover(j,ac) = p61_treecover(t,j,ac);
v61_treecover.l(j,ac) = p61_treecover(t,j,ac);

if(m_year(t) <= s61_treecover_scenario_start,
 v61_treecover.fx(j,ac) = pc61_treecover(j,ac);
else
 v61_treecover.lo(j,ac_est) = 0;
 v61_treecover.up(j,ac_est) = Inf;
 if(s61_treecover_decrease = 1,
  v61_treecover.lo(j,ac_sub) = 0;
  v61_treecover.up(j,ac_sub) = pc61_treecover(j,ac_sub);
 else
  v61_treecover.fx(j,ac_sub) = pc61_treecover(j,ac_sub);  
 );
);

p61_treecover_min_shr(t,j) = 
 ((1-p61_treecover_scenario_fader(t)) * pm_treecover_shr(j)) +
 (p61_treecover_scenario_fader(t) * s61_treecover_min_shr);

p61_betr_min_shr(t,j) = p61_betr_scenario_fader(t) * s61_betr_min_shr;
