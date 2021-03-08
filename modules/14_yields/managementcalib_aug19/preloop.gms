*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

i14_yields_calib(t,j,kve,w)   = f14_yields(t,j,kve,w);

***YIELD CORRECTION FOR 2ND GENERATION BIOENERGY CROPS*************************************
i14_yields_calib(t,j,"begr",w) = f14_yields(t,j,"begr",w) * sum(cell(i,j),fm_tau1995(i))/smax(i,fm_tau1995(i));
i14_yields_calib(t,j,"betr",w) = f14_yields(t,j,"betr",w) * sum(cell(i,j),fm_tau1995(i))/smax(i,fm_tau1995(i));

***YIELD CORRECTION FOR PASTURE ACCOUNTING FOR REGIONAL DIFFERENCES IN MANAGEMENT***
p14_pyield_LPJ_reg(t,i) = (sum(cell(i,j),i14_yields_calib(t,j,"pasture","rainfed") * pm_land_start(j,"past")) /
                            sum(cell(i,j),pm_land_start(j,"past")) );

p14_pyield_corr(t,i) = (f14_pyld_hist(t,i)/p14_pyield_LPJ_reg(t,i))$(sum(sameas(t_past,t),1) = 1)
			+ sum(t_past,(f14_pyld_hist(t_past,i)/(p14_pyield_LPJ_reg(t_past,i)+0.000001))$(ord(t_past)=card(t_past)))$(sum(sameas(t_past,t),1) <> 1);
i14_yields_calib(t,j,"pasture",w) = i14_yields_calib(t,j,"pasture",w) * sum(cell(i,j),p14_pyield_corr(t,i));


***YIELD MANAGEMENT CALIBRATION************************************************************
i14_croparea_total(t_all,j) = sum((kcr,w), fm_croparea(t_all,j,w,kcr));
i14_lpj_yields_hist(t_past,i,knbe14) = (sum((cell(i,j),w), fm_croparea(t_past,j,w,knbe14) * f14_yields(t_past,j,knbe14,w)) /
                                             sum((cell(i,j),w), fm_croparea(t_past,j,w,knbe14)))$(sum((cell(i,j),w), fm_croparea(t_past,j,w,knbe14))>0) +
																            (sum((cell(i,j),w), i14_croparea_total(t_past,j) * f14_yields(t_past,j,knbe14,w)) /
																      	     sum(cell(i,j), i14_croparea_total(t_past,j)))$(sum((cell(i,j),w), fm_croparea(t_past,j,w,knbe14))=0);
loop(t, if(sum(sameas(t,"y1995"),1)=1,
          if ((s14_limit_calib = 0),
			      i14_lambda_yields(t,i,knbe14) = 1;
					Elseif (s14_limit_calib =1 ),
            i14_lambda_yields(t,i,knbe14) = 1$(f14_regions_yields(t,i,knbe14) <= i14_lpj_yields_hist(t,i,knbe14))
                                            + sqrt(i14_lpj_yields_hist(t,i,knbe14)/f14_regions_yields(t,i,knbe14))$
                                               (f14_regions_yields(t,i,knbe14) > i14_lpj_yields_hist(t,i,knbe14));
           );
           i14_regions_yields(t,i,knbe14) = f14_regions_yields(t,i,knbe14);
		    Else
		      i14_lpj_yields_hist(t,i,knbe14) = i14_lpj_yields_hist(t-1,i,knbe14);
          i14_regions_yields(t,i,knbe14)  = i14_regions_yields(t-1,i,knbe14);
		    	i14_lambda_yields(t,i,knbe14)   = i14_lambda_yields(t-1,i,knbe14);
		);
);
i14_managementcalib(t,j,knbe14,w) =
  1 + (sum(cell(i,j), i14_regions_yields(t,i,knbe14) - i14_lpj_yields_hist(t,i,knbe14)) /
                                          f14_yields(t,j,knbe14,w) *
      (f14_yields(t,j,knbe14,w) / (sum(cell(i,j),i14_lpj_yields_hist(t,i,knbe14))+10**(-8))) **
                             sum(cell(i,j),i14_lambda_yields(t,i,knbe14)))$
																			  (f14_yields(t,j,knbe14,w)>0);
i14_yields_calib(t,j,knbe14,w)    = i14_managementcalib(t,j,knbe14,w) * f14_yields(t,j,knbe14,w);
***YIELD CALIBRATION***********************************************************************
i14_yields_calib(t,j,kcr,w)       = i14_yields_calib(t,j,kcr,w)      *sum(cell(i,j),f14_yld_calib(i,"crop"));
i14_yields_calib(t,j,"pasture",w) = i14_yields_calib(t,j,"pasture",w)*sum(cell(i,j),f14_yld_calib(i,"past"));


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
** If the plantation yield switch is on, forestry yields are treated are plantation yields
pm_timber_yield_initial(j,ac,"forestry")$(s14_timber_plantation_yield = 1) = p14_growing_stock_initial(j,ac,"forestry","plantations") ;
** If the plantation yield switch is off, then the forestry yields are given the same values as secdforest yields,
pm_timber_yield_initial(j,ac,"forestry")$(s14_timber_plantation_yield = 0) = pm_timber_yield_initial(j,ac,"secdforest");
** Natveg yields are unchanged and doesn't depend on plantation yield switch
pm_timber_yield_initial(j,ac,land_natveg) = p14_growing_stock_initial(j,ac,land_natveg,"natveg");
