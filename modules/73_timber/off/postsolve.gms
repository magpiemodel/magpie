*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov73_prod_heaven_timber(t,j,kforestry,"marginal") = v73_prod_heaven_timber.m(j,kforestry);
 ov_cost_timber(t,i,"marginal")                    = vm_cost_timber.m(i);
 ov_hvarea_secdforest(t,j,ac_sub,"marginal")       = vm_hvarea_secdforest.m(j,ac_sub);
 ov73_hvarea_other(t,j,ac_sub,"marginal")          = v73_hvarea_other.m(j,ac_sub);
 ov_hvarea_primforest(t,j,"marginal")              = vm_hvarea_primforest.m(j);
 ov73_hvarea_forestry(t,j,ac_sub,"marginal")       = v73_hvarea_forestry.m(j,ac_sub);
 ov73_prod_heaven_timber(t,j,kforestry,"level")    = v73_prod_heaven_timber.l(j,kforestry);
 ov_cost_timber(t,i,"level")                       = vm_cost_timber.l(i);
 ov_hvarea_secdforest(t,j,ac_sub,"level")          = vm_hvarea_secdforest.l(j,ac_sub);
 ov73_hvarea_other(t,j,ac_sub,"level")             = v73_hvarea_other.l(j,ac_sub);
 ov_hvarea_primforest(t,j,"level")                 = vm_hvarea_primforest.l(j);
 ov73_hvarea_forestry(t,j,ac_sub,"level")          = v73_hvarea_forestry.l(j,ac_sub);
 ov73_prod_heaven_timber(t,j,kforestry,"upper")    = v73_prod_heaven_timber.up(j,kforestry);
 ov_cost_timber(t,i,"upper")                       = vm_cost_timber.up(i);
 ov_hvarea_secdforest(t,j,ac_sub,"upper")          = vm_hvarea_secdforest.up(j,ac_sub);
 ov73_hvarea_other(t,j,ac_sub,"upper")             = v73_hvarea_other.up(j,ac_sub);
 ov_hvarea_primforest(t,j,"upper")                 = vm_hvarea_primforest.up(j);
 ov73_hvarea_forestry(t,j,ac_sub,"upper")          = v73_hvarea_forestry.up(j,ac_sub);
 ov73_prod_heaven_timber(t,j,kforestry,"lower")    = v73_prod_heaven_timber.lo(j,kforestry);
 ov_cost_timber(t,i,"lower")                       = vm_cost_timber.lo(i);
 ov_hvarea_secdforest(t,j,ac_sub,"lower")          = vm_hvarea_secdforest.lo(j,ac_sub);
 ov73_hvarea_other(t,j,ac_sub,"lower")             = v73_hvarea_other.lo(j,ac_sub);
 ov_hvarea_primforest(t,j,"lower")                 = vm_hvarea_primforest.lo(j);
 ov73_hvarea_forestry(t,j,ac_sub,"lower")          = v73_hvarea_forestry.lo(j,ac_sub);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
