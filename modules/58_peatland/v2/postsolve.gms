*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

pc58_peatland(j,land58) = v58_peatland.l(j,land58);
pc58_manLand(j,manPeat58) = v58_manLand.l(j,manPeat58);

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov58_peatlandChange(t,j,land58,"marginal")              = v58_peatlandChange.m(j,land58);
 ov_peatland_cost(t,j,"marginal")                        = vm_peatland_cost.m(j);
 ov58_peatland_emis(t,j,land58,emis58,"marginal")        = v58_peatland_emis.m(j,land58,emis58);
 ov58_peatland(t,j,land58,"marginal")                    = v58_peatland.m(j,land58);
 ov58_manLand(t,j,manPeat58,"marginal")                  = v58_manLand.m(j,manPeat58);
 ov58_manLandExp(t,j,manPeat58,"marginal")               = v58_manLandExp.m(j,manPeat58);
 ov58_manLandRed(t,j,manPeat58,"marginal")               = v58_manLandRed.m(j,manPeat58);
 ov58_balance(t,j,manPeat58,"marginal")                  = v58_balance.m(j,manPeat58);
 ov58_balance2(t,j,manPeat58,"marginal")                 = v58_balance2.m(j,manPeat58);
 ov58_peatland_cost_annuity(t,j,cost58,"marginal")       = v58_peatland_cost_annuity.m(j,cost58);
 oq58_peatland(t,j,"marginal")                           = q58_peatland.m(j);
 oq58_peatlandChange(t,j,land58,"marginal")              = q58_peatlandChange.m(j,land58);
 oq58_manLand(t,j,manPeat58,"marginal")                  = q58_manLand.m(j,manPeat58);
 oq58_manLandExp(t,j,manPeat58,"marginal")               = q58_manLandExp.m(j,manPeat58);
 oq58_manLandRed(t,j,manPeat58,"marginal")               = q58_manLandRed.m(j,manPeat58);
 oq58_peatlandMan(t,j,manPeat58,"marginal")              = q58_peatlandMan.m(j,manPeat58);
 oq58_peatlandMan2(t,j,manPeat58,"marginal")             = q58_peatlandMan2.m(j,manPeat58);
 oq58_peatland_cost(t,j,"marginal")                      = q58_peatland_cost.m(j);
 oq58_peatland_cost_annuity(t,j,cost58,"marginal")       = q58_peatland_cost_annuity.m(j,cost58);
 oq58_peatland_emis_detail(t,j,land58,emis58,"marginal") = q58_peatland_emis_detail.m(j,land58,emis58);
 oq58_peatland_emis(t,i,poll58,"marginal")               = q58_peatland_emis.m(i,poll58);
 ov58_peatlandChange(t,j,land58,"level")                 = v58_peatlandChange.l(j,land58);
 ov_peatland_cost(t,j,"level")                           = vm_peatland_cost.l(j);
 ov58_peatland_emis(t,j,land58,emis58,"level")           = v58_peatland_emis.l(j,land58,emis58);
 ov58_peatland(t,j,land58,"level")                       = v58_peatland.l(j,land58);
 ov58_manLand(t,j,manPeat58,"level")                     = v58_manLand.l(j,manPeat58);
 ov58_manLandExp(t,j,manPeat58,"level")                  = v58_manLandExp.l(j,manPeat58);
 ov58_manLandRed(t,j,manPeat58,"level")                  = v58_manLandRed.l(j,manPeat58);
 ov58_balance(t,j,manPeat58,"level")                     = v58_balance.l(j,manPeat58);
 ov58_balance2(t,j,manPeat58,"level")                    = v58_balance2.l(j,manPeat58);
 ov58_peatland_cost_annuity(t,j,cost58,"level")          = v58_peatland_cost_annuity.l(j,cost58);
 oq58_peatland(t,j,"level")                              = q58_peatland.l(j);
 oq58_peatlandChange(t,j,land58,"level")                 = q58_peatlandChange.l(j,land58);
 oq58_manLand(t,j,manPeat58,"level")                     = q58_manLand.l(j,manPeat58);
 oq58_manLandExp(t,j,manPeat58,"level")                  = q58_manLandExp.l(j,manPeat58);
 oq58_manLandRed(t,j,manPeat58,"level")                  = q58_manLandRed.l(j,manPeat58);
 oq58_peatlandMan(t,j,manPeat58,"level")                 = q58_peatlandMan.l(j,manPeat58);
 oq58_peatlandMan2(t,j,manPeat58,"level")                = q58_peatlandMan2.l(j,manPeat58);
 oq58_peatland_cost(t,j,"level")                         = q58_peatland_cost.l(j);
 oq58_peatland_cost_annuity(t,j,cost58,"level")          = q58_peatland_cost_annuity.l(j,cost58);
 oq58_peatland_emis_detail(t,j,land58,emis58,"level")    = q58_peatland_emis_detail.l(j,land58,emis58);
 oq58_peatland_emis(t,i,poll58,"level")                  = q58_peatland_emis.l(i,poll58);
 ov58_peatlandChange(t,j,land58,"upper")                 = v58_peatlandChange.up(j,land58);
 ov_peatland_cost(t,j,"upper")                           = vm_peatland_cost.up(j);
 ov58_peatland_emis(t,j,land58,emis58,"upper")           = v58_peatland_emis.up(j,land58,emis58);
 ov58_peatland(t,j,land58,"upper")                       = v58_peatland.up(j,land58);
 ov58_manLand(t,j,manPeat58,"upper")                     = v58_manLand.up(j,manPeat58);
 ov58_manLandExp(t,j,manPeat58,"upper")                  = v58_manLandExp.up(j,manPeat58);
 ov58_manLandRed(t,j,manPeat58,"upper")                  = v58_manLandRed.up(j,manPeat58);
 ov58_balance(t,j,manPeat58,"upper")                     = v58_balance.up(j,manPeat58);
 ov58_balance2(t,j,manPeat58,"upper")                    = v58_balance2.up(j,manPeat58);
 ov58_peatland_cost_annuity(t,j,cost58,"upper")          = v58_peatland_cost_annuity.up(j,cost58);
 oq58_peatland(t,j,"upper")                              = q58_peatland.up(j);
 oq58_peatlandChange(t,j,land58,"upper")                 = q58_peatlandChange.up(j,land58);
 oq58_manLand(t,j,manPeat58,"upper")                     = q58_manLand.up(j,manPeat58);
 oq58_manLandExp(t,j,manPeat58,"upper")                  = q58_manLandExp.up(j,manPeat58);
 oq58_manLandRed(t,j,manPeat58,"upper")                  = q58_manLandRed.up(j,manPeat58);
 oq58_peatlandMan(t,j,manPeat58,"upper")                 = q58_peatlandMan.up(j,manPeat58);
 oq58_peatlandMan2(t,j,manPeat58,"upper")                = q58_peatlandMan2.up(j,manPeat58);
 oq58_peatland_cost(t,j,"upper")                         = q58_peatland_cost.up(j);
 oq58_peatland_cost_annuity(t,j,cost58,"upper")          = q58_peatland_cost_annuity.up(j,cost58);
 oq58_peatland_emis_detail(t,j,land58,emis58,"upper")    = q58_peatland_emis_detail.up(j,land58,emis58);
 oq58_peatland_emis(t,i,poll58,"upper")                  = q58_peatland_emis.up(i,poll58);
 ov58_peatlandChange(t,j,land58,"lower")                 = v58_peatlandChange.lo(j,land58);
 ov_peatland_cost(t,j,"lower")                           = vm_peatland_cost.lo(j);
 ov58_peatland_emis(t,j,land58,emis58,"lower")           = v58_peatland_emis.lo(j,land58,emis58);
 ov58_peatland(t,j,land58,"lower")                       = v58_peatland.lo(j,land58);
 ov58_manLand(t,j,manPeat58,"lower")                     = v58_manLand.lo(j,manPeat58);
 ov58_manLandExp(t,j,manPeat58,"lower")                  = v58_manLandExp.lo(j,manPeat58);
 ov58_manLandRed(t,j,manPeat58,"lower")                  = v58_manLandRed.lo(j,manPeat58);
 ov58_balance(t,j,manPeat58,"lower")                     = v58_balance.lo(j,manPeat58);
 ov58_balance2(t,j,manPeat58,"lower")                    = v58_balance2.lo(j,manPeat58);
 ov58_peatland_cost_annuity(t,j,cost58,"lower")          = v58_peatland_cost_annuity.lo(j,cost58);
 oq58_peatland(t,j,"lower")                              = q58_peatland.lo(j);
 oq58_peatlandChange(t,j,land58,"lower")                 = q58_peatlandChange.lo(j,land58);
 oq58_manLand(t,j,manPeat58,"lower")                     = q58_manLand.lo(j,manPeat58);
 oq58_manLandExp(t,j,manPeat58,"lower")                  = q58_manLandExp.lo(j,manPeat58);
 oq58_manLandRed(t,j,manPeat58,"lower")                  = q58_manLandRed.lo(j,manPeat58);
 oq58_peatlandMan(t,j,manPeat58,"lower")                 = q58_peatlandMan.lo(j,manPeat58);
 oq58_peatlandMan2(t,j,manPeat58,"lower")                = q58_peatlandMan2.lo(j,manPeat58);
 oq58_peatland_cost(t,j,"lower")                         = q58_peatland_cost.lo(j);
 oq58_peatland_cost_annuity(t,j,cost58,"lower")          = q58_peatland_cost_annuity.lo(j,cost58);
 oq58_peatland_emis_detail(t,j,land58,emis58,"lower")    = q58_peatland_emis_detail.lo(j,land58,emis58);
 oq58_peatland_emis(t,i,poll58,"lower")                  = q58_peatland_emis.lo(i,poll58);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
