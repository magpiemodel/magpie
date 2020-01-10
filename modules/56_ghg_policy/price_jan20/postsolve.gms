*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de



*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_reward_cdr_aff(t,i,"marginal")                                     = vm_reward_cdr_aff.m(i);
 ov56_reward_cdr_aff(t,j,"marginal")                                   = v56_reward_cdr_aff.m(j);
 ov_btm_reg(t,i,emis_source,pollutants,"marginal")                     = vm_btm_reg.m(i,emis_source,pollutants);
 ov_btm_cell(t,j,emis_source,pollutants,"marginal")                    = vm_btm_cell.m(j,emis_source,pollutants);
 ov_emission_costs(t,i,"marginal")                                     = vm_emission_costs.m(i);
 ov_emissions_reg(t,i,emis_source,pollutants,"marginal")               = vm_emissions_reg.m(i,emis_source,pollutants);
 ov56_emis_cell(t,j,emis_source,pollutants,"marginal")                 = v56_emis_cell.m(j,emis_source,pollutants);
 ov56_emission_costs_reg_yearly(t,i,emis_reg_yr56,"marginal")          = v56_emission_costs_reg_yearly.m(i,emis_reg_yr56);
 ov56_emission_costs_reg_oneoff(t,i,emis_reg_one56,"marginal")         = v56_emission_costs_reg_oneoff.m(i,emis_reg_one56);
 ov56_emission_costs_cell_yearly(t,j,emis_cell_yr56,"marginal")        = v56_emission_costs_cell_yearly.m(j,emis_cell_yr56);
 ov56_emission_costs_cell_oneoff(t,j,emis_cell_one56,"marginal")       = v56_emission_costs_cell_oneoff.m(j,emis_cell_one56);
 oq56_technical_mitigation_reg(t,i,pollutants,emis_source,"marginal")  = q56_technical_mitigation_reg.m(i,pollutants,emis_source);
 oq56_technical_mitigation_cell(t,j,pollutants,emis_source,"marginal") = q56_technical_mitigation_cell.m(j,pollutants,emis_source);
 oq56_cell_to_reg(t,i,pollutants,emis_source,"marginal")               = q56_cell_to_reg.m(i,pollutants,emis_source);
 oq56_emission_costs(t,i,"marginal")                                   = q56_emission_costs.m(i);
 oq56_emission_costs_reg_yearly(t,i,emis_reg_yr56,"marginal")          = q56_emission_costs_reg_yearly.m(i,emis_reg_yr56);
 oq56_emission_costs_reg_oneoff(t,i,emis_reg_one56,"marginal")         = q56_emission_costs_reg_oneoff.m(i,emis_reg_one56);
 oq56_emission_costs_cell_yearly(t,j,emis_cell_yr56,"marginal")        = q56_emission_costs_cell_yearly.m(j,emis_cell_yr56);
 oq56_emission_costs_cell_oneoff(t,j,emis_cell_one56,"marginal")       = q56_emission_costs_cell_oneoff.m(j,emis_cell_one56);
 oq56_reward_cdr_aff_reg(t,i,"marginal")                               = q56_reward_cdr_aff_reg.m(i);
 oq56_reward_cdr_aff(t,j,"marginal")                                   = q56_reward_cdr_aff.m(j);
 ov_reward_cdr_aff(t,i,"level")                                        = vm_reward_cdr_aff.l(i);
 ov56_reward_cdr_aff(t,j,"level")                                      = v56_reward_cdr_aff.l(j);
 ov_btm_reg(t,i,emis_source,pollutants,"level")                        = vm_btm_reg.l(i,emis_source,pollutants);
 ov_btm_cell(t,j,emis_source,pollutants,"level")                       = vm_btm_cell.l(j,emis_source,pollutants);
 ov_emission_costs(t,i,"level")                                        = vm_emission_costs.l(i);
 ov_emissions_reg(t,i,emis_source,pollutants,"level")                  = vm_emissions_reg.l(i,emis_source,pollutants);
 ov56_emis_cell(t,j,emis_source,pollutants,"level")                    = v56_emis_cell.l(j,emis_source,pollutants);
 ov56_emission_costs_reg_yearly(t,i,emis_reg_yr56,"level")             = v56_emission_costs_reg_yearly.l(i,emis_reg_yr56);
 ov56_emission_costs_reg_oneoff(t,i,emis_reg_one56,"level")            = v56_emission_costs_reg_oneoff.l(i,emis_reg_one56);
 ov56_emission_costs_cell_yearly(t,j,emis_cell_yr56,"level")           = v56_emission_costs_cell_yearly.l(j,emis_cell_yr56);
 ov56_emission_costs_cell_oneoff(t,j,emis_cell_one56,"level")          = v56_emission_costs_cell_oneoff.l(j,emis_cell_one56);
 oq56_technical_mitigation_reg(t,i,pollutants,emis_source,"level")     = q56_technical_mitigation_reg.l(i,pollutants,emis_source);
 oq56_technical_mitigation_cell(t,j,pollutants,emis_source,"level")    = q56_technical_mitigation_cell.l(j,pollutants,emis_source);
 oq56_cell_to_reg(t,i,pollutants,emis_source,"level")                  = q56_cell_to_reg.l(i,pollutants,emis_source);
 oq56_emission_costs(t,i,"level")                                      = q56_emission_costs.l(i);
 oq56_emission_costs_reg_yearly(t,i,emis_reg_yr56,"level")             = q56_emission_costs_reg_yearly.l(i,emis_reg_yr56);
 oq56_emission_costs_reg_oneoff(t,i,emis_reg_one56,"level")            = q56_emission_costs_reg_oneoff.l(i,emis_reg_one56);
 oq56_emission_costs_cell_yearly(t,j,emis_cell_yr56,"level")           = q56_emission_costs_cell_yearly.l(j,emis_cell_yr56);
 oq56_emission_costs_cell_oneoff(t,j,emis_cell_one56,"level")          = q56_emission_costs_cell_oneoff.l(j,emis_cell_one56);
 oq56_reward_cdr_aff_reg(t,i,"level")                                  = q56_reward_cdr_aff_reg.l(i);
 oq56_reward_cdr_aff(t,j,"level")                                      = q56_reward_cdr_aff.l(j);
 ov_reward_cdr_aff(t,i,"upper")                                        = vm_reward_cdr_aff.up(i);
 ov56_reward_cdr_aff(t,j,"upper")                                      = v56_reward_cdr_aff.up(j);
 ov_btm_reg(t,i,emis_source,pollutants,"upper")                        = vm_btm_reg.up(i,emis_source,pollutants);
 ov_btm_cell(t,j,emis_source,pollutants,"upper")                       = vm_btm_cell.up(j,emis_source,pollutants);
 ov_emission_costs(t,i,"upper")                                        = vm_emission_costs.up(i);
 ov_emissions_reg(t,i,emis_source,pollutants,"upper")                  = vm_emissions_reg.up(i,emis_source,pollutants);
 ov56_emis_cell(t,j,emis_source,pollutants,"upper")                    = v56_emis_cell.up(j,emis_source,pollutants);
 ov56_emission_costs_reg_yearly(t,i,emis_reg_yr56,"upper")             = v56_emission_costs_reg_yearly.up(i,emis_reg_yr56);
 ov56_emission_costs_reg_oneoff(t,i,emis_reg_one56,"upper")            = v56_emission_costs_reg_oneoff.up(i,emis_reg_one56);
 ov56_emission_costs_cell_yearly(t,j,emis_cell_yr56,"upper")           = v56_emission_costs_cell_yearly.up(j,emis_cell_yr56);
 ov56_emission_costs_cell_oneoff(t,j,emis_cell_one56,"upper")          = v56_emission_costs_cell_oneoff.up(j,emis_cell_one56);
 oq56_technical_mitigation_reg(t,i,pollutants,emis_source,"upper")     = q56_technical_mitigation_reg.up(i,pollutants,emis_source);
 oq56_technical_mitigation_cell(t,j,pollutants,emis_source,"upper")    = q56_technical_mitigation_cell.up(j,pollutants,emis_source);
 oq56_cell_to_reg(t,i,pollutants,emis_source,"upper")                  = q56_cell_to_reg.up(i,pollutants,emis_source);
 oq56_emission_costs(t,i,"upper")                                      = q56_emission_costs.up(i);
 oq56_emission_costs_reg_yearly(t,i,emis_reg_yr56,"upper")             = q56_emission_costs_reg_yearly.up(i,emis_reg_yr56);
 oq56_emission_costs_reg_oneoff(t,i,emis_reg_one56,"upper")            = q56_emission_costs_reg_oneoff.up(i,emis_reg_one56);
 oq56_emission_costs_cell_yearly(t,j,emis_cell_yr56,"upper")           = q56_emission_costs_cell_yearly.up(j,emis_cell_yr56);
 oq56_emission_costs_cell_oneoff(t,j,emis_cell_one56,"upper")          = q56_emission_costs_cell_oneoff.up(j,emis_cell_one56);
 oq56_reward_cdr_aff_reg(t,i,"upper")                                  = q56_reward_cdr_aff_reg.up(i);
 oq56_reward_cdr_aff(t,j,"upper")                                      = q56_reward_cdr_aff.up(j);
 ov_reward_cdr_aff(t,i,"lower")                                        = vm_reward_cdr_aff.lo(i);
 ov56_reward_cdr_aff(t,j,"lower")                                      = v56_reward_cdr_aff.lo(j);
 ov_btm_reg(t,i,emis_source,pollutants,"lower")                        = vm_btm_reg.lo(i,emis_source,pollutants);
 ov_btm_cell(t,j,emis_source,pollutants,"lower")                       = vm_btm_cell.lo(j,emis_source,pollutants);
 ov_emission_costs(t,i,"lower")                                        = vm_emission_costs.lo(i);
 ov_emissions_reg(t,i,emis_source,pollutants,"lower")                  = vm_emissions_reg.lo(i,emis_source,pollutants);
 ov56_emis_cell(t,j,emis_source,pollutants,"lower")                    = v56_emis_cell.lo(j,emis_source,pollutants);
 ov56_emission_costs_reg_yearly(t,i,emis_reg_yr56,"lower")             = v56_emission_costs_reg_yearly.lo(i,emis_reg_yr56);
 ov56_emission_costs_reg_oneoff(t,i,emis_reg_one56,"lower")            = v56_emission_costs_reg_oneoff.lo(i,emis_reg_one56);
 ov56_emission_costs_cell_yearly(t,j,emis_cell_yr56,"lower")           = v56_emission_costs_cell_yearly.lo(j,emis_cell_yr56);
 ov56_emission_costs_cell_oneoff(t,j,emis_cell_one56,"lower")          = v56_emission_costs_cell_oneoff.lo(j,emis_cell_one56);
 oq56_technical_mitigation_reg(t,i,pollutants,emis_source,"lower")     = q56_technical_mitigation_reg.lo(i,pollutants,emis_source);
 oq56_technical_mitigation_cell(t,j,pollutants,emis_source,"lower")    = q56_technical_mitigation_cell.lo(j,pollutants,emis_source);
 oq56_cell_to_reg(t,i,pollutants,emis_source,"lower")                  = q56_cell_to_reg.lo(i,pollutants,emis_source);
 oq56_emission_costs(t,i,"lower")                                      = q56_emission_costs.lo(i);
 oq56_emission_costs_reg_yearly(t,i,emis_reg_yr56,"lower")             = q56_emission_costs_reg_yearly.lo(i,emis_reg_yr56);
 oq56_emission_costs_reg_oneoff(t,i,emis_reg_one56,"lower")            = q56_emission_costs_reg_oneoff.lo(i,emis_reg_one56);
 oq56_emission_costs_cell_yearly(t,j,emis_cell_yr56,"lower")           = q56_emission_costs_cell_yearly.lo(j,emis_cell_yr56);
 oq56_emission_costs_cell_oneoff(t,j,emis_cell_one56,"lower")          = q56_emission_costs_cell_oneoff.lo(j,emis_cell_one56);
 oq56_reward_cdr_aff_reg(t,i,"lower")                                  = q56_reward_cdr_aff_reg.lo(i);
 oq56_reward_cdr_aff(t,j,"lower")                                      = q56_reward_cdr_aff.lo(j);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
