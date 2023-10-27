*** |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

* Update of degraded peatland based on current managed land in the last time steps of fixed peatland area.
if (m_year(t) = s58_fix_peatland,
  p58_scaling_factor(j)$(sum(land, vm_land.l(j,land)) > 1e-20) = sum(land58, f58_peatland_area(j,land58)) / sum(land, vm_land.l(j,land));
  pc58_peatland(j,"crop") = min(f58_peatland_area(j,"crop"),vm_land.l(j,"crop") * p58_scaling_factor(j));
  pc58_peatland(j,"past") = min(f58_peatland_area(j,"past"), vm_land.l(j,"past") * p58_scaling_factor(j));
  pc58_peatland(j,"forestry") = min(f58_peatland_area(j,"forestry"), vm_land_forestry.l(j,"plant") * p58_scaling_factor(j));
  pc58_peatland(j,"unused") = sum(landDrainedUsed58, f58_peatland_area(j,landDrainedUsed58) - pc58_peatland(j,landDrainedUsed58));
else
  pc58_peatland(j,land58) = v58_peatland.l(j,land58);
);

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_peatland_cost(t,j,"marginal")                        = vm_peatland_cost.m(j);
 ov58_peatland_cost_annuity(t,j,"marginal")              = v58_peatland_cost_annuity.m(j);
 ov58_peatland_emis(t,j,land58,emis58,"marginal")        = v58_peatland_emis.m(j,land58,emis58);
 ov58_expansion(t,j,land58,"marginal")                   = v58_expansion.m(j,land58);
 ov58_reduction(t,j,land58,"marginal")                   = v58_reduction.m(j,land58);
 ov58_peatland(t,j,land58,"marginal")                    = v58_peatland.m(j,land58);
 oq58_peatland(t,j,"marginal")                           = q58_peatland.m(j);
 oq58_expansion(t,j,land58,"marginal")                   = q58_expansion.m(j,land58);
 oq58_reduction(t,j,land58,"marginal")                   = q58_reduction.m(j,land58);
 oq58_peatland_rewet(t,j,"marginal")                     = q58_peatland_rewet.m(j);
 oq58_peatland_crop(t,j,"marginal")                      = q58_peatland_crop.m(j);
 oq58_peatland_past(t,j,"marginal")                      = q58_peatland_past.m(j);
 oq58_peatland_forestry(t,j,"marginal")                  = q58_peatland_forestry.m(j);
 oq58_peatland_cost(t,j,"marginal")                      = q58_peatland_cost.m(j);
 oq58_peatland_cost_annuity(t,j,"marginal")              = q58_peatland_cost_annuity.m(j);
 oq58_peatland_emis_detail(t,j,land58,emis58,"marginal") = q58_peatland_emis_detail.m(j,land58,emis58);
 oq58_peatland_emis(t,i,poll58,"marginal")               = q58_peatland_emis.m(i,poll58);
 ov_peatland_cost(t,j,"level")                           = vm_peatland_cost.l(j);
 ov58_peatland_cost_annuity(t,j,"level")                 = v58_peatland_cost_annuity.l(j);
 ov58_peatland_emis(t,j,land58,emis58,"level")           = v58_peatland_emis.l(j,land58,emis58);
 ov58_expansion(t,j,land58,"level")                      = v58_expansion.l(j,land58);
 ov58_reduction(t,j,land58,"level")                      = v58_reduction.l(j,land58);
 ov58_peatland(t,j,land58,"level")                       = v58_peatland.l(j,land58);
 oq58_peatland(t,j,"level")                              = q58_peatland.l(j);
 oq58_expansion(t,j,land58,"level")                      = q58_expansion.l(j,land58);
 oq58_reduction(t,j,land58,"level")                      = q58_reduction.l(j,land58);
 oq58_peatland_rewet(t,j,"level")                        = q58_peatland_rewet.l(j);
 oq58_peatland_crop(t,j,"level")                         = q58_peatland_crop.l(j);
 oq58_peatland_past(t,j,"level")                         = q58_peatland_past.l(j);
 oq58_peatland_forestry(t,j,"level")                     = q58_peatland_forestry.l(j);
 oq58_peatland_cost(t,j,"level")                         = q58_peatland_cost.l(j);
 oq58_peatland_cost_annuity(t,j,"level")                 = q58_peatland_cost_annuity.l(j);
 oq58_peatland_emis_detail(t,j,land58,emis58,"level")    = q58_peatland_emis_detail.l(j,land58,emis58);
 oq58_peatland_emis(t,i,poll58,"level")                  = q58_peatland_emis.l(i,poll58);
 ov_peatland_cost(t,j,"upper")                           = vm_peatland_cost.up(j);
 ov58_peatland_cost_annuity(t,j,"upper")                 = v58_peatland_cost_annuity.up(j);
 ov58_peatland_emis(t,j,land58,emis58,"upper")           = v58_peatland_emis.up(j,land58,emis58);
 ov58_expansion(t,j,land58,"upper")                      = v58_expansion.up(j,land58);
 ov58_reduction(t,j,land58,"upper")                      = v58_reduction.up(j,land58);
 ov58_peatland(t,j,land58,"upper")                       = v58_peatland.up(j,land58);
 oq58_peatland(t,j,"upper")                              = q58_peatland.up(j);
 oq58_expansion(t,j,land58,"upper")                      = q58_expansion.up(j,land58);
 oq58_reduction(t,j,land58,"upper")                      = q58_reduction.up(j,land58);
 oq58_peatland_rewet(t,j,"upper")                        = q58_peatland_rewet.up(j);
 oq58_peatland_crop(t,j,"upper")                         = q58_peatland_crop.up(j);
 oq58_peatland_past(t,j,"upper")                         = q58_peatland_past.up(j);
 oq58_peatland_forestry(t,j,"upper")                     = q58_peatland_forestry.up(j);
 oq58_peatland_cost(t,j,"upper")                         = q58_peatland_cost.up(j);
 oq58_peatland_cost_annuity(t,j,"upper")                 = q58_peatland_cost_annuity.up(j);
 oq58_peatland_emis_detail(t,j,land58,emis58,"upper")    = q58_peatland_emis_detail.up(j,land58,emis58);
 oq58_peatland_emis(t,i,poll58,"upper")                  = q58_peatland_emis.up(i,poll58);
 ov_peatland_cost(t,j,"lower")                           = vm_peatland_cost.lo(j);
 ov58_peatland_cost_annuity(t,j,"lower")                 = v58_peatland_cost_annuity.lo(j);
 ov58_peatland_emis(t,j,land58,emis58,"lower")           = v58_peatland_emis.lo(j,land58,emis58);
 ov58_expansion(t,j,land58,"lower")                      = v58_expansion.lo(j,land58);
 ov58_reduction(t,j,land58,"lower")                      = v58_reduction.lo(j,land58);
 ov58_peatland(t,j,land58,"lower")                       = v58_peatland.lo(j,land58);
 oq58_peatland(t,j,"lower")                              = q58_peatland.lo(j);
 oq58_expansion(t,j,land58,"lower")                      = q58_expansion.lo(j,land58);
 oq58_reduction(t,j,land58,"lower")                      = q58_reduction.lo(j,land58);
 oq58_peatland_rewet(t,j,"lower")                        = q58_peatland_rewet.lo(j);
 oq58_peatland_crop(t,j,"lower")                         = q58_peatland_crop.lo(j);
 oq58_peatland_past(t,j,"lower")                         = q58_peatland_past.lo(j);
 oq58_peatland_forestry(t,j,"lower")                     = q58_peatland_forestry.lo(j);
 oq58_peatland_cost(t,j,"lower")                         = q58_peatland_cost.lo(j);
 oq58_peatland_cost_annuity(t,j,"lower")                 = q58_peatland_cost_annuity.lo(j);
 oq58_peatland_emis_detail(t,j,land58,emis58,"lower")    = q58_peatland_emis_detail.lo(j,land58,emis58);
 oq58_peatland_emis(t,i,poll58,"lower")                  = q58_peatland_emis.lo(i,poll58);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
