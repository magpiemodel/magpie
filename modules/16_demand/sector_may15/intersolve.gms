*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de
**************start solve loop**************

 pm_prices_woodymass(t,i,kforestry) = q16_supply_forestry.m(i,kforestry);
 pm_prices_woodymass("y1995",i,kforestry)$(pm_prices_woodymass("y1995",i,kforestry)=0) = 1;
