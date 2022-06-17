*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

* get calibration factors and aggregation weight
p36_calibration_hourly_costs(iso) = sum(t_past$(ord(t_past) eq card(t_past)), f36_hist_hourly_costs(t_past,iso)-(im_gdp_pc_mer_iso(t_past,iso)
																				*f36_regr_hourly_costs("slope")+f36_regr_hourly_costs("intercept")));
p36_total_hours_worked(iso) = sum(t_past$(ord(t_past) eq card(t_past)), f36_historic_ag_empl(t_past,iso)*f36_weekly_hours_iso(t_past,iso)*s36_weeks_in_year); 