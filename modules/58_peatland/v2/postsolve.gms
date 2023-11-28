*** |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

pc58_peatland(j,land58) = v58_peatland.l(j,land58);

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_peatland_cost(t,j,"marginal")                        = vm_peatland_cost.m(j);
 ov58_peatland_cost(t,j,"marginal")                      = v58_peatland_cost.m(j);
 ov58_peatland_emis(t,j,land58,emis58,"marginal")        = v58_peatland_emis.m(j,land58,emis58);
 ov58_peatlandChange(t,j,land58,"marginal")              = v58_peatlandChange.m(j,land58);
 ov58_peatland_cost_annuity_intact(t,j,"marginal")       = v58_peatland_cost_annuity_intact.m(j);
 ov58_peatland_cost_annuity_rewet(t,j,"marginal")        = v58_peatland_cost_annuity_rewet.m(j);
 ov58_peatland(t,j,land58,"marginal")                    = v58_peatland.m(j,land58);
 ov58_manLandExp(t,j,manLand58,"marginal")               = v58_manLandExp.m(j,manLand58);
 ov58_manLandRed(t,j,manLand58,"marginal")               = v58_manLandRed.m(j,manLand58);
 oq58_peatland(t,j,"marginal")                           = q58_peatland.m(j);
 oq58_peatlandChange(t,j,land58,"marginal")              = q58_peatlandChange.m(j,land58);
 oq58_peatlandMan(t,j,manPeat58,"marginal")              = q58_peatlandMan.m(j,manPeat58);
 oq58_peatlandRewet(t,j,"marginal")                      = q58_peatlandRewet.m(j);
 oq58_peatland_cost_full(t,j,"marginal")                 = q58_peatland_cost_full.m(j);
 oq58_peatland_cost(t,j,"marginal")                      = q58_peatland_cost.m(j);
 oq58_peatland_cost_annuity_intact(t,j,"marginal")       = q58_peatland_cost_annuity_intact.m(j);
 oq58_peatland_cost_annuity_rewet(t,j,"marginal")        = q58_peatland_cost_annuity_rewet.m(j);
 oq58_peatland_emis_detail(t,j,land58,emis58,"marginal") = q58_peatland_emis_detail.m(j,land58,emis58);
 oq58_peatland_emis(t,i,poll58,"marginal")               = q58_peatland_emis.m(i,poll58);
 oq58_manLandExp(t,j,manLand58,"marginal")               = q58_manLandExp.m(j,manLand58);
 oq58_manLandRed(t,j,manLand58,"marginal")               = q58_manLandRed.m(j,manLand58);
 ov_peatland_cost(t,j,"level")                           = vm_peatland_cost.l(j);
 ov58_peatland_cost(t,j,"level")                         = v58_peatland_cost.l(j);
 ov58_peatland_emis(t,j,land58,emis58,"level")           = v58_peatland_emis.l(j,land58,emis58);
 ov58_peatlandChange(t,j,land58,"level")                 = v58_peatlandChange.l(j,land58);
 ov58_peatland_cost_annuity_intact(t,j,"level")          = v58_peatland_cost_annuity_intact.l(j);
 ov58_peatland_cost_annuity_rewet(t,j,"level")           = v58_peatland_cost_annuity_rewet.l(j);
 ov58_peatland(t,j,land58,"level")                       = v58_peatland.l(j,land58);
 ov58_manLandExp(t,j,manLand58,"level")                  = v58_manLandExp.l(j,manLand58);
 ov58_manLandRed(t,j,manLand58,"level")                  = v58_manLandRed.l(j,manLand58);
 oq58_peatland(t,j,"level")                              = q58_peatland.l(j);
 oq58_peatlandChange(t,j,land58,"level")                 = q58_peatlandChange.l(j,land58);
 oq58_peatlandMan(t,j,manPeat58,"level")                 = q58_peatlandMan.l(j,manPeat58);
 oq58_peatlandRewet(t,j,"level")                         = q58_peatlandRewet.l(j);
 oq58_peatland_cost_full(t,j,"level")                    = q58_peatland_cost_full.l(j);
 oq58_peatland_cost(t,j,"level")                         = q58_peatland_cost.l(j);
 oq58_peatland_cost_annuity_intact(t,j,"level")          = q58_peatland_cost_annuity_intact.l(j);
 oq58_peatland_cost_annuity_rewet(t,j,"level")           = q58_peatland_cost_annuity_rewet.l(j);
 oq58_peatland_emis_detail(t,j,land58,emis58,"level")    = q58_peatland_emis_detail.l(j,land58,emis58);
 oq58_peatland_emis(t,i,poll58,"level")                  = q58_peatland_emis.l(i,poll58);
 oq58_manLandExp(t,j,manLand58,"level")                  = q58_manLandExp.l(j,manLand58);
 oq58_manLandRed(t,j,manLand58,"level")                  = q58_manLandRed.l(j,manLand58);
 ov_peatland_cost(t,j,"upper")                           = vm_peatland_cost.up(j);
 ov58_peatland_cost(t,j,"upper")                         = v58_peatland_cost.up(j);
 ov58_peatland_emis(t,j,land58,emis58,"upper")           = v58_peatland_emis.up(j,land58,emis58);
 ov58_peatlandChange(t,j,land58,"upper")                 = v58_peatlandChange.up(j,land58);
 ov58_peatland_cost_annuity_intact(t,j,"upper")          = v58_peatland_cost_annuity_intact.up(j);
 ov58_peatland_cost_annuity_rewet(t,j,"upper")           = v58_peatland_cost_annuity_rewet.up(j);
 ov58_peatland(t,j,land58,"upper")                       = v58_peatland.up(j,land58);
 ov58_manLandExp(t,j,manLand58,"upper")                  = v58_manLandExp.up(j,manLand58);
 ov58_manLandRed(t,j,manLand58,"upper")                  = v58_manLandRed.up(j,manLand58);
 oq58_peatland(t,j,"upper")                              = q58_peatland.up(j);
 oq58_peatlandChange(t,j,land58,"upper")                 = q58_peatlandChange.up(j,land58);
 oq58_peatlandMan(t,j,manPeat58,"upper")                 = q58_peatlandMan.up(j,manPeat58);
 oq58_peatlandRewet(t,j,"upper")                         = q58_peatlandRewet.up(j);
 oq58_peatland_cost_full(t,j,"upper")                    = q58_peatland_cost_full.up(j);
 oq58_peatland_cost(t,j,"upper")                         = q58_peatland_cost.up(j);
 oq58_peatland_cost_annuity_intact(t,j,"upper")          = q58_peatland_cost_annuity_intact.up(j);
 oq58_peatland_cost_annuity_rewet(t,j,"upper")           = q58_peatland_cost_annuity_rewet.up(j);
 oq58_peatland_emis_detail(t,j,land58,emis58,"upper")    = q58_peatland_emis_detail.up(j,land58,emis58);
 oq58_peatland_emis(t,i,poll58,"upper")                  = q58_peatland_emis.up(i,poll58);
 oq58_manLandExp(t,j,manLand58,"upper")                  = q58_manLandExp.up(j,manLand58);
 oq58_manLandRed(t,j,manLand58,"upper")                  = q58_manLandRed.up(j,manLand58);
 ov_peatland_cost(t,j,"lower")                           = vm_peatland_cost.lo(j);
 ov58_peatland_cost(t,j,"lower")                         = v58_peatland_cost.lo(j);
 ov58_peatland_emis(t,j,land58,emis58,"lower")           = v58_peatland_emis.lo(j,land58,emis58);
 ov58_peatlandChange(t,j,land58,"lower")                 = v58_peatlandChange.lo(j,land58);
 ov58_peatland_cost_annuity_intact(t,j,"lower")          = v58_peatland_cost_annuity_intact.lo(j);
 ov58_peatland_cost_annuity_rewet(t,j,"lower")           = v58_peatland_cost_annuity_rewet.lo(j);
 ov58_peatland(t,j,land58,"lower")                       = v58_peatland.lo(j,land58);
 ov58_manLandExp(t,j,manLand58,"lower")                  = v58_manLandExp.lo(j,manLand58);
 ov58_manLandRed(t,j,manLand58,"lower")                  = v58_manLandRed.lo(j,manLand58);
 oq58_peatland(t,j,"lower")                              = q58_peatland.lo(j);
 oq58_peatlandChange(t,j,land58,"lower")                 = q58_peatlandChange.lo(j,land58);
 oq58_peatlandMan(t,j,manPeat58,"lower")                 = q58_peatlandMan.lo(j,manPeat58);
 oq58_peatlandRewet(t,j,"lower")                         = q58_peatlandRewet.lo(j);
 oq58_peatland_cost_full(t,j,"lower")                    = q58_peatland_cost_full.lo(j);
 oq58_peatland_cost(t,j,"lower")                         = q58_peatland_cost.lo(j);
 oq58_peatland_cost_annuity_intact(t,j,"lower")          = q58_peatland_cost_annuity_intact.lo(j);
 oq58_peatland_cost_annuity_rewet(t,j,"lower")           = q58_peatland_cost_annuity_rewet.lo(j);
 oq58_peatland_emis_detail(t,j,land58,emis58,"lower")    = q58_peatland_emis_detail.lo(j,land58,emis58);
 oq58_peatland_emis(t,i,poll58,"lower")                  = q58_peatland_emis.lo(i,poll58);
 oq58_manLandExp(t,j,manLand58,"lower")                  = q58_manLandExp.lo(j,manLand58);
 oq58_manLandRed(t,j,manLand58,"lower")                  = q58_manLandRed.lo(j,manLand58);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
