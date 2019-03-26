*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*** Land Patterns are transferred to next timestep
pcm_land(j,land) = vm_land.l(j,land);

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_landdiff(t,"marginal")               = vm_landdiff.m;
 ov_land(t,j,land,"marginal")            = vm_land.m(j,land);
 ov_landexpansion(t,j,land,"marginal")   = vm_landexpansion.m(j,land);
 ov10_landreduction(t,j,land,"marginal") = v10_landreduction.m(j,land);
 ov_cost_land_transition(t,j,"marginal") = vm_cost_land_transition.m(j);
 oq10_land(t,j,"marginal")               = q10_land.m(j);
 oq10_landexpansion(t,j,land,"marginal") = q10_landexpansion.m(j,land);
 oq10_landreduction(t,j,land,"marginal") = q10_landreduction.m(j,land);
 oq10_landdiff(t,"marginal")             = q10_landdiff.m;
 ov_landdiff(t,"level")                  = vm_landdiff.l;
 ov_land(t,j,land,"level")               = vm_land.l(j,land);
 ov_landexpansion(t,j,land,"level")      = vm_landexpansion.l(j,land);
 ov10_landreduction(t,j,land,"level")    = v10_landreduction.l(j,land);
 ov_cost_land_transition(t,j,"level")    = vm_cost_land_transition.l(j);
 oq10_land(t,j,"level")                  = q10_land.l(j);
 oq10_landexpansion(t,j,land,"level")    = q10_landexpansion.l(j,land);
 oq10_landreduction(t,j,land,"level")    = q10_landreduction.l(j,land);
 oq10_landdiff(t,"level")                = q10_landdiff.l;
 ov_landdiff(t,"upper")                  = vm_landdiff.up;
 ov_land(t,j,land,"upper")               = vm_land.up(j,land);
 ov_landexpansion(t,j,land,"upper")      = vm_landexpansion.up(j,land);
 ov10_landreduction(t,j,land,"upper")    = v10_landreduction.up(j,land);
 ov_cost_land_transition(t,j,"upper")    = vm_cost_land_transition.up(j);
 oq10_land(t,j,"upper")                  = q10_land.up(j);
 oq10_landexpansion(t,j,land,"upper")    = q10_landexpansion.up(j,land);
 oq10_landreduction(t,j,land,"upper")    = q10_landreduction.up(j,land);
 oq10_landdiff(t,"upper")                = q10_landdiff.up;
 ov_landdiff(t,"lower")                  = vm_landdiff.lo;
 ov_land(t,j,land,"lower")               = vm_land.lo(j,land);
 ov_landexpansion(t,j,land,"lower")      = vm_landexpansion.lo(j,land);
 ov10_landreduction(t,j,land,"lower")    = v10_landreduction.lo(j,land);
 ov_cost_land_transition(t,j,"lower")    = vm_cost_land_transition.lo(j);
 oq10_land(t,j,"lower")                  = q10_land.lo(j);
 oq10_landexpansion(t,j,land,"lower")    = q10_landexpansion.lo(j,land);
 oq10_landreduction(t,j,land,"lower")    = q10_landreduction.lo(j,land);
 oq10_landdiff(t,"lower")                = q10_landdiff.lo;
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
