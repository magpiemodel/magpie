*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

parameters
 i14_yields_calib(t,j,kve,w)                             Calibrated biophysical input yields without growing period adaptation excluding technological change (tDM per ha per yr)
 i14_yields_combined(t_all,j,yldtype,kcr,w)              Combined biophysical yields for gsadapt and constgsadapt before calibration (tDM per ha per yr)
 i14_yields_calib_combined(t,j,yldtype,kcr,w)            Combined parameter with gsadapt and constgsadapt yields (tDM per ha per yr)
 p14_yields_gsadapt_ratio(t,i)                           Ratio between regional aggregated gsadapt and constgsadapt yields (1)
 p14_yields_gsadapt_ratio_previous(t,i)                  Ratio between regional aggregated gsadapt and constgsadapt yields for the previous time-step (1)
 pm_yields_gsadapt_ratio_increment(t,i)                  Incremental change of growing period adaption from this time step (1)
 p14_yields_gsadapt_ratio_cumulative(t,i)                Cumulative effect of growing period adaption from the first to the current timestep (1)
 p14_pyield_LPJ_reg(t_all,i)                             Regional average input yields aggregated from clusters with initial pasture area as weights (tDM per ha per yr)
 p14_pyield_corr(t,i)                                    Regional pasture management correction for historical time steps (1)
 i14_croparea_total(t_all,w,j)                           Cellular croparea (mio. ha)
 i14_modeled_yields_hist(t_all,i,yldtype,kcr)            Biophysical input yields average over region and water supply type at the historical reference year (tDM per ha per yr)
 i14_calib_target_yields_hist(t,i,kcr)                   Calibration target yields per region at the historical reference year (tDM per ha per yr)
 i14_lambda_yields(t,i,yldtype,kcr)                      Scaling factor for non-linear management calibration (1)
 i14_managementcalib(t,j,yldtype,kcr,w)                  Regional management calibration factor accounting for FAO yield levels (1)
 im_growing_stock(t,j,ac,land_timber)                    Harvestable stem biomass per ha by age class (tDM per ha)
 im_growing_stock_ysf(t,j,ac)                            Harvestable stem biomass per ha by age class for young secondary forest on other land (tDM per ha)
 pm_yields_semi_calib(j,kve,w)                           Potential yields calibrated to FAO regional levels (tDM per ha per yr)
 i14_calib_yields_hist(i,yldtype,w)                      Calibrated yields average over region and crop type at the historical reference year (tDM per ha per yr)
 i14_calib_yields_ratio(i,yldtype)                       Irrigated to rainfed yield ratio for calibrated yields (1)
 i14_target_ratio(i,yldtype)                             Target irrigated to rainfed ratio as upper bound (1)
 i14_modeled_yields_hist2(i,yldtype,knbe14)              Calibrated yields average over region and water supply type at the historical reference year (tDM per ha per yr)
 i14_yld_past_switch_eff(t_all,i)                        Effective pasture spillover parameter (1)
 ;

positive variables
 vm_yld(j,kve,w)                     Yields declared as variable because of technological change (tDM per ha per yr)
;

equations
 q14_yield_crop(j,kcr,w)             Crop yields (tDM per ha per yr)
 q14_yield_past(j,w)                 Pasture yields (tDM per ha per yr)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_yld(t,j,kve,w,type)          Yields declared as variable because of technological change (tDM per ha per yr)
 oq14_yield_crop(t,j,kcr,w,type) Crop yields (tDM per ha per yr)
 oq14_yield_past(t,j,w,type)     Pasture yields (tDM per ha per yr)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
