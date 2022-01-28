*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de



*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_nr_inorg_fert_reg(t,i,land_ag,"marginal") = vm_nr_inorg_fert_reg.m(i,land_ag);
 ov_nr_inorg_fert_costs(t,i,"marginal")       = vm_nr_inorg_fert_costs.m(i);
 ov_nr_eff(t,i,"marginal")                    = vm_nr_eff.m(i);
 ov_nr_eff_pasture(t,i,"marginal")            = vm_nr_eff_pasture.m(i);
 ov_nr_inorg_fert_reg(t,i,land_ag,"level")    = vm_nr_inorg_fert_reg.l(i,land_ag);
 ov_nr_inorg_fert_costs(t,i,"level")          = vm_nr_inorg_fert_costs.l(i);
 ov_nr_eff(t,i,"level")                       = vm_nr_eff.l(i);
 ov_nr_eff_pasture(t,i,"level")               = vm_nr_eff_pasture.l(i);
 ov_nr_inorg_fert_reg(t,i,land_ag,"upper")    = vm_nr_inorg_fert_reg.up(i,land_ag);
 ov_nr_inorg_fert_costs(t,i,"upper")          = vm_nr_inorg_fert_costs.up(i);
 ov_nr_eff(t,i,"upper")                       = vm_nr_eff.up(i);
 ov_nr_eff_pasture(t,i,"upper")               = vm_nr_eff_pasture.up(i);
 ov_nr_inorg_fert_reg(t,i,land_ag,"lower")    = vm_nr_inorg_fert_reg.lo(i,land_ag);
 ov_nr_inorg_fert_costs(t,i,"lower")          = vm_nr_inorg_fert_costs.lo(i);
 ov_nr_eff(t,i,"lower")                       = vm_nr_eff.lo(i);
 ov_nr_eff_pasture(t,i,"lower")               = vm_nr_eff_pasture.lo(i);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################

