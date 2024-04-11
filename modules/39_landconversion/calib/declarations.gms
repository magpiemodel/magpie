*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

equations
 q39_cost_landcon(j,land)         Calculation of cellular landconversion costs (mio. USD05MER per yr)
;

variables
 vm_cost_landcon(j,land)            Costs for land expansion and reduction (mio. USD05MER per yr)
;

parameters
 i39_cost_establish(t,i,land)   Land expansion costs (USD05MER per hectare)
 i39_reward_reduction(t,i,land)   Reward for land reduction (USD05MER per hectare)
 i39_calib(t,i,type39)        Calibration factor for costs of cropland expansion and rewards for cropland reduction (1)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_cost_landcon(t,j,land,type)   Costs for land expansion and reduction (mio. USD05MER per yr)
 oq39_cost_landcon(t,j,land,type) Calculation of cellular landconversion costs (mio. USD05MER per yr)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
