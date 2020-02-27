*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov73_prod_forestry(t,j,kforestry,"marginal")                  = v73_prod_forestry.m(j,kforestry);
 ov73_prod_natveg(t,j,land_natveg,ac_sub,kforestry,"marginal") = v73_prod_natveg.m(j,land_natveg,ac_sub,kforestry);
 ov_prod_heaven_timber(t,j,kforestry,"marginal")               = vm_prod_heaven_timber.m(j,kforestry);
 ov73_timber_demand(t,i,kforestry,"marginal")                  = v73_timber_demand.m(i,kforestry);
 oq73_prod_timber(t,j,kforestry,"marginal")                    = q73_prod_timber.m(j,kforestry);
 oq73_prod_forestry(t,j,kforestry,"marginal")                  = q73_prod_forestry.m(j,kforestry);
 oq73_prod_secdforest(t,j,ac_sub,kforestry,"marginal")         = q73_prod_secdforest.m(j,ac_sub,kforestry);
 oq73_hvarea_secdforest(t,j,ac_sub,kforestry,"marginal")       = q73_hvarea_secdforest.m(j,ac_sub,kforestry);
 oq73_prod_primforest(t,j,kforestry,"marginal")                = q73_prod_primforest.m(j,kforestry);
 oq73_hvarea_primforest(t,j,kforestry,"marginal")              = q73_hvarea_primforest.m(j,kforestry);
 oq73_prod_other(t,j,ac_sub,"marginal")                        = q73_prod_other.m(j,ac_sub);
 oq73_hvarea_other(t,j,ac_sub,"marginal")                      = q73_hvarea_other.m(j,ac_sub);
 oq73_timber_demand(t,i,kforestry,"marginal")                  = q73_timber_demand.m(i,kforestry);
 ov73_prod_forestry(t,j,kforestry,"level")                     = v73_prod_forestry.l(j,kforestry);
 ov73_prod_natveg(t,j,land_natveg,ac_sub,kforestry,"level")    = v73_prod_natveg.l(j,land_natveg,ac_sub,kforestry);
 ov_prod_heaven_timber(t,j,kforestry,"level")                  = vm_prod_heaven_timber.l(j,kforestry);
 ov73_timber_demand(t,i,kforestry,"level")                     = v73_timber_demand.l(i,kforestry);
 oq73_prod_timber(t,j,kforestry,"level")                       = q73_prod_timber.l(j,kforestry);
 oq73_prod_forestry(t,j,kforestry,"level")                     = q73_prod_forestry.l(j,kforestry);
 oq73_prod_secdforest(t,j,ac_sub,kforestry,"level")            = q73_prod_secdforest.l(j,ac_sub,kforestry);
 oq73_hvarea_secdforest(t,j,ac_sub,kforestry,"level")          = q73_hvarea_secdforest.l(j,ac_sub,kforestry);
 oq73_prod_primforest(t,j,kforestry,"level")                   = q73_prod_primforest.l(j,kforestry);
 oq73_hvarea_primforest(t,j,kforestry,"level")                 = q73_hvarea_primforest.l(j,kforestry);
 oq73_prod_other(t,j,ac_sub,"level")                           = q73_prod_other.l(j,ac_sub);
 oq73_hvarea_other(t,j,ac_sub,"level")                         = q73_hvarea_other.l(j,ac_sub);
 oq73_timber_demand(t,i,kforestry,"level")                     = q73_timber_demand.l(i,kforestry);
 ov73_prod_forestry(t,j,kforestry,"upper")                     = v73_prod_forestry.up(j,kforestry);
 ov73_prod_natveg(t,j,land_natveg,ac_sub,kforestry,"upper")    = v73_prod_natveg.up(j,land_natveg,ac_sub,kforestry);
 ov_prod_heaven_timber(t,j,kforestry,"upper")                  = vm_prod_heaven_timber.up(j,kforestry);
 ov73_timber_demand(t,i,kforestry,"upper")                     = v73_timber_demand.up(i,kforestry);
 oq73_prod_timber(t,j,kforestry,"upper")                       = q73_prod_timber.up(j,kforestry);
 oq73_prod_forestry(t,j,kforestry,"upper")                     = q73_prod_forestry.up(j,kforestry);
 oq73_prod_secdforest(t,j,ac_sub,kforestry,"upper")            = q73_prod_secdforest.up(j,ac_sub,kforestry);
 oq73_hvarea_secdforest(t,j,ac_sub,kforestry,"upper")          = q73_hvarea_secdforest.up(j,ac_sub,kforestry);
 oq73_prod_primforest(t,j,kforestry,"upper")                   = q73_prod_primforest.up(j,kforestry);
 oq73_hvarea_primforest(t,j,kforestry,"upper")                 = q73_hvarea_primforest.up(j,kforestry);
 oq73_prod_other(t,j,ac_sub,"upper")                           = q73_prod_other.up(j,ac_sub);
 oq73_hvarea_other(t,j,ac_sub,"upper")                         = q73_hvarea_other.up(j,ac_sub);
 oq73_timber_demand(t,i,kforestry,"upper")                     = q73_timber_demand.up(i,kforestry);
 ov73_prod_forestry(t,j,kforestry,"lower")                     = v73_prod_forestry.lo(j,kforestry);
 ov73_prod_natveg(t,j,land_natveg,ac_sub,kforestry,"lower")    = v73_prod_natveg.lo(j,land_natveg,ac_sub,kforestry);
 ov_prod_heaven_timber(t,j,kforestry,"lower")                  = vm_prod_heaven_timber.lo(j,kforestry);
 ov73_timber_demand(t,i,kforestry,"lower")                     = v73_timber_demand.lo(i,kforestry);
 oq73_prod_timber(t,j,kforestry,"lower")                       = q73_prod_timber.lo(j,kforestry);
 oq73_prod_forestry(t,j,kforestry,"lower")                     = q73_prod_forestry.lo(j,kforestry);
 oq73_prod_secdforest(t,j,ac_sub,kforestry,"lower")            = q73_prod_secdforest.lo(j,ac_sub,kforestry);
 oq73_hvarea_secdforest(t,j,ac_sub,kforestry,"lower")          = q73_hvarea_secdforest.lo(j,ac_sub,kforestry);
 oq73_prod_primforest(t,j,kforestry,"lower")                   = q73_prod_primforest.lo(j,kforestry);
 oq73_hvarea_primforest(t,j,kforestry,"lower")                 = q73_hvarea_primforest.lo(j,kforestry);
 oq73_prod_other(t,j,ac_sub,"lower")                           = q73_prod_other.lo(j,ac_sub);
 oq73_hvarea_other(t,j,ac_sub,"lower")                         = q73_hvarea_other.lo(j,ac_sub);
 oq73_timber_demand(t,i,kforestry,"lower")                     = q73_timber_demand.lo(i,kforestry);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
