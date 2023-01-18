*** |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

i14_yields_calib(t,j,kve,w)   = f14_yields(t,j,kve,w);

***YIELD CORRECTION FOR 2ND GENERATION BIOENERGY CROPS*************************************
i14_yields_calib(t,j,"begr",w) = f14_yields(t,j,"begr",w) * sum((supreg(h,i),cell(i,j)),fm_tau1995(h))/smax(h,fm_tau1995(h));
i14_yields_calib(t,j,"betr",w) = f14_yields(t,j,"betr",w) * sum((supreg(h,i),cell(i,j)),fm_tau1995(h))/smax(h,fm_tau1995(h));

***YIELD CORRECTION FOR PASTURE ACCOUNTING FOR REGIONAL DIFFERENCES IN MANAGEMENT***
p14_pyield_LPJ_reg(t,i) = (sum(cell(i,j),i14_yields_calib(t,j,"pasture","rainfed") * pm_land_start(j,"past")) /
                            sum(cell(i,j),pm_land_start(j,"past")) );

p14_pyield_corr(t,i) = (f14_pyld_hist(t,i)/p14_pyield_LPJ_reg(t,i))$(sum(sameas(t_past,t),1) = 1)
			+ sum(t_past,(f14_pyld_hist(t_past,i)/(p14_pyield_LPJ_reg(t_past,i)+0.000001))$(ord(t_past)=card(t_past)))$(sum(sameas(t_past,t),1) <> 1);
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

i14_croparea_total(t_all,w,j) = sum(kcr, fm_croparea(t_all,j,w,kcr));

*' Historic crop area patterns (`fm_croprea`) are used to calculate regional yields
*' (`i14_modeled_yields_hist`) from the given cellular input pattern. In rare cases where
*' a region has no crop area reported for a given crop type, the total crop area is
*' used to calculate a proxy yield for the calibration, given by the following equation:

i14_modeled_yields_hist(t_past,i,knbe14)
   = (sum((cell(i,j),w), fm_croparea(t_past,j,w,knbe14) * f14_yields(t_past,j,knbe14,w)) /
      sum((cell(i,j),w), fm_croparea(t_past,j,w,knbe14)))$(sum((cell(i,j),w), fm_croparea(t_past,j,w,knbe14))>0)
   + (sum((cell(i,j),w), i14_croparea_total(t_past,w,j) * f14_yields(t_past,j,knbe14,w)) /
      sum((cell(i,j),w), i14_croparea_total(t_past,w,j)))$(sum((cell(i,j),w), fm_croparea(t_past,j,w,knbe14))=0);


*' The factor `i14_lambda_yields` is calculated for the initial time step depending
*' on the setting `s14_limit_calib` and is then held constant for all other time steps.
*' The regional FAO yield and regional yield of the crop model input of the initial
*' time step is kept constant in the two parameters `i14_fao_yields_hist` and
*' `i14_modeled_yields_hist`:

loop(t,
     if(sum(sameas(t,"y1995"),1)=1,

          if    ((s14_limit_calib = 0),
               i14_lambda_yields(t,i,knbe14) = 1;

          Elseif (s14_limit_calib =1 ),
               i14_lambda_yields(t,i,knbe14) =
                    1$(f14_fao_yields_hist(t,i,knbe14) <= i14_modeled_yields_hist(t,i,knbe14))
                    + sqrt(i14_modeled_yields_hist(t,i,knbe14)/f14_fao_yields_hist(t,i,knbe14))$
                    (f14_fao_yields_hist(t,i,knbe14) > i14_modeled_yields_hist(t,i,knbe14));
          );

          i14_fao_yields_hist(t,i,knbe14) = f14_fao_yields_hist(t,i,knbe14);

     Else
          i14_modeled_yields_hist(t,i,knbe14) = i14_modeled_yields_hist(t-1,i,knbe14);
          i14_FAO_yields_hist(t,i,knbe14)  = i14_fao_yields_hist(t-1,i,knbe14);
          i14_lambda_yields(t,i,knbe14)   = i14_lambda_yields(t-1,i,knbe14);
     );
);

*' The calibrated cellular yield `i14_yields_calib` is calculated for each time step depending
*' on the constant values `i14_modeled_yields_hist`, `i14_fao_yields_hist`, `i14_lambda_yields`
*' and the uncalibrated, cellular yield `f14_yields` following the idea of eq. (9) in [@Heinke.2013]:

i14_managementcalib(t,j,knbe14,w) =
  1 + (sum(cell(i,j), i14_fao_yields_hist(t,i,knbe14) - i14_modeled_yields_hist(t,i,knbe14)) /
                             f14_yields(t,j,knbe14,w) *
      (f14_yields(t,j,knbe14,w) / (sum(cell(i,j),i14_modeled_yields_hist(t,i,knbe14))+10**(-8))) **
                             sum(cell(i,j),i14_lambda_yields(t,i,knbe14)))$(f14_yields(t,j,knbe14,w)>0);


i14_yields_calib(t,j,knbe14,w)    = i14_managementcalib(t,j,knbe14,w) * f14_yields(t,j,knbe14,w);
pm_yields_semi_calib(j,knbe14,w)  = i14_yields_calib("y1995",j,knbe14,w);

*' Note that the calculation is split into two parts for better readability.

*' Irrigated yields are calibrated to meet the country-level
*' ratio between irrigated and rainfed yields reported by Aquastat.
*' This can be de-activated with the switch `s14_calib_ir2rf`.
if ((s14_calib_ir2rf = 1),

* Weighted yields
  i14_calib_yields_hist(i,w)
     = sum((cell(i,j), knbe14), fm_croparea("y1995",j,"irrigated",knbe14) * i14_yields_calib("y1995",j,knbe14,w)) /
       sum((cell(i,j), knbe14), fm_croparea("y1995",j,"irrigated",knbe14));

* Use irrigated-rainfed ratio of Aquastat if larger than our calculated ratio
  i14_calib_yields_ratio(i) = i14_calib_yields_hist(i,"irrigated") / i14_calib_yields_hist(i,"rainfed");
  i14_target_ratio(i) = max(i14_calib_yields_ratio(i), f14_ir2rf_ratio(i));
  i14_yields_calib(t,j,knbe14,"irrigated") = sum((cell(i,j)), i14_target_ratio(i) / i14_calib_yields_ratio(i)) *
                                               i14_yields_calib(t,j,knbe14,"irrigated");

* Calibrate newly calibrated yields to FAO yields
  i14_modeled_yields_hist2(i,knbe14)
   = (sum((cell(i,j),w), fm_croparea("y1995",j,w,knbe14) * i14_yields_calib("y1995",j,knbe14,w)) /
      sum((cell(i,j),w), fm_croparea("y1995",j,w,knbe14)))$(sum((cell(i,j),w), fm_croparea("y1995",j,w,knbe14))>0)
   + (sum((cell(i,j),w), i14_croparea_total("y1995",w,j) * f14_yields("y1995",j,knbe14,w)) /
      sum((cell(i,j),w), i14_croparea_total("y1995",w,j)))$(sum((cell(i,j),w), fm_croparea("y1995",j,w,knbe14))=0);

  i14_yields_calib(t,j,knbe14,w) = sum((cell(i,j)), i14_fao_yields_hist("y1995",i,knbe14) /
                                                      i14_modeled_yields_hist2(i,knbe14)) *
                                   i14_yields_calib(t,j,knbe14,w);

  pm_yields_semi_calib(j,knbe14,w)  = i14_yields_calib("y1995",j,knbe14,w);
);

*' @stop


***YIELD CALIBRATION***********************************************************************

*' @code
*' Calibrated yields are additionally adjusted by calibration factors 'f14_yld_calib'
*' determined in a calibration run. As MAgPIE optimizes yield patterns and FAO regional
*' yields are outlier corrected, historical production and croparea can only be reproduced
*' with this additional step of correction:

* set default values in case of missing input file
if(sum((i,ltype14),f14_yld_calib(i,ltype14)) = 0,
	f14_yld_calib(i,ltype14) = 1;
);


i14_yields_calib(t,j,kcr,w)       = i14_yields_calib(t,j,kcr,w)      *sum(cell(i,j),f14_yld_calib(i,"crop"));
i14_yields_calib(t,j,"pasture",w) = i14_yields_calib(t,j,"pasture",w)*sum(cell(i,j),f14_yld_calib(i,"past"));

*' @stop

****
****
****
p14_growing_stock_initial(j,ac,"forestry","plantations") =
    (
      pm_carbon_density_ac_forestry("y1995",j,ac,"vegc")
      / s14_carbon_fraction
      * f14_aboveground_fraction("forestry")
      / sum(clcl, pm_climate_class(j,clcl) * f14_ipcc_bce(clcl,"plantations"))
     )
    ;

p14_growing_stock_initial(j,ac,land_natveg,"natveg") =
    (
       pm_carbon_density_ac("y1995",j,ac,"vegc")
      / s14_carbon_fraction
      * f14_aboveground_fraction(land_natveg)
      / sum(clcl, pm_climate_class(j,clcl) * f14_ipcc_bce(clcl,"natveg"))
     )
    ;
**** Hard constraint to always have a positive number in p14_growing_stock
p14_growing_stock_initial(j,ac,land_natveg,"natveg") = p14_growing_stock_initial(j,ac,land_natveg,"natveg")$(p14_growing_stock_initial(j,ac,land_natveg,"natveg")>0)+0.0001$(p14_growing_stock_initial(j,ac,land_natveg,"natveg")=0);
p14_growing_stock_initial(j,ac,"forestry","plantations") = p14_growing_stock_initial(j,ac,"forestry","plantations")$(p14_growing_stock_initial(j,ac,"forestry","plantations")>0)+0.0001$(p14_growing_stock_initial(j,ac,"forestry","plantations")=0);

** Used in equations
***************************************************************
** If the plantation yield switch is on, forestry yields are treated as plantation yields
pm_timber_yield_initial(j,ac,"forestry")$(s14_timber_plantation_yield = 1) = p14_growing_stock_initial(j,ac,"forestry","plantations") ;
** If the plantation yield switch is off, then the forestry yields are given the same values as secdforest yields,
pm_timber_yield_initial(j,ac,"forestry")$(s14_timber_plantation_yield = 0) = pm_timber_yield_initial(j,ac,"secdforest");
** Natveg yields are unchanged and do not depend on plantation yield switch
pm_timber_yield_initial(j,ac,land_natveg) = p14_growing_stock_initial(j,ac,land_natveg,"natveg");
