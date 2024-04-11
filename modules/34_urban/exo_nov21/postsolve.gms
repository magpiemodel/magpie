*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_cost_urban(t,j,"marginal")           = vm_cost_urban.m(j);
 ov34_cost1(t,j,"marginal")              = v34_cost1.m(j);
 ov34_cost2(t,j,"marginal")              = v34_cost2.m(j);
 oq34_urban_cell(t,j,"marginal")         = q34_urban_cell.m(j);
 oq34_urban_land(t,i,"marginal")         = q34_urban_land.m(i);
 oq34_urban_cost1(t,j,"marginal")        = q34_urban_cost1.m(j);
 oq34_urban_cost2(t,j,"marginal")        = q34_urban_cost2.m(j);
 oq34_bv_urban(t,j,potnatveg,"marginal") = q34_bv_urban.m(j,potnatveg);
 ov_cost_urban(t,j,"level")              = vm_cost_urban.l(j);
 ov34_cost1(t,j,"level")                 = v34_cost1.l(j);
 ov34_cost2(t,j,"level")                 = v34_cost2.l(j);
 oq34_urban_cell(t,j,"level")            = q34_urban_cell.l(j);
 oq34_urban_land(t,i,"level")            = q34_urban_land.l(i);
 oq34_urban_cost1(t,j,"level")           = q34_urban_cost1.l(j);
 oq34_urban_cost2(t,j,"level")           = q34_urban_cost2.l(j);
 oq34_bv_urban(t,j,potnatveg,"level")    = q34_bv_urban.l(j,potnatveg);
 ov_cost_urban(t,j,"upper")              = vm_cost_urban.up(j);
 ov34_cost1(t,j,"upper")                 = v34_cost1.up(j);
 ov34_cost2(t,j,"upper")                 = v34_cost2.up(j);
 oq34_urban_cell(t,j,"upper")            = q34_urban_cell.up(j);
 oq34_urban_land(t,i,"upper")            = q34_urban_land.up(i);
 oq34_urban_cost1(t,j,"upper")           = q34_urban_cost1.up(j);
 oq34_urban_cost2(t,j,"upper")           = q34_urban_cost2.up(j);
 oq34_bv_urban(t,j,potnatveg,"upper")    = q34_bv_urban.up(j,potnatveg);
 ov_cost_urban(t,j,"lower")              = vm_cost_urban.lo(j);
 ov34_cost1(t,j,"lower")                 = v34_cost1.lo(j);
 ov34_cost2(t,j,"lower")                 = v34_cost2.lo(j);
 oq34_urban_cell(t,j,"lower")            = q34_urban_cell.lo(j);
 oq34_urban_land(t,i,"lower")            = q34_urban_land.lo(i);
 oq34_urban_cost1(t,j,"lower")           = q34_urban_cost1.lo(j);
 oq34_urban_cost2(t,j,"lower")           = q34_urban_cost2.lo(j);
 oq34_bv_urban(t,j,potnatveg,"lower")    = q34_bv_urban.lo(j,potnatveg);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################

