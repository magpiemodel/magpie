*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


*' @code

*' Non-MAgPIE labor costs consist of the labor cost share of subsidies and from livestock
*' categories not covered by MAgPIE (i.e. wool, beeswax, honey, silk-worms), which 
*' are both kept constant for future years. 

p36_nonmagpie_labor_costs(t,i) = (f36_unspecified_subsidies(t,i) + f36_nonmagpie_factor_costs(t,i)) *
                                     (pm_factor_cost_shares(t,i,"labor")) * (1/pm_productivity_gain_from_wages(t,i)) *
                                     (pm_hourly_costs(t,i,"scenario") / pm_hourly_costs(t,i,"baseline"));

*' @stop
