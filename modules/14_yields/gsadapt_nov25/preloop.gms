*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

***YIELD CORRECTION FOR PASTURE ACCOUNTING FOR REGIONAL DIFFERENCES IN MANAGEMENT***
p14_pyield_LPJ_reg(t,i) = (sum(cell(i,j),f14_yields(t,j,"pasture","rainfed") * pm_land_start(j,"past")) /
                            sum(cell(i,j),pm_land_start(j,"past")) );

*' Pasture yield correction: use historical data for all years where available
*' (f14_pyld_hist covers y1965–y2020), freeze at the last available value beyond.
*' This avoids a discontinuity at the t_past boundary by using observed data
*' through y2020 instead of freezing at the last t_past year (y2015).
p14_pyield_corr(t,i)$(f14_pyld_hist(t,i) > 0) = f14_pyld_hist(t,i) / (p14_pyield_LPJ_reg(t,i) + 0.000001);
loop(t,
  p14_pyield_corr(t,i)$(p14_pyield_corr(t,i) = 0) = p14_pyield_corr(t-1,i);
);

i14_yields_calib(t,j,"pasture",w) = i14_yields_calib(t,j,"pasture",w) * sum(cell(i,j),p14_pyield_corr(t,i));


***YIELD MANAGEMENT CALIBRATION************************************************************


*' @code

*' The following equations calibrate the cellular yield patterns (`f14_yields`) to match
*' FAO historical yields (`f14_fao_yields_hist`) by calculating a calibration term called
*' 'i14_managementcalib'. For most cases, 'i14_managementcalib' is the ratio of the historical
*' yields reported by FAO (`f14_fao_yields_hist`) and regional mean yields (`i14_modeled_yields_hist`)
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

*' To be able to assess the impacts of growing period adaption, both type of yields
*' (with and without adapted growing perdiods and varieties) have to be calibrated.
*' The joint parameter `i14_yields_combined(t,j,yldtype,kcr,w)` is used to calibrate
*' both types individually as even so the growing seasons are held constant from 1995
*' onwards, due to long term averaging the yields already differ in 1995.

i14_yields_combined(t,j,"constgsadapt",kcr,w) = f14_yields_constgsadapt(t,j,kcr,w);
i14_yields_combined(t,j,"gsadapt",kcr,w)   = f14_yields(t,j,kcr,w);

i14_croparea_total(t_all,w,j) = sum(kcr, fm_croparea(t_all,j,w,kcr));

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

*' The factor `i14_lambda_yields` is calculated for the initial time step depending
*' on the setting `s14_limit_calib` and is then held constant for all other time steps.
*' The regional FAO yield and regional yield of the crop model input of the initial
*' time step is kept constant in the two parameters `i14_fao_yields_hist` and
*' `i14_modeled_yields_hist`:

loop(t,
     if(sum(sameas(t,"y1995"),1)=1,

          if    ((s14_limit_calib = 0),
               i14_lambda_yields(t,i,yldtype,knbe14) = 1;

          Elseif (s14_limit_calib =1 ),
               i14_lambda_yields(t,i,yldtype,knbe14) =
                    1$(f14_fao_yields_hist(t,i,knbe14) <= i14_modeled_yields_hist(t,i,yldtype,knbe14))
                    + sqrt(i14_modeled_yields_hist(t,i,yldtype,knbe14)/f14_fao_yields_hist(t,i,knbe14))$
                    (f14_fao_yields_hist(t,i,knbe14) > i14_modeled_yields_hist(t,i,yldtype,knbe14));
          );

          i14_fao_yields_hist(t,i,knbe14) = f14_fao_yields_hist(t,i,knbe14);

     Else
          i14_modeled_yields_hist(t,i,yldtype,knbe14) = i14_modeled_yields_hist(t-1,i,yldtype,knbe14);
          i14_fao_yields_hist(t,i,knbe14)  = i14_fao_yields_hist(t-1,i,knbe14);
          i14_lambda_yields(t,i,yldtype,knbe14)   = i14_lambda_yields(t-1,i,yldtype,knbe14);
     );
);

*' The calibrated cellular yield `i14_yields_calib_combined` is calculated for each time step depending
*' on the constant values `i14_modeled_yields_hist`, `i14_fao_yields_hist`, `i14_lambda_yields`
*' and the uncalibrated, cellular yield `f14_yields` following the idea of eq. (9) in [@Heinke.2013]:

i14_managementcalib(t,j,yldtype,knbe14,w) =
   1 + (sum(cell(i,j), i14_fao_yields_hist(t,i,knbe14) - i14_modeled_yields_hist(t,i,yldtype,knbe14)) /
                            i14_yields_combined(t,j,yldtype,knbe14,w) *
      (i14_yields_combined(t,j,yldtype,knbe14,w) / (sum(cell(i,j),i14_modeled_yields_hist(t,i,yldtype,knbe14))+10**(-8))) **
                            sum(cell(i,j),i14_lambda_yields(t,i,yldtype,knbe14)))$(i14_yields_combined(t,j,yldtype,knbe14,w)>0);

i14_yields_calib_combined(t,j,yldtype,knbe14,w) = i14_managementcalib(t,j,yldtype,knbe14,w) * i14_yields_combined(t,j,yldtype,knbe14,w);

*' Note that the calculation is split into two parts for better readability.

*' Irrigated yields are calibrated to meet the country-level
*' ratio between irrigated and rainfed yields reported by Aquastat.
*' This can be de-activated with the switch `s14_calib_ir2rf`.
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

* Calibrate newly calibrated yields to FAO yields
  i14_modeled_yields_hist2(i,yldtype,knbe14)
  = (sum((cell(i,j),w), fm_croparea("y1995",j,w,knbe14) * i14_yields_calib_combined("y1995",j,yldtype,knbe14,w)) /
      sum((cell(i,j),w), fm_croparea("y1995",j,w,knbe14)))$(sum((cell(i,j),w), fm_croparea("y1995",j,w,knbe14)) > 0.00001 AND
                                                            sum((cell(i,j),w), fm_croparea("y1995",j,w,knbe14) * i14_yields_calib_combined("y1995",j,yldtype,knbe14,w)) > 0.00001)
   + (sum((cell(i,j),w), i14_croparea_total("y1995",w,j) * i14_yields_calib_combined("y1995",j,yldtype,knbe14,w)) /
      sum((cell(i,j),w), i14_croparea_total("y1995",w,j)))$(sum((cell(i,j),w), fm_croparea("y1995",j,w,knbe14)) <= 0.00001 OR
                                                                 sum((cell(i,j),w), fm_croparea("y1995",j,w,knbe14) * i14_yields_calib_combined("y1995",j,yldtype,knbe14,w)) <= 0.00001);


  i14_yields_calib_combined(t,j,yldtype,knbe14,w) = sum((cell(i,j)), i14_fao_yields_hist("y1995",i,knbe14) /
                                                      i14_modeled_yields_hist2(i,yldtype,knbe14)) *
                                  i14_yields_calib_combined(t,j,yldtype,knbe14,w);
);

***BIOPHYSICAL CALIBRATION FOR 2ND GENERATION BIOENERGY CROPS (Li2020)*******************
*' Step 1: Compute LPJmL weighted mean rainfed yields for bioenergy crops at y1995 —
*'         regional (weighted by cropland area per cluster) and global, per yldtype.
*'         To-Do-NOTE: "y2010" index in f14_cluster_be_croparea_weights is a workaround — the data
*'         are actually y1995 cropland areas mislabelled during preprocessing. Once preprocessing
*'         is rerun the weights file will be timeless; remove "y2010" index and t_all from the
*'         parameter declaration then.
i14_be_LPJ_reg(i,yldtype,kbe14) =
  sum(cell(i,j), f14_cluster_be_croparea_weights("y2010",j,kbe14) * i14_yields_combined("y1995",j,yldtype,kbe14,"rainfed")) /
  (sum(cell(i,j), f14_cluster_be_croparea_weights("y2010",j,kbe14)) + 1e-8);

i14_be_LPJ_glo(yldtype,kbe14) =
  sum(j, f14_cluster_be_croparea_weights("y2010",j,kbe14) * i14_yields_combined("y1995",j,yldtype,kbe14,"rainfed")) /
  (sum(j, f14_cluster_be_croparea_weights("y2010",j,kbe14)) + 1e-8);

*' Step 2: Compute calibration factors as Li2020 / LPJmL mean — regional and global.
*'         Fall back to 1 where LPJmL mean is zero.
i14_be_calib_reg(i,yldtype,kbe14)$(i14_be_LPJ_reg(i,yldtype,kbe14) > 0) =
  f14_region_be_yields("y2010",i,kbe14) / i14_be_LPJ_reg(i,yldtype,kbe14);
i14_be_calib_reg(i,yldtype,kbe14)$(i14_be_LPJ_reg(i,yldtype,kbe14) = 0) = 1;

i14_be_calib_glo(yldtype,kbe14)$(i14_be_LPJ_glo(yldtype,kbe14) > 0) =
  f14_global_be_yields("y2010",kbe14) / i14_be_LPJ_glo(yldtype,kbe14);
i14_be_calib_glo(yldtype,kbe14)$(i14_be_LPJ_glo(yldtype,kbe14) = 0) = 1;

*' Step 3: Apply Li2020 biophysical calibration to i14_yields_calib_combined.
$ifthen "%c14_be_calib%" == "regional"
  i14_yields_calib_combined(t,j,yldtype,kbe14,w) =
    i14_yields_combined(t,j,yldtype,kbe14,w) * sum(cell(i,j), i14_be_calib_reg(i,yldtype,kbe14));
$elseif "%c14_be_calib%" == "global"
  i14_yields_calib_combined(t,j,yldtype,kbe14,w) =
    i14_yields_combined(t,j,yldtype,kbe14,w) * i14_be_calib_glo(yldtype,kbe14);
$else
  i14_yields_calib_combined(t,j,yldtype,kbe14,w) = i14_yields_combined(t,j,yldtype,kbe14,w);
$endif

***MANAGEMENT CALIBRATION FOR 2ND GENERATION BIOENERGY CROPS (tau scaling)****************
*' Tau-based management calibration applied on top of the Li2020 biophysical calibration.
i14_yields_calib_combined(t,j,yldtype,kbe14,w) = i14_yields_calib_combined(t,j,yldtype,kbe14,w) *
                                                    sum((supreg(h,i),cell(i,j)),fm_tau1995(h))/smax(h,fm_tau1995(h));
*******************************************************************************************

* Set yields to gsadapt values (pasture yields are not affected by growing period adaption)

if(s14_use_gsadapt = 1,
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
if(s14_use_yield_calib = 0 OR sum((i,ltype14),f14_yld_calib(i,ltype14)) = 0,
  f14_yld_calib(i,ltype14) = 1;
);


i14_yields_calib(t,j,kcr,w)       = i14_yields_calib(t,j,kcr,w)
                                    * sum(cell(i,j),f14_yld_calib(i,"crop"));
i14_yields_calib(t,j,"pasture",w) = i14_yields_calib(t,j,"pasture",w)
                                    * sum(cell(i,j),f14_yld_calib(i,"past"));

*' @stop

*' @code
*' Land degradation can negatively affect yields. Soil loss for example can
*' notably affect land productivity. Similarly, the yield of pollinator-dependent crops
*' is reduced when there is a lack of pollinators. To account for the impacts of degradation,
*' calibrated yields are multiplied by the share of land with intact NCP in each cell and specific
*' yield reduction coefficients that represent yield loss due to soil erosion and pollination
*' deficiency on non-intact land.

* set default values in case of missing input file.
if(sum((t,j,ncp_type14),f14_yld_ncp_report(t,j,ncp_type14)) = 0,
  f14_yld_ncp_report(t,j,ncp_type14) = 1;
);

if ((s14_degradation = 1),
  i14_yields_calib(t,j,kcr,w) = i14_yields_calib(t,j,kcr,w) * (1 - s14_yld_reduction_soil_loss)
                                + i14_yields_calib(t,j,kcr,w) * s14_yld_reduction_soil_loss * f14_yld_ncp_report(t,j,"soil_intact");
  i14_yields_calib(t,j,kcr,w) = i14_yields_calib(t,j,kcr,w) * (1 - f14_kcr_pollinator_dependence(kcr))
                                + i14_yields_calib(t,j,kcr,w) * f14_kcr_pollinator_dependence(kcr) * f14_yld_ncp_report(t,j,"poll_suff");
);

*' @stop
