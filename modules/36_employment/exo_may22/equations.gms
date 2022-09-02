*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


*' @equations

* excluding labor costs for crop residues (as this is not include in the 
* data on agricultural employment by the International Labour Organization)
* and fish (as we cannot calibrate labor costs for fish to employment data)

q36_employment(i2) .. v36_employment(i2)
                              =e= (vm_cost_prod_crop(i2,"labor") + vm_cost_prod_livst(i2,"labor") + sum(ct,p36_nonmagpie_labor_costs(ct,i2))) *
                                        (1 / sum(ct,f36_weekly_hours(ct,i2)*s36_weeks_in_year*p36_hourly_costs(ct,i2)));

*' Employment is calculated as total labor costs devided by hourly labor costs and 
*' average hours worked per employed person per year. Total labor costs include
*' labor costs from crop production (see [38_factor_costs]) and livestock production 
*' (see [70_livestock]), and some labor costs for crop and livestock production 
*' which are not covered by MAgPIE.