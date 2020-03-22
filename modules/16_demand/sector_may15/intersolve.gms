*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de
**************start solve loop**************

 pm_prices(t,i,kforestry) = q16_supply_forestry.m(i,kforestry);
 p16_mid_price = smax((i,kforestry),pm_prices(t,i,kforestry))/2;
 pm_prices(t,i,kforestry)$(pm_prices(t,i,kforestry)=0) = p16_mid_price;
