*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

scalars
  s12_min_dev  Minimum development_state of all regions in 1995 (1)
  s12_max_dev  Maximum development_state of all regions in 1995 (1)
  s12_slope_a        Slope of the linear relationship between development state and interest rate (1)
  s12_intercept_b    Intercept of the linear relationship between development state and interest rate (1)
;

parameters
  pm_interest(i)        Current interest rate in each region (% per yr)
  p12_interest(t,i)     Interest rate in each region and timestep (% per yr)
;
