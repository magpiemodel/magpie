*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

p33_land(t,j,ac,"after")$(pcm_land(j,"secdforest") > 0) = (vm_land.l(j,"secdforest")/pcm_land(j,"secdforest"))*p33_land(t,j,ac,"before");

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_landdiff_forest(t,"marginal")               = vm_landdiff_forest.m;
 oq33_carbon_primforest(t,j,c_pools,"marginal") = q33_carbon_primforest.m(j,c_pools);
 oq33_carbon_secdforest(t,j,c_pools,"marginal") = q33_carbon_secdforest.m(j,c_pools);
 oq33_diff(t,"marginal")                        = q33_diff.m;
 ov_landdiff_forest(t,"level")                  = vm_landdiff_forest.l;
 oq33_carbon_primforest(t,j,c_pools,"level")    = q33_carbon_primforest.l(j,c_pools);
 oq33_carbon_secdforest(t,j,c_pools,"level")    = q33_carbon_secdforest.l(j,c_pools);
 oq33_diff(t,"level")                           = q33_diff.l;
 ov_landdiff_forest(t,"upper")                  = vm_landdiff_forest.up;
 oq33_carbon_primforest(t,j,c_pools,"upper")    = q33_carbon_primforest.up(j,c_pools);
 oq33_carbon_secdforest(t,j,c_pools,"upper")    = q33_carbon_secdforest.up(j,c_pools);
 oq33_diff(t,"upper")                           = q33_diff.up;
 ov_landdiff_forest(t,"lower")                  = vm_landdiff_forest.lo;
 oq33_carbon_primforest(t,j,c_pools,"lower")    = q33_carbon_primforest.lo(j,c_pools);
 oq33_carbon_secdforest(t,j,c_pools,"lower")    = q33_carbon_secdforest.lo(j,c_pools);
 oq33_diff(t,"lower")                           = q33_diff.lo;
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
