*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de
*' @code
*' The parameters `p62_dem_material_lh` and `p62_dem_food_lh` are overwritten
*' based on each time step optimization, in order to be used in next step.
*' This is only carried out when the model is still running in the time period
*' before (and including) y2010 with this model version.

if (sum(sameas(t_past,t),1) = 1,
 p62_dem_material_lh(i,kall) = f62_dem_material(t,i,kall);
 p62_dem_food_lh(i)=  sum(kfo, vm_dem_food.l(i,kfo));
);
p62_dem_food(i) = sum(kfo, vm_dem_food.l(i,kfo));

*' @stop

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_dem_material(t,i,kall,"marginal")   = vm_dem_material.m(i,kall);
 oq62_dem_material(t,i,kall,"marginal") = q62_dem_material.m(i,kall);
 ov_dem_material(t,i,kall,"level")      = vm_dem_material.l(i,kall);
 oq62_dem_material(t,i,kall,"level")    = q62_dem_material.l(i,kall);
 ov_dem_material(t,i,kall,"upper")      = vm_dem_material.up(i,kall);
 oq62_dem_material(t,i,kall,"upper")    = q62_dem_material.up(i,kall);
 ov_dem_material(t,i,kall,"lower")      = vm_dem_material.lo(i,kall);
 oq62_dem_material(t,i,kall,"lower")    = q62_dem_material.lo(i,kall);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
