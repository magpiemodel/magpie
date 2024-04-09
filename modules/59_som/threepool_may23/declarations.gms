*** |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

parameters
          i59_cinput_multiplier_residue(i, sPools59, kcr)                 Carbon input to soil pool input multipliers (1)
          i59_topsoilc_decay_max1(t, i, sPools59, w, tillage59)           Soil decay rates for all SOC sub-pools per year cut at 1 (1)
          p59_topsoilc_density_pre(t_all, i, land, sPools59)              Soil carbon density of the upper layer per hectare before solve (tC per ha)
          p59_topsoilc_density_post(t_all, i, land, sPools59)             Soil carbon density of the upper layer per hectare after solve (tC per ha)
          p59_topsoilc_actualstate(i, land, sPools59)                     Actual soil carbon stock per land type (mio. tC)
          i59_subsoilc_density(t_all,j)                                   Subsoil carbon density of per hectare (tC per ha)
          p59_land_before(j,land)                                         Land area in previous time step (mio. ha)
;

equations
         q59_steadystate_term_crop(i, sPools59, w, tillage59)                    Steady-state for SOC stock on cropland (mio. tC)
         q59_previousstate_term_crop(i, sPools59, w, tillage59)               bla
         q59_lutransitions_to_cropareas(i, noncropland59)                    bla
         q59_actualstate_crop(i, sPools59)                                   bla
         q59_steadystate_term_noncrop(i, noncropland59, sPools59)            bla
         q59_previousstate_term_noncrop(i, noncropland59, sPools59)             Steady-state for SOC on various non-cropland types (mio. tC)
         q59_actualstate_noncrop(i, noncropland59, sPools59)                 bla
         q59_carbon_soil(i, land, stockType)                                 bla
         q59_nr_som(i)                                                          bla
         q59_nr_som_fertilizer2(i)                                              bla
         q59_nr_som_fertilizer(i)                                               bla
;

positive variables
         v59_topsoilc_crop_steadystate(i, sPools59, w, tillage59)             bla
         v59_topsoilc_noncrop_steadystate(i, noncropland59, sPools59)        bla
         v59_topsoilc_crop_previousstate(i, sPools59, w, tillage59)           bla
         v59_cropland_transitions(i, tillage59, w, noncropland59)            bla
         v59_topsoilc_noncrop_previousstate(i, noncropland59, sPools59)      bla
         v59_topsoilc_actualstate(i, land, sPools59)                         bla
;

variables
         vm_nr_som(i)                                       Release of soil organic matter (Mt N per yr)
         vm_nr_som_fertilizer(i)                            Uptake of soil organic matter from plants (Mt N per yr)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov59_topsoilc_crop_steadystate(t,i,sPools59,w,tillage59,type)        bla
 ov59_topsoilc_noncrop_steadystate(t,i,noncropland59,sPools59,type)   bla
 ov59_topsoilc_crop_previousstate(t,i,sPools59,w,tillage59,type)      bla
 ov59_cropland_transitions(t,i,tillage59,w,noncropland59,type)        bla
 ov59_topsoilc_noncrop_previousstate(t,i,noncropland59,sPools59,type) bla
 ov59_topsoilc_actualstate(t,i,land,sPools59,type)                    bla
 ov_nr_som(t,i,type)                                                  Release of soil organic matter (Mt N per yr)
 ov_nr_som_fertilizer(t,i,type)                                       Uptake of soil organic matter from plants (Mt N per yr)
 oq59_steadystate_term_crop(t,i,sPools59,w,tillage59,type)            Steady-state for SOC stock on cropland (mio. tC)
 oq59_previousstate_term_crop(t,i,sPools59,w,tillage59,type)          bla
 oq59_lutransitions_to_cropareas(t,i,noncropland59,type)              bla
 oq59_actualstate_crop(t,i,sPools59,type)                             bla
 oq59_steadystate_term_noncrop(t,i,noncropland59,sPools59,type)       bla
 oq59_previousstate_term_noncrop(t,i,noncropland59,sPools59,type)     Steady-state for SOC on various non-cropland types (mio. tC)
 oq59_actualstate_noncrop(t,i,noncropland59,sPools59,type)            bla
 oq59_carbon_soil(t,i,land,stockType,type)                            bla
 oq59_nr_som(t,i,type)                                                bla
 oq59_nr_som_fertilizer2(t,i,type)                                    bla
 oq59_nr_som_fertilizer(t,i,type)                                     bla
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
