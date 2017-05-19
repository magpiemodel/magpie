*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de



*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_cost_bioen(t,i,"marginal")      = vm_cost_bioen.m(i);
 ov_dem_bioen(t,i,kall,"marginal")  = vm_dem_bioen.m(i,kall);
 oq60_bioenergy_glo(t,"marginal")   = q60_bioenergy_glo.m;
 oq60_bioenergy_reg(t,i,"marginal") = q60_bioenergy_reg.m(i);
 ov_cost_bioen(t,i,"level")         = vm_cost_bioen.l(i);
 ov_dem_bioen(t,i,kall,"level")     = vm_dem_bioen.l(i,kall);
 oq60_bioenergy_glo(t,"level")      = q60_bioenergy_glo.l;
 oq60_bioenergy_reg(t,i,"level")    = q60_bioenergy_reg.l(i);
 ov_cost_bioen(t,i,"upper")         = vm_cost_bioen.up(i);
 ov_dem_bioen(t,i,kall,"upper")     = vm_dem_bioen.up(i,kall);
 oq60_bioenergy_glo(t,"upper")      = q60_bioenergy_glo.up;
 oq60_bioenergy_reg(t,i,"upper")    = q60_bioenergy_reg.up(i);
 ov_cost_bioen(t,i,"lower")         = vm_cost_bioen.lo(i);
 ov_dem_bioen(t,i,kall,"lower")     = vm_dem_bioen.lo(i,kall);
 oq60_bioenergy_glo(t,"lower")      = q60_bioenergy_glo.lo;
 oq60_bioenergy_reg(t,i,"lower")    = q60_bioenergy_reg.lo(i);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################

