*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de



*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_dem_bioen(t,i,kall,"marginal")  = vm_dem_bioen.m(i,kall);
 oq60_bioenergy_glo(t,"marginal")   = q60_bioenergy_glo.m;
 oq60_bioenergy_reg(t,i,"marginal") = q60_bioenergy_reg.m(i);
 oq60_res_2ndgenBE(t,i,"marginal")  = q60_res_2ndgenBE.m(i);
 ov_dem_bioen(t,i,kall,"level")     = vm_dem_bioen.l(i,kall);
 oq60_bioenergy_glo(t,"level")      = q60_bioenergy_glo.l;
 oq60_bioenergy_reg(t,i,"level")    = q60_bioenergy_reg.l(i);
 oq60_res_2ndgenBE(t,i,"level")     = q60_res_2ndgenBE.l(i);
 ov_dem_bioen(t,i,kall,"upper")     = vm_dem_bioen.up(i,kall);
 oq60_bioenergy_glo(t,"upper")      = q60_bioenergy_glo.up;
 oq60_bioenergy_reg(t,i,"upper")    = q60_bioenergy_reg.up(i);
 oq60_res_2ndgenBE(t,i,"upper")     = q60_res_2ndgenBE.up(i);
 ov_dem_bioen(t,i,kall,"lower")     = vm_dem_bioen.lo(i,kall);
 oq60_bioenergy_glo(t,"lower")      = q60_bioenergy_glo.lo;
 oq60_bioenergy_reg(t,i,"lower")    = q60_bioenergy_reg.lo(i);
 oq60_res_2ndgenBE(t,i,"lower")     = q60_res_2ndgenBE.lo(i);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################

