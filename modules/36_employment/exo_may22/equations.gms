*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


*' @equations

*' Employment is calculated as total labor costs divided by hourly labor costs and average 
*' hours worked per employed person per year. Employment for crop and livestock production
*' and employment for mitigation of GHG emissions are calclated in separate equaations. 
*' For the former, total labor costs include labor costs from crop production 
*' (see [38_factor_costs]), livestock production (see [70_livestock]), and some labor costs 
*' for crop and livestock production which are not covered by MAgPIE. For employment from
*' mitigation of GHG emissions labor costs come from the marginal abatement cost curves (MACCs)
*' (see [57_maccs]).

* excluding labor costs for crop residues (as this is not include in the 
* data on agricultural employment by the International Labour Organization)
* and fish (as we cannot calibrate labor costs for fish to employment data)
q36_employment(i2) .. v36_employment(i2)
         =e= (vm_cost_prod_crop(i2,"labor") + vm_cost_prod_livst(i2,"labor") + sum(ct,p36_nonmagpie_labor_costs(ct,i2))) *
             (1 / sum(ct,f36_weekly_hours(ct,i2)*s36_weeks_in_year*pm_hourly_costs(ct,i2,"scenario")));

q36_employment_maccs(i2) .. v36_employment_maccs(i2) 
         =e= (vm_maccs_costs(i2,"labor")) * (1 / sum(ct,f36_weekly_hours(ct,i2)*s36_weeks_in_year*pm_hourly_costs(ct,i2,"scenario")));
