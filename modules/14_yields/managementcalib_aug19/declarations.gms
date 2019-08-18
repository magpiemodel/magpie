*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

parameters
 i14_yields(t,j,kve,w)           Biophysical input yields (excluding technological change) (tDM per ha per yr)
 p14_pyield_LPJ_reg(t_all,i)     Regional average input yields aggregated from clusters with initial pasture area as weights (tDM per ha per yr)
 p14_pyield_corr(t,i)            Regional pasture management correction for historical time steps (1)
 p14_croparea_total(t,j)         Cellular water type specific cropareas (mio. ha)
 p14_lpj_yields(t,i,kcr)         Biophysical input yields average over region and water supply type (tDM per ha per yr)
 p14_lpj_yields_past(t,i,kcr)    Biophysical input yields average over region and water supply type at the past reference year (tDM per ha per yr)
 p14_delta_yields(t,i,kcr)       Gap between FAO and biophysical yields on regional level (tDM per ha per yr)
 p14_lambda_yields(t,i,kcr)      Scaling factor for non-linear management calibration (1)
 p14_ccratio_yields(t,i,kcr)     Ratio of yield from the current year and yield from the past reference year (1)
 p14_managementcalib(t,i,kcr)    Regional management calibration factor accounting for FAO yield levels (1)
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
