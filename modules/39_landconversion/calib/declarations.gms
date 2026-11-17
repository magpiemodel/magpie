*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

equations
 q39_cost_landcon(j,land)         Calculation of cellular landconversion costs (mio. USD17MER per yr)
;

variables
 vm_cost_landcon(j,land)            Costs for land expansion and reduction (mio. USD17MER per yr)
;

parameters
 i39_cost_establish(t,i,land)   Land expansion costs (USD17MER per hectare)
 i39_reward_reduction(t,i,land)   Reward for land reduction (USD17MER per hectare)
 i39_calib(t,i,type39)        Calibration factor for costs of cropland expansion and rewards for cropland reduction (1)
 i39_calib_past(t,i,type39)   Calibration factor for costs of pasture expansion and rewards for pasture reduction (1)
 i39_calib_hist_end(i,type39)        Cropland calibration factor in the last historical year (1)
 i39_calib_hist_end_past(i,type39)   Pasture calibration factor in the last historical year (1)
 i39_calib_fader(t_all)        Share of the convergence of cropland calibration factors towards their neutral value (1)
 i39_calib_fader_past(t_all)   Share of the convergence of pasture calibration factors towards their neutral value (1)
;

scalars
 s39_hist_end_year   Last historical year with calibration factors (year)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_cost_landcon(t,j,land,type)   Costs for land expansion and reduction (mio. USD17MER per yr)
 oq39_cost_landcon(t,j,land,type) Calculation of cellular landconversion costs (mio. USD17MER per yr)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
