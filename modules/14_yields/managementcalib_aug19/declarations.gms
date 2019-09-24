*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

parameters
 i14_yields_calib(t,j,kve,w)     Calibrated biophysical input yields (excluding technological change) (tDM per ha per yr)
 p14_pyield_LPJ_reg(t_all,i)     Regional average input yields aggregated from clusters with initial pasture area as weights (tDM per ha per yr)
 p14_pyield_corr(t,i)            Regional pasture management correction for historical time steps (1)
 i14_croparea_total(t,j)         Cellular water type specific cropareas (mio. ha)
 i14_lpj_yields_hist(t,i,kcr)    Biophysical input yields average over region and water supply type at the historical reference year (tDM per ha per yr)
 i14_regions_yields(t,i,kcr)     FAO yields per region (tDM per ha per yr)
 i14_lambda_yields(t,i,kcr)      Scaling factor for non-linear management calibration (1)
 i14_managementcalib(t,j,kcr,w)  Regional management calibration factor accounting for FAO yield levels (1)
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
