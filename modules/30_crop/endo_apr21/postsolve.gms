*** |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_fallow(t,j,"marginal")                      = vm_fallow.m(j);
 ov_area(t,j,kcr,w,"marginal")                  = vm_area.m(j,kcr,w);
 ov_rotation_penalty(t,i,"marginal")            = vm_rotation_penalty.m(i);
 oq30_cropland(t,j,"marginal")                  = q30_cropland.m(j);
 oq30_avl_cropland(t,j,"marginal")              = q30_avl_cropland.m(j);
 oq30_rotation_max(t,j,crp30,w,"marginal")      = q30_rotation_max.m(j,crp30,w);
 oq30_rotation_min(t,j,crp30,w,"marginal")      = q30_rotation_min.m(j,crp30,w);
 oq30_prod(t,j,kcr,"marginal")                  = q30_prod.m(j,kcr);
 oq30_carbon(t,j,ag_pools,stockType,"marginal") = q30_carbon.m(j,ag_pools,stockType);
 oq30_bv_ann(t,j,potnatveg,"marginal")          = q30_bv_ann.m(j,potnatveg);
 oq30_bv_per(t,j,potnatveg,"marginal")          = q30_bv_per.m(j,potnatveg);
 oq30_land_snv(t,j,"marginal")                  = q30_land_snv.m(j);
 ov_fallow(t,j,"level")                         = vm_fallow.l(j);
 ov_area(t,j,kcr,w,"level")                     = vm_area.l(j,kcr,w);
 ov_rotation_penalty(t,i,"level")               = vm_rotation_penalty.l(i);
 oq30_cropland(t,j,"level")                     = q30_cropland.l(j);
 oq30_avl_cropland(t,j,"level")                 = q30_avl_cropland.l(j);
 oq30_rotation_max(t,j,crp30,w,"level")         = q30_rotation_max.l(j,crp30,w);
 oq30_rotation_min(t,j,crp30,w,"level")         = q30_rotation_min.l(j,crp30,w);
 oq30_prod(t,j,kcr,"level")                     = q30_prod.l(j,kcr);
 oq30_carbon(t,j,ag_pools,stockType,"level")    = q30_carbon.l(j,ag_pools,stockType);
 oq30_bv_ann(t,j,potnatveg,"level")             = q30_bv_ann.l(j,potnatveg);
 oq30_bv_per(t,j,potnatveg,"level")             = q30_bv_per.l(j,potnatveg);
 oq30_land_snv(t,j,"level")                     = q30_land_snv.l(j);
 ov_fallow(t,j,"upper")                         = vm_fallow.up(j);
 ov_area(t,j,kcr,w,"upper")                     = vm_area.up(j,kcr,w);
 ov_rotation_penalty(t,i,"upper")               = vm_rotation_penalty.up(i);
 oq30_cropland(t,j,"upper")                     = q30_cropland.up(j);
 oq30_avl_cropland(t,j,"upper")                 = q30_avl_cropland.up(j);
 oq30_rotation_max(t,j,crp30,w,"upper")         = q30_rotation_max.up(j,crp30,w);
 oq30_rotation_min(t,j,crp30,w,"upper")         = q30_rotation_min.up(j,crp30,w);
 oq30_prod(t,j,kcr,"upper")                     = q30_prod.up(j,kcr);
 oq30_carbon(t,j,ag_pools,stockType,"upper")    = q30_carbon.up(j,ag_pools,stockType);
 oq30_bv_ann(t,j,potnatveg,"upper")             = q30_bv_ann.up(j,potnatveg);
 oq30_bv_per(t,j,potnatveg,"upper")             = q30_bv_per.up(j,potnatveg);
 oq30_land_snv(t,j,"upper")                     = q30_land_snv.up(j);
 ov_fallow(t,j,"lower")                         = vm_fallow.lo(j);
 ov_area(t,j,kcr,w,"lower")                     = vm_area.lo(j,kcr,w);
 ov_rotation_penalty(t,i,"lower")               = vm_rotation_penalty.lo(i);
 oq30_cropland(t,j,"lower")                     = q30_cropland.lo(j);
 oq30_avl_cropland(t,j,"lower")                 = q30_avl_cropland.lo(j);
 oq30_rotation_max(t,j,crp30,w,"lower")         = q30_rotation_max.lo(j,crp30,w);
 oq30_rotation_min(t,j,crp30,w,"lower")         = q30_rotation_min.lo(j,crp30,w);
 oq30_prod(t,j,kcr,"lower")                     = q30_prod.lo(j,kcr);
 oq30_carbon(t,j,ag_pools,stockType,"lower")    = q30_carbon.lo(j,ag_pools,stockType);
 oq30_bv_ann(t,j,potnatveg,"lower")             = q30_bv_ann.lo(j,potnatveg);
 oq30_bv_per(t,j,potnatveg,"lower")             = q30_bv_per.lo(j,potnatveg);
 oq30_land_snv(t,j,"lower")                     = q30_land_snv.lo(j);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
