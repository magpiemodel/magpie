*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

i14_yields(t,j,kve,w)   = f14_yields(t,j,kve,w);

***YIELD CORRECTION FOR 2ND GENERATION BIOENERGY CROPS*************************************
i14_yields(t,j,"begr",w) = i14_yields(t,j,"begr",w)*sum(cell(i,j),fm_tau1995(i))/smax(i,fm_tau1995(i));
i14_yields(t,j,"betr",w) = i14_yields(t,j,"betr",w)*sum(cell(i,j),fm_tau1995(i))/smax(i,fm_tau1995(i));

***YIELD CORRECTION FOR PASTURE ACCOUNTING FOR REGIONAL DIFFERENCES IN MANAGEMENT***
p14_pyield_LPJ_reg(t,i) = (sum(cell(i,j),i14_yields(t,j,"pasture","rainfed")*pm_land_start(j,"past"))/sum(cell(i,j),pm_land_start(j,"past")) );

p14_pyield_corr(t,i) = (f14_pyld_hist(t,i)/p14_pyield_LPJ_reg(t,i))$(sum(sameas(t_past,t),1) = 1)
			+ sum(t_past,(f14_pyld_hist(t_past,i)/(p14_pyield_LPJ_reg(t_past,i)+0.000001))$(ord(t_past)=card(t_past)))$(sum(sameas(t_past,t),1) <> 1);
i14_yields(t,j,"pasture",w) = i14_yields(t,j,"pasture",w)*sum(cell(i,j),p14_pyield_corr(t,i));

***YIELD MANAGEMENT CALIBRATION************************************************************

p14_lpj_yields(t,i,kcr)         = sum((cell(i,j),w), fm_croparea(t,j,w,kcr) * f14_yields(t,j,kcr,w)) /
                                   (sum((cell(i,j),w), fm_croparea(t,j,w,kcr))+0.000001);
loop(t,
     if(sum(sameas(t,t_past),1)=1,
       p14_lpj_yields_past(t,i,kcr) = p14_lpj_yields(t,i,kcr);
			 p14_delta_yields(t,i,kcr)    = f14_regions_yields(t,i,kcr) - p14_lpj_yields(t,i,kcr);
			 p14_ccratio_yields(t,i,kcr)  = 1$(p14_lpj_yields_past(t,i,kcr)=0) +
			                                (p14_lpj_yields(t,i,kcr) / p14_lpj_yields_past(t,i,kcr))$(p14_lpj_yields_past(t,i,kcr)>0);
			 p14_lambda_yields(t,i,kcr)   = 1$
			                                   ((not s14_limit_calib) or (f14_regions_yields(t,i,kcr) <= p14_lpj_yields(t,i,kcr))) +
																			sqrt(p14_lpj_yields(t,i,kcr)/f14_regions_yields(t,i,kcr))$
																			   ((s14_limit_calib) and (f14_regions_yields(t,i,kcr) > p14_lpj_yields(t,i,kcr)));
		 Else
		   p14_lpj_yields_past(t,i,kcr) = p14_lpj_yields_past(t-1,i,kcr);
			 p14_delta_yields(t,i,kcr)    = p14_delta_yields(t-1,i,kcr);
			 p14_ccratio_yields(t,i,kcr)  = 1$(p14_lpj_yields_past(t,i,kcr)=0) +
																		  (p14_lpj_yields(t,i,kcr) / p14_lpj_yields_past(t,i,kcr))$(p14_lpj_yields_past(t,i,kcr)>0);
			p14_lambda_yields(t,i,kcr)    = p14_lambda_yields(t-1,i,kcr);
		);
);

p14_managementcalib(t,i,kcr) = 1 + p14_delta_yields(t,i,kcr)/ (p14_lpj_yields(t,i,kcr)+0.000001) *
                                      (p14_ccratio_yields(t,i,kcr)) ** p14_lambda_yields(t,i,kcr);


***YIELD CALIBRATION***********************************************************************
i14_yields(t,j,kcr,w)       = i14_yields(t,j,kcr,w)      *sum(cell(i,j),f14_yld_calib(i,"crop"));
i14_yields(t,j,"pasture",w) = i14_yields(t,j,"pasture",w)*sum(cell(i,j),f14_yld_calib(i,"past"));
