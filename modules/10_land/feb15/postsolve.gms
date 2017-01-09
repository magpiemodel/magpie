*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

*** Land Patterns are transferred to next timestep
pcm_land(j,land,si) = vm_land.l(j,land,si);

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_landdiff(t,"marginal")                  = vm_landdiff.m;
 ov_land(t,j,land,si,"marginal")            = vm_land.m(j,land,si);
 ov_landexpansion(t,j,land,si,"marginal")   = vm_landexpansion.m(j,land,si);
 ov_landreduction(t,j,land,si,"marginal")   = vm_landreduction.m(j,land,si);
 oq10_land(t,j,si,"marginal")               = q10_land.m(j,si);
 oq10_lu_miti(t,j,"marginal")               = q10_lu_miti.m(j);
 oq10_landexpansion(t,j,land,si,"marginal") = q10_landexpansion.m(j,land,si);
 oq10_landreduction(t,j,land,si,"marginal") = q10_landreduction.m(j,land,si);
 oq10_landdiff(t,"marginal")                = q10_landdiff.m;
 ov_landdiff(t,"level")                     = vm_landdiff.l;
 ov_land(t,j,land,si,"level")               = vm_land.l(j,land,si);
 ov_landexpansion(t,j,land,si,"level")      = vm_landexpansion.l(j,land,si);
 ov_landreduction(t,j,land,si,"level")      = vm_landreduction.l(j,land,si);
 oq10_land(t,j,si,"level")                  = q10_land.l(j,si);
 oq10_lu_miti(t,j,"level")                  = q10_lu_miti.l(j);
 oq10_landexpansion(t,j,land,si,"level")    = q10_landexpansion.l(j,land,si);
 oq10_landreduction(t,j,land,si,"level")    = q10_landreduction.l(j,land,si);
 oq10_landdiff(t,"level")                   = q10_landdiff.l;
 ov_landdiff(t,"upper")                     = vm_landdiff.up;
 ov_land(t,j,land,si,"upper")               = vm_land.up(j,land,si);
 ov_landexpansion(t,j,land,si,"upper")      = vm_landexpansion.up(j,land,si);
 ov_landreduction(t,j,land,si,"upper")      = vm_landreduction.up(j,land,si);
 oq10_land(t,j,si,"upper")                  = q10_land.up(j,si);
 oq10_lu_miti(t,j,"upper")                  = q10_lu_miti.up(j);
 oq10_landexpansion(t,j,land,si,"upper")    = q10_landexpansion.up(j,land,si);
 oq10_landreduction(t,j,land,si,"upper")    = q10_landreduction.up(j,land,si);
 oq10_landdiff(t,"upper")                   = q10_landdiff.up;
 ov_landdiff(t,"lower")                     = vm_landdiff.lo;
 ov_land(t,j,land,si,"lower")               = vm_land.lo(j,land,si);
 ov_landexpansion(t,j,land,si,"lower")      = vm_landexpansion.lo(j,land,si);
 ov_landreduction(t,j,land,si,"lower")      = vm_landreduction.lo(j,land,si);
 oq10_land(t,j,si,"lower")                  = q10_land.lo(j,si);
 oq10_lu_miti(t,j,"lower")                  = q10_lu_miti.lo(j);
 oq10_landexpansion(t,j,land,si,"lower")    = q10_landexpansion.lo(j,land,si);
 oq10_landreduction(t,j,land,si,"lower")    = q10_landreduction.lo(j,land,si);
 oq10_landdiff(t,"lower")                   = q10_landdiff.lo;
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
