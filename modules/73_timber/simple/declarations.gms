*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

parameters
pm_demand_forestry_future(i,kforestry)                                      Future forestry demand in current time step (tDM per yr)
pm_demand_ext(t_ext,i,kforestry)                                            Extended demand for timber beyound simulation (mio. tDM per yr)
;

variables
vm_cost_timber(i)				                                                    Actual cost of harvesting timber from forests (mio. USD per yr)
;

equations 
q73_est(j) blub2
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_cost_timber(t,i,type) Actual cost of harvesting timber from forests (mio. USD per yr)
 oq73_est(t,j,type)       blub2
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
