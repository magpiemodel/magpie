*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

parameters
 i14_yields_calib(t,j,kve,w)                             Calibrated biophysical input yields WITHOUT growing period adaptation (excluding technological change) (tDM per ha per yr)
 i14_yields_combined(t_all,j,yldtype,kcr,w)              Combined biophysical yields for gsadapt and constgsadapt before calibration (tDM per ha per yr)
 i14_yields_calib_combined(t,j,yldtype,kcr,w)            Combined parameter with gsadapt and constgsadapt yields (tDM per ha per yr)
 p14_yields_gsadapt_ratio(t,i)                           Ratio between regional aggregated gsadapt and nosadapt yields (1)
 p14_yields_gsadapt_ratio_previous(t,i)                  Ratio between regional aggregated gsadapt and nosadapt yields for the previous time-step (1)
 pm_yields_gsadapt_ratio_increment(t,i)                  Incremental change of growing period adaption from this time step (1) 
 p14_yields_gsadapt_ratio_cumulative(t,i)                Cumulative effect of growing period adaption from the first to the current timestep (1)
 p14_pyield_LPJ_reg(t_all,i)                             Regional average input yields aggregated from clusters with initial pasture area as weights (tDM per ha per yr)
 p14_pyield_corr(t,i)                                    Regional pasture management correction for historical time steps (1)
 i14_croparea_total(t_all,w,j)                           Cellular croparea (mio. ha)
 i14_modeled_yields_hist(t_all,i,yldtype,kcr)            Biophysical input yields average over region and water supply type at the historical reference year (tDM per ha per yr)
 i14_fao_yields_hist(t,i,kcr)                            FAO yields per region at the historical referende year (tDM per ha per yr)
 i14_lambda_yields(t,i,yldtype,kcr)                      Scaling factor for non-linear management calibration (1)
 i14_managementcalib(t,j,yldtype,kcr,w)                  Regional management calibration factor accounting for FAO yield levels (1)
 f14_region_be_yields(t_all,i,kbe14)                     Li2020 reference yields for bioenergy crops aggregated to regions (tDM per ha per yr)
 f14_global_be_yields(t_all,kbe14)                        Li2020 reference yields for bioenergy crops aggregated to global level (tDM per ha per yr)
 f14_cluster_be_croparea_weights(t_all,j,kbe14)          Cropland area weights per cluster used for Li2020 bioenergy yield aggregation (mio. ha)
*' TODO: once preprocessing is rerun, this parameter will be timeless (no t_all dimension).
*'       Remove t_all here and update the "y2010" index in preloop.gms accordingly.
 i14_be_LPJ_reg(i,yldtype,kbe14)                         LPJmL regional mean rainfed yields for bioenergy crops at y1995 per yldtype (tDM per ha per yr)
 i14_be_LPJ_glo(yldtype,kbe14)                           LPJmL global mean rainfed yields for bioenergy crops at y1995 per yldtype (tDM per ha per yr)
 i14_be_calib_reg(i,yldtype,kbe14)                       Regional calibration factor for bioenergy crops based on Li2020 per yldtype (1)
 i14_be_calib_glo(yldtype,kbe14)                         Global calibration factor for bioenergy crops based on Li2020 per yldtype (1)
 pm_timber_yield(t,j,ac,land_timber)                     Forest growing stock (tDM per ha per yr)
 pm_yields_semi_calib(j,kve,w)                           Potential yields calibrated to FAO regional levels (tDM per ha per yr)
 i14_calib_yields_hist(i,yldtype,w)                      Calibrated yields average over region and crop type at the historical reference year (tDM per ha per yr)
 i14_calib_yields_ratio(i,yldtype)                       Irrigated to rainfed yield ratio for calibrated yields (1)
 i14_target_ratio(i,yldtype)                             Target irrigated to rainfed ratio as upper bound (1)
 i14_modeled_yields_hist2(i,yldtype,knbe14)              Calibrated yields average over region and water supply type at the historical reference year (tDM per ha per yr)
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
