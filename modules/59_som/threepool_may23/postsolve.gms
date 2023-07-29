*** |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

p59_topsoilc_actualstate(i, land, soilPools59) = v59_topsoilc_actualstate.l(i, land, soilPools59);
p59_topsoilc_density(t, i, land, soilPools59)$(sum(cell(i,j), pcm_land(j,land)) > 1e-20) = 
  p59_topsoilc_actualstate(i, land, soilPools59) / sum(cell(i,j), pcm_land(j,land));
p59_land_before(j,land) = vm_land.l(j,land);

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov59_topsoilc_crop_steadystate(t,i,tillage59,w,soilPools59,"marginal")        = v59_topsoilc_crop_steadystate.m(i,tillage59,w,soilPools59);
 ov59_topsoilc_noncrop_steadystate(t,i,noncropland59,soilPools59,"marginal")   = v59_topsoilc_noncrop_steadystate.m(i,noncropland59,soilPools59);
 ov59_topsoilc_crop_previousstate(t,i,tillage59,w,soilPools59,"marginal")      = v59_topsoilc_crop_previousstate.m(i,tillage59,w,soilPools59);
 ov59_cropland_transitions(t,i,tillage59,w,noncropland59,"marginal")           = v59_cropland_transitions.m(i,tillage59,w,noncropland59);
 ov59_topsoilc_noncrop_previousstate(t,i,noncropland59,soilPools59,"marginal") = v59_topsoilc_noncrop_previousstate.m(i,noncropland59,soilPools59);
 ov59_topsoilc_actualstate(t,i,land,soilPools59,"marginal")                    = v59_topsoilc_actualstate.m(i,land,soilPools59);
 ov_nr_som(t,i,"marginal")                                                     = vm_nr_som.m(i);
 ov_nr_som_fertilizer(t,i,"marginal")                                          = vm_nr_som_fertilizer.m(i);
 oq59_steadystate_term_crop(t,i,tillage59,w,soilPools59,"marginal")            = q59_steadystate_term_crop.m(i,tillage59,w,soilPools59);
 oq59_previousstate_term_crop(t,i,tillage59,w,soilPools59,"marginal")          = q59_previousstate_term_crop.m(i,tillage59,w,soilPools59);
 oq59_lutransitions_to_cropareas(t,i,noncropland59,"marginal")                 = q59_lutransitions_to_cropareas.m(i,noncropland59);
 oq59_actualstate_crop(t,i,soilPools59,"marginal")                             = q59_actualstate_crop.m(i,soilPools59);
 oq59_steadystate_term_noncrop(t,i,noncropland59,soilPools59,"marginal")       = q59_steadystate_term_noncrop.m(i,noncropland59,soilPools59);
 oq59_previousstate_term_noncrop(t,i,noncropland59,soilPools59,"marginal")     = q59_previousstate_term_noncrop.m(i,noncropland59,soilPools59);
 oq59_actualstate_noncrop(t,i,noncropland59,soilPools59,"marginal")            = q59_actualstate_noncrop.m(i,noncropland59,soilPools59);
 oq59_carbon_soil(t,i,land,stockType,"marginal")                               = q59_carbon_soil.m(i,land,stockType);
 oq59_nr_som(t,i,"marginal")                                                   = q59_nr_som.m(i);
 oq59_nr_som_fertilizer2(t,i,"marginal")                                       = q59_nr_som_fertilizer2.m(i);
 oq59_nr_som_fertilizer(t,i,"marginal")                                        = q59_nr_som_fertilizer.m(i);
 ov59_topsoilc_crop_steadystate(t,i,tillage59,w,soilPools59,"level")           = v59_topsoilc_crop_steadystate.l(i,tillage59,w,soilPools59);
 ov59_topsoilc_noncrop_steadystate(t,i,noncropland59,soilPools59,"level")      = v59_topsoilc_noncrop_steadystate.l(i,noncropland59,soilPools59);
 ov59_topsoilc_crop_previousstate(t,i,tillage59,w,soilPools59,"level")         = v59_topsoilc_crop_previousstate.l(i,tillage59,w,soilPools59);
 ov59_cropland_transitions(t,i,tillage59,w,noncropland59,"level")              = v59_cropland_transitions.l(i,tillage59,w,noncropland59);
 ov59_topsoilc_noncrop_previousstate(t,i,noncropland59,soilPools59,"level")    = v59_topsoilc_noncrop_previousstate.l(i,noncropland59,soilPools59);
 ov59_topsoilc_actualstate(t,i,land,soilPools59,"level")                       = v59_topsoilc_actualstate.l(i,land,soilPools59);
 ov_nr_som(t,i,"level")                                                        = vm_nr_som.l(i);
 ov_nr_som_fertilizer(t,i,"level")                                             = vm_nr_som_fertilizer.l(i);
 oq59_steadystate_term_crop(t,i,tillage59,w,soilPools59,"level")               = q59_steadystate_term_crop.l(i,tillage59,w,soilPools59);
 oq59_previousstate_term_crop(t,i,tillage59,w,soilPools59,"level")             = q59_previousstate_term_crop.l(i,tillage59,w,soilPools59);
 oq59_lutransitions_to_cropareas(t,i,noncropland59,"level")                    = q59_lutransitions_to_cropareas.l(i,noncropland59);
 oq59_actualstate_crop(t,i,soilPools59,"level")                                = q59_actualstate_crop.l(i,soilPools59);
 oq59_steadystate_term_noncrop(t,i,noncropland59,soilPools59,"level")          = q59_steadystate_term_noncrop.l(i,noncropland59,soilPools59);
 oq59_previousstate_term_noncrop(t,i,noncropland59,soilPools59,"level")        = q59_previousstate_term_noncrop.l(i,noncropland59,soilPools59);
 oq59_actualstate_noncrop(t,i,noncropland59,soilPools59,"level")               = q59_actualstate_noncrop.l(i,noncropland59,soilPools59);
 oq59_carbon_soil(t,i,land,stockType,"level")                                  = q59_carbon_soil.l(i,land,stockType);
 oq59_nr_som(t,i,"level")                                                      = q59_nr_som.l(i);
 oq59_nr_som_fertilizer2(t,i,"level")                                          = q59_nr_som_fertilizer2.l(i);
 oq59_nr_som_fertilizer(t,i,"level")                                           = q59_nr_som_fertilizer.l(i);
 ov59_topsoilc_crop_steadystate(t,i,tillage59,w,soilPools59,"upper")           = v59_topsoilc_crop_steadystate.up(i,tillage59,w,soilPools59);
 ov59_topsoilc_noncrop_steadystate(t,i,noncropland59,soilPools59,"upper")      = v59_topsoilc_noncrop_steadystate.up(i,noncropland59,soilPools59);
 ov59_topsoilc_crop_previousstate(t,i,tillage59,w,soilPools59,"upper")         = v59_topsoilc_crop_previousstate.up(i,tillage59,w,soilPools59);
 ov59_cropland_transitions(t,i,tillage59,w,noncropland59,"upper")              = v59_cropland_transitions.up(i,tillage59,w,noncropland59);
 ov59_topsoilc_noncrop_previousstate(t,i,noncropland59,soilPools59,"upper")    = v59_topsoilc_noncrop_previousstate.up(i,noncropland59,soilPools59);
 ov59_topsoilc_actualstate(t,i,land,soilPools59,"upper")                       = v59_topsoilc_actualstate.up(i,land,soilPools59);
 ov_nr_som(t,i,"upper")                                                        = vm_nr_som.up(i);
 ov_nr_som_fertilizer(t,i,"upper")                                             = vm_nr_som_fertilizer.up(i);
 oq59_steadystate_term_crop(t,i,tillage59,w,soilPools59,"upper")               = q59_steadystate_term_crop.up(i,tillage59,w,soilPools59);
 oq59_previousstate_term_crop(t,i,tillage59,w,soilPools59,"upper")             = q59_previousstate_term_crop.up(i,tillage59,w,soilPools59);
 oq59_lutransitions_to_cropareas(t,i,noncropland59,"upper")                    = q59_lutransitions_to_cropareas.up(i,noncropland59);
 oq59_actualstate_crop(t,i,soilPools59,"upper")                                = q59_actualstate_crop.up(i,soilPools59);
 oq59_steadystate_term_noncrop(t,i,noncropland59,soilPools59,"upper")          = q59_steadystate_term_noncrop.up(i,noncropland59,soilPools59);
 oq59_previousstate_term_noncrop(t,i,noncropland59,soilPools59,"upper")        = q59_previousstate_term_noncrop.up(i,noncropland59,soilPools59);
 oq59_actualstate_noncrop(t,i,noncropland59,soilPools59,"upper")               = q59_actualstate_noncrop.up(i,noncropland59,soilPools59);
 oq59_carbon_soil(t,i,land,stockType,"upper")                                  = q59_carbon_soil.up(i,land,stockType);
 oq59_nr_som(t,i,"upper")                                                      = q59_nr_som.up(i);
 oq59_nr_som_fertilizer2(t,i,"upper")                                          = q59_nr_som_fertilizer2.up(i);
 oq59_nr_som_fertilizer(t,i,"upper")                                           = q59_nr_som_fertilizer.up(i);
 ov59_topsoilc_crop_steadystate(t,i,tillage59,w,soilPools59,"lower")           = v59_topsoilc_crop_steadystate.lo(i,tillage59,w,soilPools59);
 ov59_topsoilc_noncrop_steadystate(t,i,noncropland59,soilPools59,"lower")      = v59_topsoilc_noncrop_steadystate.lo(i,noncropland59,soilPools59);
 ov59_topsoilc_crop_previousstate(t,i,tillage59,w,soilPools59,"lower")         = v59_topsoilc_crop_previousstate.lo(i,tillage59,w,soilPools59);
 ov59_cropland_transitions(t,i,tillage59,w,noncropland59,"lower")              = v59_cropland_transitions.lo(i,tillage59,w,noncropland59);
 ov59_topsoilc_noncrop_previousstate(t,i,noncropland59,soilPools59,"lower")    = v59_topsoilc_noncrop_previousstate.lo(i,noncropland59,soilPools59);
 ov59_topsoilc_actualstate(t,i,land,soilPools59,"lower")                       = v59_topsoilc_actualstate.lo(i,land,soilPools59);
 ov_nr_som(t,i,"lower")                                                        = vm_nr_som.lo(i);
 ov_nr_som_fertilizer(t,i,"lower")                                             = vm_nr_som_fertilizer.lo(i);
 oq59_steadystate_term_crop(t,i,tillage59,w,soilPools59,"lower")               = q59_steadystate_term_crop.lo(i,tillage59,w,soilPools59);
 oq59_previousstate_term_crop(t,i,tillage59,w,soilPools59,"lower")             = q59_previousstate_term_crop.lo(i,tillage59,w,soilPools59);
 oq59_lutransitions_to_cropareas(t,i,noncropland59,"lower")                    = q59_lutransitions_to_cropareas.lo(i,noncropland59);
 oq59_actualstate_crop(t,i,soilPools59,"lower")                                = q59_actualstate_crop.lo(i,soilPools59);
 oq59_steadystate_term_noncrop(t,i,noncropland59,soilPools59,"lower")          = q59_steadystate_term_noncrop.lo(i,noncropland59,soilPools59);
 oq59_previousstate_term_noncrop(t,i,noncropland59,soilPools59,"lower")        = q59_previousstate_term_noncrop.lo(i,noncropland59,soilPools59);
 oq59_actualstate_noncrop(t,i,noncropland59,soilPools59,"lower")               = q59_actualstate_noncrop.lo(i,noncropland59,soilPools59);
 oq59_carbon_soil(t,i,land,stockType,"lower")                                  = q59_carbon_soil.lo(i,land,stockType);
 oq59_nr_som(t,i,"lower")                                                      = q59_nr_som.lo(i);
 oq59_nr_som_fertilizer2(t,i,"lower")                                          = q59_nr_som_fertilizer2.lo(i);
 oq59_nr_som_fertilizer(t,i,"lower")                                           = q59_nr_som_fertilizer.lo(i);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
