*** |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de



*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_dem_bioen(t,i,kall,"marginal")                        = vm_dem_bioen.m(i,kall);
 ov60_2ndgen_bioenergy_dem_dedicated(t,i,kall,"marginal") = v60_2ndgen_bioenergy_dem_dedicated.m(i,kall);
 ov60_2ndgen_bioenergy_dem_residues(t,i,kall,"marginal")  = v60_2ndgen_bioenergy_dem_residues.m(i,kall);
 ov_bioenergy_utility(t,i,"marginal")                     = vm_bioenergy_utility.m(i);
 oq60_bioenergy(t,i,kall,"marginal")                      = q60_bioenergy.m(i,kall);
 oq60_bioenergy_glo(t,"marginal")                         = q60_bioenergy_glo.m;
 oq60_bioenergy_reg(t,i,"marginal")                       = q60_bioenergy_reg.m(i);
 oq60_res_2ndgenBE(t,i,"marginal")                        = q60_res_2ndgenBE.m(i);
 oq60_bioenergy_incentive(t,i,"marginal")                 = q60_bioenergy_incentive.m(i);
 ov_dem_bioen(t,i,kall,"level")                           = vm_dem_bioen.l(i,kall);
 ov60_2ndgen_bioenergy_dem_dedicated(t,i,kall,"level")    = v60_2ndgen_bioenergy_dem_dedicated.l(i,kall);
 ov60_2ndgen_bioenergy_dem_residues(t,i,kall,"level")     = v60_2ndgen_bioenergy_dem_residues.l(i,kall);
 ov_bioenergy_utility(t,i,"level")                        = vm_bioenergy_utility.l(i);
 oq60_bioenergy(t,i,kall,"level")                         = q60_bioenergy.l(i,kall);
 oq60_bioenergy_glo(t,"level")                            = q60_bioenergy_glo.l;
 oq60_bioenergy_reg(t,i,"level")                          = q60_bioenergy_reg.l(i);
 oq60_res_2ndgenBE(t,i,"level")                           = q60_res_2ndgenBE.l(i);
 oq60_bioenergy_incentive(t,i,"level")                    = q60_bioenergy_incentive.l(i);
 ov_dem_bioen(t,i,kall,"upper")                           = vm_dem_bioen.up(i,kall);
 ov60_2ndgen_bioenergy_dem_dedicated(t,i,kall,"upper")    = v60_2ndgen_bioenergy_dem_dedicated.up(i,kall);
 ov60_2ndgen_bioenergy_dem_residues(t,i,kall,"upper")     = v60_2ndgen_bioenergy_dem_residues.up(i,kall);
 ov_bioenergy_utility(t,i,"upper")                        = vm_bioenergy_utility.up(i);
 oq60_bioenergy(t,i,kall,"upper")                         = q60_bioenergy.up(i,kall);
 oq60_bioenergy_glo(t,"upper")                            = q60_bioenergy_glo.up;
 oq60_bioenergy_reg(t,i,"upper")                          = q60_bioenergy_reg.up(i);
 oq60_res_2ndgenBE(t,i,"upper")                           = q60_res_2ndgenBE.up(i);
 oq60_bioenergy_incentive(t,i,"upper")                    = q60_bioenergy_incentive.up(i);
 ov_dem_bioen(t,i,kall,"lower")                           = vm_dem_bioen.lo(i,kall);
 ov60_2ndgen_bioenergy_dem_dedicated(t,i,kall,"lower")    = v60_2ndgen_bioenergy_dem_dedicated.lo(i,kall);
 ov60_2ndgen_bioenergy_dem_residues(t,i,kall,"lower")     = v60_2ndgen_bioenergy_dem_residues.lo(i,kall);
 ov_bioenergy_utility(t,i,"lower")                        = vm_bioenergy_utility.lo(i);
 oq60_bioenergy(t,i,kall,"lower")                         = q60_bioenergy.lo(i,kall);
 oq60_bioenergy_glo(t,"lower")                            = q60_bioenergy_glo.lo;
 oq60_bioenergy_reg(t,i,"lower")                          = q60_bioenergy_reg.lo(i);
 oq60_res_2ndgenBE(t,i,"lower")                           = q60_res_2ndgenBE.lo(i);
 oq60_bioenergy_incentive(t,i,"lower")                    = q60_bioenergy_incentive.lo(i);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################

