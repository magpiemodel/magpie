*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

* get calibration factors and aggregation weight
p36_calibration_hourly_costs(iso) = sum(t_past$(ord(t_past) eq card(t_past)), log(f36_hist_hourly_costs(t_past,iso)) - (log(im_gdp_pc_mer_iso(t_past,iso))
                                        *f36_regr_hourly_costs("slope") + f36_regr_hourly_costs("intercept")));
p36_total_hours_worked(iso) = sum(t_past$(ord(t_past) eq card(t_past)), f36_historic_ag_empl(t_past,iso)*f36_weekly_hours_iso(t_past,iso)*s36_weeks_in_year);

*' @code

*' Hourly labor costs are projected into the future by using a log-log regression with
*' GDPpcMER, which is calibrated such that historic values of agricultural employment
*' are met.
p36_hourly_costs_iso(t_all,iso,"baseline") = exp(log(im_gdp_pc_mer_iso(t_all,iso)) * f36_regr_hourly_costs("slope") +
                                                  f36_regr_hourly_costs("intercept") + p36_calibration_hourly_costs(iso));

*' @stop

p36_hourly_costs_iso(t_all,iso,"baseline")$(sum(sameas(t_past,t_all),1) = 1) = f36_hist_hourly_costs(t_all,iso);


* necessary increase in hourly labor costs in target year (2050) to match minimum wage
p36_hourly_costs_increase(iso) = s36_minimum_wage - p36_hourly_costs_iso("y2050",iso,"baseline");

p36_hourly_costs_iso(t_all,iso,"scenario") = p36_hourly_costs_iso(t_all,iso,"baseline");

*' @code
*' In case of a scenario with an external global minimum wage we add a linear term to the baseline
*' hourly labor costs, starting from 0 zero in 2020 and increasing such that resulting hourly labor costs will match
*' the minimum wage in 2050. After 2050 the additional term is decreased again, reaching 0 in 2100 (where baseline
*' hourly labor costs and new hourly labor costs will match again).
*' In case this means that hourly labor costs would decrease again below the minimum wage after 2050, we keep them
*' at minimum wage.
*' If baseline hourly labor costs are already high enough to meet the minimum wage in 2050, they are not changed.
*' @stop

p36_hourly_costs_iso(t_all,iso,"scenario")$((m_year(t_all) gt 2020) and (m_year(t_all) le 2050)) = p36_hourly_costs_iso(t_all,iso,"baseline") + max(0, ((m_year(t_all)-2020)/(2050-2020))*p36_hourly_costs_increase(iso));

p36_hourly_costs_iso(t_all,iso,"scenario")$((m_year(t_all) gt 2050) and (m_year(t_all) le 2100)) = max(s36_minimum_wage, p36_hourly_costs_iso(t_all,iso,"baseline") + max(0, p36_hourly_costs_increase(iso)-((m_year(t_all)-2050)/(2100-2050))*p36_hourly_costs_increase(iso)));

p36_hourly_costs_iso(t_all,iso,"scenario")$(m_year(t_all) gt 2100) = max(s36_minimum_wage, p36_hourly_costs_iso(t_all,iso,"baseline"));

* Hourly labor costs are then aggregated to regional level using the total hours worked in the last
* year of `t_past` as weight.
pm_hourly_costs(t,i,wage_scen) = sum(i_to_iso(i,iso), p36_hourly_costs_iso(t,iso,wage_scen)*p36_total_hours_worked(iso)) * (1/sum(i_to_iso(i,iso),p36_total_hours_worked(iso)));

*' @code
*' A scenario that increases wages can either be fully related to productivity increase (leading to lower employment
*' for the same total labor costs), or keep productivity constant (leading to the same employment for higher total labor
*' costs), or show a mixture between productivity increase and total labor cost increase.
*' The scalar `s36_scale_productivity_with_wage` describes how high the labor productivity gain should be relative to
*' the increase in hourly labor costs and is used to calculate `pm_productivity_gain_from_wages`, which is applied to
*' labor costs for crop production ([38_factor_costs]), livestock production ([70_livestock]), mitigation costs
*' ([57_maccs]) and the non-MAgPIE labor costs. If `s36_scale_productivity_with_wage = 1` the productivity gain and 
*' wage increase cancel out, leading to the same total labor costs as without wage scenario.
*' For `s36_scale_productivity_with_wage = 0` the total labor costs scale proportional to the hourly labor costs. For 
*' other values, the total labor costs show a non-linear realtionship with `s36_scale_productivity_with_wage`.

pm_productivity_gain_from_wages(t,i) = s36_scale_productivity_with_wage * (pm_hourly_costs(t,i,"scenario") / pm_hourly_costs(t,i,"baseline")) + (1 - s36_scale_productivity_with_wage);

*' @stop
