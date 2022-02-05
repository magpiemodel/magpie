*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de
i31_manpast_suit(t_all,j) = f31_pastr_suitability(t_all,j,"%c31_past_suit_scen%");
pc31_grass(j,grassland) = f31_LUH2v2("y1995",j,grassland);


***YIELD CORRECTION FOR MOWING ACCOUNTING FOR REGIONAL DIFFERENCES IN MANAGEMENT***

*' Pasture yields are corrected upwards to match historical pasture productivity where necessary.
*' Only the mowing management option is corrected to capture the divesitiy of mowing management schemes.
*' Continuous Grazing is not correcte as MAgPIE can choose the yields by alocating LSUs to pasture, therefore linking
*' yields to management directly.

i31_grass_yields(t,j,grassland,w) = f31_grassl_yld(t,j,grassland,w);
i31_grassland_total(t_all,j) =  sum(grassland, f31_LUH2v2(t_all,j,grassland));
i31_grass_FAO_yld(t_past,i,grassland) = (f31_grass_bio(t_past,i, grassland) /
                sum(cell(i,j),f31_LUH2v2(t_past,j,grassland)))$(sum(cell(i,j), f31_LUH2v2(t_past,j,grassland))>0);

i31_grass_yields_hist(t_past,i,grassland)
   = (sum(cell(i,j),i31_grass_yields(t_past,j,grassland,"rainfed") * f31_LUH2v2(t_past,j,grassland)) /
      sum(cell(i,j),f31_LUH2v2(t_past,j,grassland)))$(sum(cell(i,j), f31_LUH2v2(t_past,j,grassland))>0)
   + (sum(cell(i,j),i31_grassland_total(t_past,j) * i31_grass_yields(t_past,j,grassland,"rainfed")) /
      sum(cell(i,j),i31_grassland_total(t_past,j)))$(sum(cell(i,j), f31_LUH2v2(t_past,j,grassland))=0);


loop(t,
     if(sum(sameas(t,"y1995"),1)=1,

          if    ((s31_limit_calib = 0),
               i31_lambda_grass(t,i,grassland) = 1;

          Elseif (s31_limit_calib =1 ),
               i31_lambda_grass(t,i,grassland) =
                    1$(i31_grass_FAO_yld(t,i,grassland) <= i31_grass_yields_hist(t,i,grassland))
                    + sqrt(i31_grass_yields_hist(t,i,grassland)/i31_grass_FAO_yld(t,i,grassland))$
                    (i31_grass_FAO_yld(t,i,grassland) > i31_grass_yields_hist(t,i,grassland));
          );

          i31_grassl_yld_hist_reg(t,i,grassland) = i31_grass_FAO_yld(t,i,grassland);

     Else
          i31_grass_yields_hist(t,i,grassland) = i31_grass_yields_hist(t-1,i,grassland);
          i31_grassl_yld_hist_reg(t,i,grassland)  = i31_grassl_yld_hist_reg(t-1,i,grassland);
          i31_lambda_grass(t,i,grassland)   = i31_lambda_grass(t-1,i,grassland);
     );
);


*' The calibrated cellular yield 'i14_yields_calib' is calculated for each time step depending
*' on the constant values 'i31_grass_yields_hist', 'i31_grassl_yld_hist_reg', 'i31_lambda_grass'
*' and the uncalibrated, cellular yield 'f14_yields' following the idea of eq. (9) in @Heinke.2013:

i31_grass_calib(t,j,grassland) =
  1 + (sum(cell(i,j), i31_grassl_yld_hist_reg(t,i,grassland) - i31_grass_yields_hist(t,i,grassland)) /
                             f31_grassl_yld(t,j,grassland,"rainfed") *
      (f31_grassl_yld(t,j,grassland,"rainfed") / (sum(cell(i,j),i31_grass_yields_hist(t,i,grassland))+10**(-8))) **
                             sum(cell(i,j),i31_lambda_grass(t,i,grassland)))$(f31_grassl_yld(t,j,grassland,"rainfed")>0);

i31_grass_yields(t,j,"range","rainfed") = i31_grass_yields(t,j,"range","rainfed") * i31_grass_calib(t,j,"range");
i31_grass_yields(t,j,"pastr","rainfed") = i31_grass_yields(t,j,"pastr","rainfed") * i31_grass_calib(t,j,"pastr");

*' Note that the calculation is split into two parts for better readability.
*' @stop
