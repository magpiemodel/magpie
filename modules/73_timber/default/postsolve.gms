*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_cost_timber(t,i,"marginal")                     = vm_cost_timber.m(i);
 ov73_prod_heaven_timber(t,j,kforestry,"marginal")  = v73_prod_heaven_timber.m(j,kforestry);
 ov73_prod_residues(t,j,"marginal")                 = v73_prod_residues.m(j);
 oq73_cost_timber(t,i,"marginal")                   = q73_cost_timber.m(i);
 oq73_prod_wood(t,j,"marginal")                     = q73_prod_wood.m(j);
 oq73_prod_woodfuel(t,j,"marginal")                 = q73_prod_woodfuel.m(j);
 oq73_prod_residues(t,j,"marginal")                 = q73_prod_residues.m(j);
 oq73_prod_forestry_upper(t,i,kforestry,"marginal") = q73_prod_forestry_upper.m(i,kforestry);
 ov_cost_timber(t,i,"level")                        = vm_cost_timber.l(i);
 ov73_prod_heaven_timber(t,j,kforestry,"level")     = v73_prod_heaven_timber.l(j,kforestry);
 ov73_prod_residues(t,j,"level")                    = v73_prod_residues.l(j);
 oq73_cost_timber(t,i,"level")                      = q73_cost_timber.l(i);
 oq73_prod_wood(t,j,"level")                        = q73_prod_wood.l(j);
 oq73_prod_woodfuel(t,j,"level")                    = q73_prod_woodfuel.l(j);
 oq73_prod_residues(t,j,"level")                    = q73_prod_residues.l(j);
 oq73_prod_forestry_upper(t,i,kforestry,"level")    = q73_prod_forestry_upper.l(i,kforestry);
 ov_cost_timber(t,i,"upper")                        = vm_cost_timber.up(i);
 ov73_prod_heaven_timber(t,j,kforestry,"upper")     = v73_prod_heaven_timber.up(j,kforestry);
 ov73_prod_residues(t,j,"upper")                    = v73_prod_residues.up(j);
 oq73_cost_timber(t,i,"upper")                      = q73_cost_timber.up(i);
 oq73_prod_wood(t,j,"upper")                        = q73_prod_wood.up(j);
 oq73_prod_woodfuel(t,j,"upper")                    = q73_prod_woodfuel.up(j);
 oq73_prod_residues(t,j,"upper")                    = q73_prod_residues.up(j);
 oq73_prod_forestry_upper(t,i,kforestry,"upper")    = q73_prod_forestry_upper.up(i,kforestry);
 ov_cost_timber(t,i,"lower")                        = vm_cost_timber.lo(i);
 ov73_prod_heaven_timber(t,j,kforestry,"lower")     = v73_prod_heaven_timber.lo(j,kforestry);
 ov73_prod_residues(t,j,"lower")                    = v73_prod_residues.lo(j);
 oq73_cost_timber(t,i,"lower")                      = q73_cost_timber.lo(i);
 oq73_prod_wood(t,j,"lower")                        = q73_prod_wood.lo(j);
 oq73_prod_woodfuel(t,j,"lower")                    = q73_prod_woodfuel.lo(j);
 oq73_prod_residues(t,j,"lower")                    = q73_prod_residues.lo(j);
 oq73_prod_forestry_upper(t,i,kforestry,"lower")    = q73_prod_forestry_upper.lo(i,kforestry);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
