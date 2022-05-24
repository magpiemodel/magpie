*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

* 	Calibrate the CES function:
s38_ces_elast_par = (1/s38_ces_elast_subst) - 1 ;

* choosing between reginal and global factor requirements
if "%c38_fac_req%" == "glo" i38_fac_req(i,kcr) = f38_fac_req(kcr);
if "%c38_fac_req%" == "reg" i38_fac_req(i,kcr) = f38_fac_req_fao_reg(i,kcr);