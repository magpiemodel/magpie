*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


equations
 q36_employment(i)            Regional employment in agricultural production (mio. people)
 q36_employment_maccs(i)      Additional regional employment for GHG mitigation in agriculture (mio. people)
;

positive variables
 v36_employment(i)               Number of people employed in agricultural production (mio. people)
 v36_employment_maccs(i)         Number of people employed in GHG mitigation in agriculture (mio. people)
;

parameters
 p36_hourly_costs_iso(t_all,iso, wage_scen) Hourly labor costs in agriculture on iso level before and after including wage scenario (USDMER05 per hour)
 p36_hourly_costs_increase(iso)         Difference between minimum hourly labor costs and actual hourly labor costs in 2050 (USDMER05 per hour)
 pm_hourly_costs(t,i, wage_scen)        Hourly labor costs in agriculture on regional level before and after including wage scenario (USDMER05 per hour)
 pm_productivity_gain_from_wages(t,i)   Multiplicative factor describing productivity gain related to higher wages (1)
 p36_total_hours_worked(iso)            Total hours worked by all employed people (mio. hours per year)
 p36_calibration_hourly_costs(iso)      Additive calibration term for hourly labor costs (USDMER05 per hour)
 p36_cost_share(t,i)                    Capital share of factor costs (1)
 p36_share_calibration(i)               Additive calibration term for capital shares (1)
 p36_nonmagpie_labor_costs(t,i)         Labor costs from subsidies and Value of Production not covered by MAgPIE (mio. USDMER05)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov36_employment(t,i,type)       Number of people employed in agricultural production (mio. people)
 ov36_employment_maccs(t,i,type) Number of people employed in GHG mitigation in agriculture (mio. people)
 oq36_employment(t,i,type)       Regional employment in agricultural production (mio. people)
 oq36_employment_maccs(t,i,type) Additional regional employment for GHG mitigation in agriculture (mio. people)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################

