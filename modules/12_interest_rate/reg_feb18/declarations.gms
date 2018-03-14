*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

scalars
  s12_min_dev  minimum development_state of all regions in 1995
  s12_max_dev  maximum development_state of all regions in 1995
  s12_slope_a        slope of the linear relationship between development_state and interest rate
  s12_intercept_b    intercept of the linear relationship between development_state and interest rate
;

parameters
  pm_interest(i)        current real interest rate in each region
  pm_annuity_due(i)     current Annuity-due annual cash flows over n years in each region (vorschuessig)
  p12_interest(t,i)          real interest rate in each region and timestep
  p12_annuity_due(t,i)  Annuity-due annual cash flows over n years in each region (vorschuessig) and timestep
;