*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

***YIELD CORRECTION FOR PASTURE ACCOUNTING FOR REGIONAL DIFFERENCES IN MANAGEMENT***
p14_pyield_LPJ_reg(t,i) = (sum(cell(i,j), f14_yields(t,j,"pasture","rainfed") * pm_land_start(j,"past")) /
                            sum(cell(i,j), pm_land_start(j,"past")) );

*' Pasture yield correction: use historical data for all years where available
*' (f14_pyld_hist covers y1965–y2020), freeze at the last available value beyond.
*' This avoids a discontinuity at the t_past boundary by using observed data
*' through y2020 instead of freezing at the last t_past year (y2015).
p14_pyield_corr(t,i) = 0;
p14_pyield_corr(t,i)$(f14_pyld_hist(t,i) > 0) = f14_pyld_hist(t,i) / (p14_pyield_LPJ_reg(t,i) + 0.000001);
loop(t,
  p14_pyield_corr(t,i)$(p14_pyield_corr(t,i) = 0) = p14_pyield_corr(t-1,i);
);

i14_yields_calib(t,j,"pasture",w) = f14_yields(t,j,"pasture",w) * sum(cell(i,j),p14_pyield_corr(t,i));


***YIELD MANAGEMENT CALIBRATION************************************************************


*' @code

*' The following equations calibrate the cellular yield patterns (`f14_yields`) to match
*' historical reference yields (`i14_calib_target_yields_hist`) by calculating a calibration term called
*' 'i14_managementcalib'. For most cases, 'i14_managementcalib' is the ratio of the historical
*' yields reported by FAO for croplands (`f14_fao_yields_hist`) and regional mean yields (`i14_modeled_yields_hist`)
*' given historic crop area patterns ('fm_croparea') and cellular yields coming from crop models
*' like LPJmL (`f14_yields`). In these cases, 'i14_managementcalib' represents a purely relative
*' calibration factor that depends only on the initial conditions of the starting year.
*'
*' However, when FAO yields are significantly higher than given by the cellular yield inputs
*' (underestimated baseline), the relative calibration terms can lead to unrealistically large
*' yields in the case of future yield increases within the cellular yield patterns.
*'
*' To address this issue, the factor `i14_lambda_yields` determines the degree
*' to which the baseline (FAO) is under- or overestimated and therefore controls
*' whether the calibration factor is applied as an absolute or relative change.
*' For overestimated FAO yields, `i14_lambda_yields` is 1, which is equivalent
*' to an entirely relative calibration. For underestimated yields, `i14_lambda_yields`
*' is calculated as the squared root of the ratio between LPJmL yields and FAO historical
*' yields, and as `i14_lambda_yields`  approaches 0, it reduces the applied relative change
*' resulting in a mean change increasingly similar to an additive term (@Heinke.2013).

*' This concept is referred to as limited calibration, as it limits the calibration
*' to an additive term in case of a strongly underestimated baseline. The scalar
*' `s14_limit_calib` can be used to switch limited calibration on (1) and off (0).

*' To account for growing period adaption to climate change, two types of yields
*' (one with adaption of growing periods and varieties to changes in climatic conditions (gsadapt)
*' and one with no changes in growing periods and varieties in the future (constgsadapt))
*' have to be calibrated.
*' The joint parameter `i14_yields_combined(t,j,yldtype,kcr,w)` is used to calibrate
*' both types individually as even though the growing seasons are held constant from 1995
*' onwards, the yields already differ in 1995 due to long term averaging.

*** INITIALIZATION of crop yield parameters

i14_yields_combined(t,j,"constgsadapt",kcr,w) = f14_yields_constgsadapt(t,j,kcr,w);
i14_yields_combined(t,j,"gsadapt",kcr,w)   = f14_yields(t,j,kcr,w);

i14_croparea_total(t_all,w,j) = sum(kcr, fm_croparea(t_all,j,w,kcr));

**************************************************************************************
*** STEP 1: CALCULATE modeled regional historical yields

*' Historic crop area patterns (`fm_croprea`) are used to calculate regional yields
*' (`i14_modeled_yields_hist`) from the given cellular input pattern. In rare cases where
*' a region has no crop area reported for a given crop type, the total crop area is
*' used to calculate a proxy yield for the calibration, given by the following equation:

i14_modeled_yields_hist(t_past,i,yldtype,knbe14)
   = (sum((cell(i,j),w), fm_croparea(t_past,j,w,knbe14) * i14_yields_combined(t_past,j,yldtype,knbe14,w)) /
      sum((cell(i,j),w), fm_croparea(t_past,j,w,knbe14)))$(sum((cell(i,j),w), fm_croparea(t_past,j,w,knbe14)) > 0.00001 AND
                                                           sum((cell(i,j),w), fm_croparea(t_past,j,w,knbe14) * i14_yields_combined(t_past,j,yldtype,knbe14,w)) > 0.00001)
   + (sum((cell(i,j),w), i14_croparea_total(t_past,w,j) * i14_yields_combined(t_past,j,yldtype,knbe14,w)) /
      sum((cell(i,j),w), i14_croparea_total(t_past,w,j)))$(sum((cell(i,j),w), fm_croparea(t_past,j,w,knbe14)) <= 0.00001 OR
                                                           sum((cell(i,j),w), fm_croparea(t_past,j,w,knbe14) * i14_yields_combined(t_past,j,yldtype,knbe14,w)) <= 0.00001);

i14_modeled_yields_hist(t_past,i,yldtype,kbe14)
   = sum((cell(i,j),w), i14_croparea_total(t_past,w,j) * i14_yields_combined("y1995",j,yldtype,kbe14,w)) /
     sum((cell(i,j),w), i14_croparea_total(t_past,w,j));

**************************************************************************************
*** STEP 2: SET CALIB TARGET with FAO for knbe14 and modeled yields for kbe14

*' Use FAO data as calibration data for all crop types except bioenergy crops:
i14_calib_target_yields_hist(t,i,knbe14) = f14_fao_yields_hist(t,i,knbe14);

*' For bioenergy crops, no meaningful calibration target is currently available. The calibration target
*' is set to the regional modeled yield, which results in a calibration factor of 1 and effectively
*' performs no calibration. This is a placeholder implementation that can be replaced with actual
*' calibration data when it becomes available.
i14_calib_target_yields_hist(t,i,kbe14) = i14_modeled_yields_hist("y1995",i,"gsadapt",kbe14);
if (s14_use_gsadapt = 0,
    i14_calib_target_yields_hist(t,i,kbe14) = i14_modeled_yields_hist("y1995",i,"constgsadapt",kbe14);
);

**************************************************************************************
*** STEP 3: LOOP OVER TIME calculating calibration parameters for all time steps

*' The factor `i14_lambda_yields` is calculated for the initial time step depending
*' on the setting `s14_limit_calib` and is then held constant for all other time steps.
*' The regional calibration target yield and regional yield of the crop model input of
*' the initial time step is kept constant in the two parameters `i14_calib_target_yields_hist`
*' and `i14_modeled_yields_hist`:

loop(t,
     if (sum(sameas(t,"y1995"),1) = 1,

          if ((s14_limit_calib = 0),
               i14_lambda_yields(t,i,yldtype,kcr) = 1;

          Elseif (s14_limit_calib = 1 ),
               i14_lambda_yields(t,i,yldtype,kcr) =
                    1$(i14_calib_target_yields_hist(t,i,kcr) <= i14_modeled_yields_hist(t,i,yldtype,kcr))
                    + sqrt(i14_modeled_yields_hist(t,i,yldtype,kcr)/i14_calib_target_yields_hist(t,i,kcr))$
                    (i14_calib_target_yields_hist(t,i,kcr) > i14_modeled_yields_hist(t,i,yldtype,kcr));
          );

     Else
          i14_modeled_yields_hist(t,i,yldtype,kcr) = i14_modeled_yields_hist(t-1,i,yldtype,kcr);
          i14_calib_target_yields_hist(t,i,kcr)    = i14_calib_target_yields_hist(t-1,i,kcr);
          i14_lambda_yields(t,i,yldtype,kcr)       = i14_lambda_yields(t-1,i,yldtype,kcr);
     );
);

**************************************************************************************
*** STEP 4: APPLY calculated calibration factors for all time steps

*' The calibrated cellular yield `i14_yields_calib_combined` is calculated for each time step depending
*' on the constant values `i14_modeled_yields_hist`, `i14_calib_target_yields_hist`, `i14_lambda_yields`
*' and the uncalibrated, cellular yield `f14_yields` following the idea of eq. (9) in [@Heinke.2013]:

i14_managementcalib(t,j,yldtype,kcr,w) =
   1 + (sum(cell(i,j), i14_calib_target_yields_hist(t,i,kcr) - i14_modeled_yields_hist(t,i,yldtype,kcr)) /
                            i14_yields_combined(t,j,yldtype,kcr,w) *
      (i14_yields_combined(t,j,yldtype,kcr,w) / (sum(cell(i,j),i14_modeled_yields_hist(t,i,yldtype,kcr))+10**(-8))) **
                            sum(cell(i,j),i14_lambda_yields(t,i,yldtype,kcr)))$(i14_yields_combined(t,j,yldtype,kcr,w)>0);



i14_yields_calib_combined(t,j,yldtype,kcr,w) = i14_managementcalib(t,j,yldtype,kcr,w) * i14_yields_combined(t,j,yldtype,kcr,w);

*' Note that the calculation is split into two parts for better readability.

**************************************************************************************
*' Irrigated yields are calibrated to meet the country-level
*' ratio between irrigated and rainfed yields reported by Aquastat.
*' This can be de-activated with the switch `s14_calib_ir2rf`.
*' This calibration in only done for knbe14 (all crops excluding bioenergy crops)
if ((s14_calib_ir2rf = 1),

* Weighted yields
  i14_calib_yields_hist(i,yldtype,w)
    = sum((cell(i,j), knbe14), fm_croparea("y1995",j,"irrigated",knbe14) * i14_yields_calib_combined("y1995",j,yldtype,knbe14,w)) /
      sum((cell(i,j), knbe14), fm_croparea("y1995",j,"irrigated",knbe14));

* Use irrigated-rainfed ratio of Aquastat if larger than our calculated ratio
  i14_calib_yields_ratio(i,yldtype) = i14_calib_yields_hist(i,yldtype,"irrigated") / i14_calib_yields_hist(i,yldtype,"rainfed");
  i14_target_ratio(i,yldtype) = max(i14_calib_yields_ratio(i,yldtype), f14_ir2rf_ratio(i));
  i14_yields_calib_combined(t,j,yldtype,knbe14,"irrigated") = sum((cell(i,j)), i14_target_ratio(i,yldtype) / i14_calib_yields_ratio(i,yldtype)) *
                                              i14_yields_calib_combined(t,j,yldtype,knbe14,"irrigated");

* Calibrate newly calibrated yields to calib target yields
  i14_modeled_yields_hist2(i,yldtype,knbe14)
  = (sum((cell(i,j),w), fm_croparea("y1995",j,w,knbe14) * i14_yields_calib_combined("y1995",j,yldtype,knbe14,w)) /
      sum((cell(i,j),w), fm_croparea("y1995",j,w,knbe14)))$(sum((cell(i,j),w), fm_croparea("y1995",j,w,knbe14)) > 0.00001 AND
                                                            sum((cell(i,j),w), fm_croparea("y1995",j,w,knbe14) * i14_yields_calib_combined("y1995",j,yldtype,knbe14,w)) > 0.00001)
   + (sum((cell(i,j),w), i14_croparea_total("y1995",w,j) * i14_yields_calib_combined("y1995",j,yldtype,knbe14,w)) /
      sum((cell(i,j),w), i14_croparea_total("y1995",w,j)))$(sum((cell(i,j),w), fm_croparea("y1995",j,w,knbe14)) <= 0.00001 OR
                                                                 sum((cell(i,j),w), fm_croparea("y1995",j,w,knbe14) * i14_yields_calib_combined("y1995",j,yldtype,knbe14,w)) <= 0.00001);


  i14_yields_calib_combined(t,j,yldtype,knbe14,w) = sum((cell(i,j)), i14_calib_target_yields_hist("y1995",i,knbe14) /
                                                      i14_modeled_yields_hist2(i,yldtype,knbe14)) *
                                  i14_yields_calib_combined(t,j,yldtype,knbe14,w);
);

***MANAGEMENT CALIBRATION FOR 2ND GENERATION BIOENERGY CROPS (tau scaling)****************
*' Tau-based management calibration applied on top of the biophysical yields.
i14_yields_calib_combined(t,j,yldtype,kbe14,w) = i14_yields_calib_combined(t,j,yldtype,kbe14,w) *
                                                    sum((supreg(h,i),cell(i,j)),fm_tau1995(h))/smax(h,fm_tau1995(h));
*******************************************************************************************

* Set yields to gsadapt values (pasture yields are not affected by growing period adaption)

if (s14_use_gsadapt = 1,
    pm_yields_semi_calib(j,knbe14,w) = i14_yields_calib_combined("y1995",j,"gsadapt",knbe14,w);
    i14_yields_calib(t,j,kcr,w) = i14_yields_calib_combined(t,j,"gsadapt",kcr,w);
  else
    pm_yields_semi_calib(j,knbe14,w) = i14_yields_calib_combined("y1995",j,"constgsadapt",knbe14,w);
    i14_yields_calib(t,j,kcr,w) = i14_yields_calib_combined(t,j,"constgsadapt",kcr,w);
);

*' @stop


***YIELD CALIBRATION***********************************************************************

*' @code
*' Calibrated yields can additionally be adjusted by calibration factors 'f14_yld_calib'
*' determined in a calibration run. As MAgPIE optimizes yield patterns and FAO regional
*' yields are outlier corrected, historical production and croparea can in some cases
*' be better represented with this additional correction:

* set yield calib factors to 1 in case of no use of yield calibration factors (s14_use_yield_calib = 0)
* or missing input file
if (s14_use_yield_calib = 0 OR sum((i,ltype14),f14_yld_calib(i,ltype14)) = 0,
  f14_yld_calib(i,ltype14) = 1;
);


i14_yields_calib(t,j,kcr,w)       = i14_yields_calib(t,j,kcr,w)
                                    * sum(cell(i,j),f14_yld_calib(i,"crop"));
i14_yields_calib(t,j,"pasture",w) = i14_yields_calib(t,j,"pasture",w)
                                    * sum(cell(i,j),f14_yld_calib(i,"past"));

* Set effective pasture spillover parameter to regional dynamic value
    i14_yld_past_switch_eff(t,i) = f14_yld_past_switch(t,i);

* If static spillover mode, override with scalar value
if (s14_past_spillover_mode = 0,
  i14_yld_past_switch_eff(t,i) = s14_yld_past_switch;
);

*' @stop

*' @code
*' Land degradation can negatively affect yields. Soil loss for example can
*' notably affect land productivity. Similarly, the yield of pollinator-dependent crops
*' is reduced when there is a lack of pollinators. To account for the impacts of degradation,
*' calibrated yields are multiplied by the share of land with intact NCP in each cell and specific
*' yield reduction coefficients that represent yield loss due to soil erosion and pollination
*' deficiency on non-intact land.

* set default values in case of missing input file.
if (sum((t,j,ncp_type14),f14_yld_ncp_report(t,j,ncp_type14)) = 0,
  f14_yld_ncp_report(t,j,ncp_type14) = 1;
);

if ((s14_degradation = 1),
  i14_yields_calib(t,j,kcr,w) = i14_yields_calib(t,j,kcr,w) * (1 - s14_yld_reduction_soil_loss)
                                + i14_yields_calib(t,j,kcr,w) * s14_yld_reduction_soil_loss * f14_yld_ncp_report(t,j,"soil_intact");
  i14_yields_calib(t,j,kcr,w) = i14_yields_calib(t,j,kcr,w) * (1 - f14_kcr_pollinator_dependence(kcr))
                                + i14_yields_calib(t,j,kcr,w) * f14_kcr_pollinator_dependence(kcr) * f14_yld_ncp_report(t,j,"poll_suff");
);

*' @stop
