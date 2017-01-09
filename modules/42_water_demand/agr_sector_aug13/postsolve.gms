*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_watdem(t,wat_dem,j,"marginal")         = vm_watdem.m(wat_dem,j);
 ov42_irrig_eff(t,j,"marginal")            = v42_irrig_eff.m(j);
 oq42_water_demand(t,wat_dem,j,"marginal") = q42_water_demand.m(wat_dem,j);
 ov_watdem(t,wat_dem,j,"level")            = vm_watdem.l(wat_dem,j);
 ov42_irrig_eff(t,j,"level")               = v42_irrig_eff.l(j);
 oq42_water_demand(t,wat_dem,j,"level")    = q42_water_demand.l(wat_dem,j);
 ov_watdem(t,wat_dem,j,"upper")            = vm_watdem.up(wat_dem,j);
 ov42_irrig_eff(t,j,"upper")               = v42_irrig_eff.up(j);
 oq42_water_demand(t,wat_dem,j,"upper")    = q42_water_demand.up(wat_dem,j);
 ov_watdem(t,wat_dem,j,"lower")            = vm_watdem.lo(wat_dem,j);
 ov42_irrig_eff(t,j,"lower")               = v42_irrig_eff.lo(j);
 oq42_water_demand(t,wat_dem,j,"lower")    = q42_water_demand.lo(wat_dem,j);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
