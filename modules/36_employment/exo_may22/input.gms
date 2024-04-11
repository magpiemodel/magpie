*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

scalars
s36_weeks_in_year number of weeks in a year (weeks per yr) / 52.1429 /
s36_minimum_wage global minimum wage (USDMER05 per hour) / 0 /
s36_scale_productivity_with_wage how strong the wage increase should affect labor productivity (1) / 0 /
;

table f36_weekly_hours(t_all,i) Historical values of average weekly hours worked per person in agriculture (h per week)
$ondelim
$include "./modules/36_employment/exo_may22/input/f36_weekly_hours.csv"
$offdelim
;

table f36_weekly_hours_iso(t_all,iso) Historical values of average weekly hours worked per person in agriculture on iso level (h per week)
$ondelim
$include "./modules/36_employment/exo_may22/input/f36_weekly_hours_iso.csv"
$offdelim
;

table f36_hist_hourly_costs(t_all,iso) Historical values of hourly labor costs in agriculture (USD05MER per h)
$ondelim
$include "./modules/36_employment/exo_may22/input/f36_historic_hourly_labor_costs.csv"
$offdelim
;

parameter f36_regr_hourly_costs(reg36) Parameters for regression of hourly labor costs with GDPpcMER 
/
$ondelim
$include "./modules/36_employment/exo_may22/input/f36_regression_hourly_labor_costs.csv"
$offdelim
/
;

table f36_historic_ag_empl(t_all,iso) Historical values of people employed in agruculture (mio. people)
$ondelim
$include "./modules/36_employment/exo_may22/input/f36_historic_ag_employment.csv"
$offdelim
;

table f36_unspecified_subsidies(t_all,i) Factor cost share of unspecified subsidies not included in MAgPIE labor costs (mio. USD05MER)
$ondelim
$include "./modules/36_employment/exo_may22/input/f36_unspecified_subsidies.csv"
$offdelim
;

table f36_nonmagpie_factor_costs(t_all,i) Factor cost share of VoP from ag commodities not mapped to MAgPIE (mio. USD05MER)
$ondelim
$include "./modules/36_employment/exo_may22/input/f36_nonmagpie_factor_costs.csv"
$offdelim
;

parameter f36_regr_cap_share(reg36) Parameters for dynamic regression
/
$ondelim
$include "./modules/36_employment/exo_may22/input/f36_regression_cap_share.csv"
$offdelim
/
;

table f36_hist_cap_share(t_all,i) Historical capital share
$ondelim
$include "./modules/36_employment/exo_may22/input/f36_historical_share.csv"
$offdelim
;


