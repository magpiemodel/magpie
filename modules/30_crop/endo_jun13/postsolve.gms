*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*** Croparea Patterns are transferred to next timestep
pcm_area(j,kcr) = sum(w, vm_area.l(j,kcr,w));

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_area(t,j,kcr,w,"marginal")             = vm_area.m(j,kcr,w);
 oq30_cropland(t,j,"marginal")             = q30_cropland.m(j);
 oq30_suitability(t,j,"marginal")          = q30_suitability.m(j);
 oq30_rotation_max(t,j,crp30,w,"marginal") = q30_rotation_max.m(j,crp30,w);
 oq30_rotation_min(t,j,crp30,w,"marginal") = q30_rotation_min.m(j,crp30,w);
 oq30_prod(t,j,kcr,"marginal")             = q30_prod.m(j,kcr);
 oq30_carbon(t,j,c_pools,"marginal")       = q30_carbon.m(j,c_pools);
 ov_area(t,j,kcr,w,"level")                = vm_area.l(j,kcr,w);
 oq30_cropland(t,j,"level")                = q30_cropland.l(j);
 oq30_suitability(t,j,"level")             = q30_suitability.l(j);
 oq30_rotation_max(t,j,crp30,w,"level")    = q30_rotation_max.l(j,crp30,w);
 oq30_rotation_min(t,j,crp30,w,"level")    = q30_rotation_min.l(j,crp30,w);
 oq30_prod(t,j,kcr,"level")                = q30_prod.l(j,kcr);
 oq30_carbon(t,j,c_pools,"level")          = q30_carbon.l(j,c_pools);
 ov_area(t,j,kcr,w,"upper")                = vm_area.up(j,kcr,w);
 oq30_cropland(t,j,"upper")                = q30_cropland.up(j);
 oq30_suitability(t,j,"upper")             = q30_suitability.up(j);
 oq30_rotation_max(t,j,crp30,w,"upper")    = q30_rotation_max.up(j,crp30,w);
 oq30_rotation_min(t,j,crp30,w,"upper")    = q30_rotation_min.up(j,crp30,w);
 oq30_prod(t,j,kcr,"upper")                = q30_prod.up(j,kcr);
 oq30_carbon(t,j,c_pools,"upper")          = q30_carbon.up(j,c_pools);
 ov_area(t,j,kcr,w,"lower")                = vm_area.lo(j,kcr,w);
 oq30_cropland(t,j,"lower")                = q30_cropland.lo(j);
 oq30_suitability(t,j,"lower")             = q30_suitability.lo(j);
 oq30_rotation_max(t,j,crp30,w,"lower")    = q30_rotation_max.lo(j,crp30,w);
 oq30_rotation_min(t,j,crp30,w,"lower")    = q30_rotation_min.lo(j,crp30,w);
 oq30_prod(t,j,kcr,"lower")                = q30_prod.lo(j,kcr);
 oq30_carbon(t,j,c_pools,"lower")          = q30_carbon.lo(j,c_pools);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
