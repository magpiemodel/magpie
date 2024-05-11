*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


pc31_grass(j,grassland) = f31_LUH2v2("y1995",j,grassland);


***YIELD CORRECTION ACCOUNTING FOR REGIONAL DIFFERENCES IN MANAGEMENT***

*' @code

*' Grassland yields for rangelands and managed pastures are calibrated to match estimated
*' historical pasture productivity.

*' The following equations calibrate the grassland cellular yield patterns ('f31_grassl_yld') to match
*' 'estimated historical yields' ('i31_grass_hist_yld') by calculating a calibration term called
*' 'i31_grass_calib'. For most cases, 'i31_grass_calib' is the ratio of the 'i31_grass_hist_yld'
*' and modeled yields ('i31_grass_modeled_yld') given historic grassland area patterns
*' ('i31_grassl_areas') and cellular yields coming from crop models like LPJmL 'f31_grassl_yld'.
*' In these cases, 'i31_grass_calib' represents a purely relative calibration factor that depends
*' only on the initial conditions of the starting year.
*'
*' However, when estimated yields 'i31_grass_hist_yld' are significantly higher than
*' given by the cellular yield inputs 'f31_grassl_yld' we refer to this as an underestimated
*' baseline. In this situation the relative calibration terms can lead to unrealistically
*' large yields in the case of future yield increases within the cellular yield patterns.
*'
*' To address this issue, we introduce the factor 'i31_lambda_grass' that determines the degree
*' to which the baseline 'i31_grass_hist_yld' is under- or overestimated by the modeled yields
*' 'i31_grass_modeled_yld'. This factor is used to control whether the calibration factor is
*' applied as an absolute or relative change. For 'i31_grass_hist_yld' smaller than
*' 'i31_grass_modeled_yld' (overestimated baseline) 'i31_lambda_grass' is 1, which is
*' equivalent to an entirely relative calibration. For underestimated yields, 'i31_lambda_grass'
*' is calculated as the squared root of the ratio between modeled yields 'i31_grass_modeled_yld'
*' and the historical estimates 'i31_grass_hist_yld'. For underestimated yields, as 'i31_lambda_grass'
*' approaches 0, it reduces the applied relative change resulting in a mean change increasingly
*' similar to an additive term (@Heinke.2013).

*' This concept is referred to as limited calibration, as it limits the calibration
*' to an additive term in case of a strongly underestimated baseline. The scalar
* 's31_limit_calib' can be used to switch limited calibration on (1) and off (0).

i31_grass_yields(t,j,grassland) = f31_grassl_yld(t,j,grassland,"rainfed");
i31_grassl_areas(t_all,j) =  sum(grassland, f31_LUH2v2(t_all,j,grassland));
i31_grass_hist_yld(t_past,i,grassland) = (f31_grass_bio(t_past,i, grassland) /
                sum(cell(i,j),f31_LUH2v2(t_past,j,grassland)))$(sum(cell(i,j), f31_LUH2v2(t_past,j,grassland))>0);

i31_grass_modeled_yld(t_past,i,grassland)
   = (sum(cell(i,j),i31_grass_yields(t_past,j,grassland) * f31_LUH2v2(t_past,j,grassland)) /
      sum(cell(i,j),f31_LUH2v2(t_past,j,grassland)))$(sum(cell(i,j), f31_LUH2v2(t_past,j,grassland))>0)
   + (sum(cell(i,j),i31_grassl_areas(t_past,j) * i31_grass_yields(t_past,j,grassland)) /
      sum(cell(i,j),i31_grassl_areas(t_past,j)))$(sum(cell(i,j), f31_LUH2v2(t_past,j,grassland))=0);

loop(t,
     if(sum(sameas(t,"y1995"),1)=1,

          if    ((s31_limit_calib = 0),
               i31_lambda_grass(t,i,grassland) = 1;

          Elseif (s31_limit_calib =1 ),
               i31_lambda_grass(t,i,grassland) =
                    1$(i31_grass_hist_yld(t,i,grassland) <= i31_grass_modeled_yld(t,i,grassland))
                    + sqrt(i31_grass_modeled_yld(t,i,grassland)/i31_grass_hist_yld(t,i,grassland))$
                    (i31_grass_hist_yld(t,i,grassland) > i31_grass_modeled_yld(t,i,grassland));
          );

          i31_grassl_yld_hist_reg(t,i,grassland) = i31_grass_hist_yld(t,i,grassland);

     Else
          i31_grass_modeled_yld(t,i,grassland) = i31_grass_modeled_yld(t-1,i,grassland);
          i31_grassl_yld_hist_reg(t,i,grassland)  = i31_grassl_yld_hist_reg(t-1,i,grassland);
          i31_lambda_grass(t,i,grassland)   = i31_lambda_grass(t-1,i,grassland);
     );
);


*' The calibrated cellular yield 'i31_grass_yields' is calculated for each time step depending
*' on the constant values 'i31_grass_modeled_yld', 'i31_grassl_yld_hist_reg', 'i31_lambda_grass'
*' and the uncalibrated, cellular yield 'f31_grassl_yld' following the idea of eq. (9) in @Heinke.2013:

i31_grass_calib(t,j,grassland) =
  1 + (sum(cell(i,j), i31_grassl_yld_hist_reg(t,i,grassland) - i31_grass_modeled_yld(t,i,grassland)) /
                             f31_grassl_yld(t,j,grassland,"rainfed") *
      (f31_grassl_yld(t,j,grassland,"rainfed") / (sum(cell(i,j),i31_grass_modeled_yld(t,i,grassland))+10**(-8))) **
                             sum(cell(i,j),i31_lambda_grass(t,i,grassland)))$(f31_grassl_yld(t,j,grassland,"rainfed")>0);

i31_grass_yields(t,j,"range") = i31_grass_yields(t,j,"range") * i31_grass_calib(t,j,"range");
i31_grass_yields(t,j,"pastr") = i31_grass_yields(t,j,"pastr") * i31_grass_calib(t,j,"pastr");

*' Note that the calculation is split into two parts for better readability.
*' @stop
