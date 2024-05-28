*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

parameters
 i14_yields_calib(t,j,kve,w)                             Calibrated biophysical input yields (excluding technological change) (tDM per ha per yr)
 p14_pyield_LPJ_reg(t_all,i)                             Regional average input yields aggregated from clusters with initial pasture area as weights (tDM per ha per yr)
 p14_pyield_corr(t,i)                                    Regional pasture management correction for historical time steps (1)
 i14_croparea_total(t_all,w,j)                           Cellular croparea (mio. ha)
 i14_modeled_yields_hist(t_all,i,kcr)                    Biophysical input yields average over region and water supply type at the historical reference year (tDM per ha per yr)
 i14_fao_yields_hist(t,i,kcr)                            FAO yields per region at the historical referende year (tDM per ha per yr)
 i14_lambda_yields(t,i,kcr)                              Scaling factor for non-linear management calibration (1)
 i14_managementcalib(t,j,kcr,w)                          Regional management calibration factor accounting for FAO yield levels (1)
 pm_timber_yield(t,j,ac,land_timber)                     Forest growing stock (tDM per ha per yr)
 pm_yields_semi_calib(j,kve,w)                           Potential yields calibrated to FAO regional levels (tDM per ha per yr)
 i14_calib_yields_hist(i,w)                              Calibrated yields average over region and crop type at the historical reference year (tDM per ha per yr)
 i14_calib_yields_ratio(i)                               Irrigated to rainfed yield ratio for calibrated yields (1)
 i14_target_ratio(i)                                     Target irrigated to rainfed ratio as upper bound (1)
 i14_modeled_yields_hist2(i,knbe14)                      Calibrated yields average over region and water supply type at the historical reference year (tDM per ha per yr)
 ;

positive variables
 vm_yld(j,kve,w)                     Yields (variable because of technical change) (tDM per ha per yr)
;

equations
 q14_yield_crop(j,kcr,w)             Crop yields (tDM per ha per yr)
 q14_yield_past(j,w)                 Pasture yields (tDM per ha per yr)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_yld(t,j,kve,w,type)          Yields (variable because of technical change) (tDM per ha per yr)
 oq14_yield_crop(t,j,kcr,w,type) Crop yields (tDM per ha per yr)
 oq14_yield_past(t,j,w,type)     Pasture yields (tDM per ha per yr)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
