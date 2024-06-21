*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de



*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_nr_som(t,j,"marginal")                                       = vm_nr_som.m(j);
 ov_nr_som_fertilizer(t,j,"marginal")                            = vm_nr_som_fertilizer.m(j);
 oq59_soilcarbon_cropland(t,j,stockType,"marginal")              = q59_soilcarbon_cropland.m(j,stockType);
 oq59_soilcarbon_regular(t,j,regularland59,stockType,"marginal") = q59_soilcarbon_regular.m(j,regularland59,stockType);
 oq59_soilcarbon_other(t,j,stockType,"marginal")                 = q59_soilcarbon_other.m(j,stockType);
 ov_nr_som(t,j,"level")                                          = vm_nr_som.l(j);
 ov_nr_som_fertilizer(t,j,"level")                               = vm_nr_som_fertilizer.l(j);
 oq59_soilcarbon_cropland(t,j,stockType,"level")                 = q59_soilcarbon_cropland.l(j,stockType);
 oq59_soilcarbon_regular(t,j,regularland59,stockType,"level")    = q59_soilcarbon_regular.l(j,regularland59,stockType);
 oq59_soilcarbon_other(t,j,stockType,"level")                    = q59_soilcarbon_other.l(j,stockType);
 ov_nr_som(t,j,"upper")                                          = vm_nr_som.up(j);
 ov_nr_som_fertilizer(t,j,"upper")                               = vm_nr_som_fertilizer.up(j);
 oq59_soilcarbon_cropland(t,j,stockType,"upper")                 = q59_soilcarbon_cropland.up(j,stockType);
 oq59_soilcarbon_regular(t,j,regularland59,stockType,"upper")    = q59_soilcarbon_regular.up(j,regularland59,stockType);
 oq59_soilcarbon_other(t,j,stockType,"upper")                    = q59_soilcarbon_other.up(j,stockType);
 ov_nr_som(t,j,"lower")                                          = vm_nr_som.lo(j);
 ov_nr_som_fertilizer(t,j,"lower")                               = vm_nr_som_fertilizer.lo(j);
 oq59_soilcarbon_cropland(t,j,stockType,"lower")                 = q59_soilcarbon_cropland.lo(j,stockType);
 oq59_soilcarbon_regular(t,j,regularland59,stockType,"lower")    = q59_soilcarbon_regular.lo(j,regularland59,stockType);
 oq59_soilcarbon_other(t,j,stockType,"lower")                    = q59_soilcarbon_other.lo(j,stockType);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################

