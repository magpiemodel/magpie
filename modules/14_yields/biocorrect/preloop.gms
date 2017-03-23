*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

i14_yields(t,j,kve,w) = f14_yields(t,j,kve,w);

***YIELD CORRECTION FOR 2ND GENERATION BIOENERGY CROPS**************************
i14_yields(t,j,"begr",w) = i14_yields(t,j,"begr",w)*sum(cell(i,j),fm_tau1995(i))/fm_tau1995("EUR");
i14_yields(t,j,"betr",w) = i14_yields(t,j,"betr",w)*sum(cell(i,j),fm_tau1995(i))/fm_tau1995("EUR");

***YIELD CALIBRATION************************************************************
i14_yields(t,j,kcr,w)       = i14_yields(t,j,kcr,w)      *sum(cell(i,j),f14_yld_calib(i,"crop"));
i14_yields(t,j,"pasture",w) = i14_yields(t,j,"pasture",w)*sum(cell(i,j),f14_yld_calib(i,"past"));
