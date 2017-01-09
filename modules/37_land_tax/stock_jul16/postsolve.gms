*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de


*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_cost_landtax(t,j,land_ag,"marginal")   = vm_cost_landtax.m(j,land_ag);
 oq37_cost_landtax(t,j,land_ag,"marginal") = q37_cost_landtax.m(j,land_ag);
 ov_cost_landtax(t,j,land_ag,"level")      = vm_cost_landtax.l(j,land_ag);
 oq37_cost_landtax(t,j,land_ag,"level")    = q37_cost_landtax.l(j,land_ag);
 ov_cost_landtax(t,j,land_ag,"upper")      = vm_cost_landtax.up(j,land_ag);
 oq37_cost_landtax(t,j,land_ag,"upper")    = q37_cost_landtax.up(j,land_ag);
 ov_cost_landtax(t,j,land_ag,"lower")      = vm_cost_landtax.lo(j,land_ag);
 oq37_cost_landtax(t,j,land_ag,"lower")    = q37_cost_landtax.lo(j,land_ag);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################

