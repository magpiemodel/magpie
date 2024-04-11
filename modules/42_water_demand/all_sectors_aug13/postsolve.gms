*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_watdem(t,wat_dem,j,"marginal")         = vm_watdem.m(wat_dem,j);
 ov42_irrig_eff(t,j,"marginal")            = v42_irrig_eff.m(j);
 ov_water_cost(t,i,"marginal")             = vm_water_cost.m(i);
 oq42_water_demand(t,wat_dem,j,"marginal") = q42_water_demand.m(wat_dem,j);
 oq42_water_cost(t,i,"marginal")           = q42_water_cost.m(i);
 ov_watdem(t,wat_dem,j,"level")            = vm_watdem.l(wat_dem,j);
 ov42_irrig_eff(t,j,"level")               = v42_irrig_eff.l(j);
 ov_water_cost(t,i,"level")                = vm_water_cost.l(i);
 oq42_water_demand(t,wat_dem,j,"level")    = q42_water_demand.l(wat_dem,j);
 oq42_water_cost(t,i,"level")              = q42_water_cost.l(i);
 ov_watdem(t,wat_dem,j,"upper")            = vm_watdem.up(wat_dem,j);
 ov42_irrig_eff(t,j,"upper")               = v42_irrig_eff.up(j);
 ov_water_cost(t,i,"upper")                = vm_water_cost.up(i);
 oq42_water_demand(t,wat_dem,j,"upper")    = q42_water_demand.up(wat_dem,j);
 oq42_water_cost(t,i,"upper")              = q42_water_cost.up(i);
 ov_watdem(t,wat_dem,j,"lower")            = vm_watdem.lo(wat_dem,j);
 ov42_irrig_eff(t,j,"lower")               = v42_irrig_eff.lo(j);
 ov_water_cost(t,i,"lower")                = vm_water_cost.lo(i);
 oq42_water_demand(t,wat_dem,j,"lower")    = q42_water_demand.lo(wat_dem,j);
 oq42_water_cost(t,i,"lower")              = q42_water_cost.lo(i);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
