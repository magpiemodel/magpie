*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

parameters
 p41_cost_AEI_past(t,i)          Costs for AEI expansion from the past (mio. USD04MER)
 pc41_cost_AEI_past(i)           Current costs for AEI expansion from the past (mio. USD04MER)
 p41_AEI_start(t,j)              Area equipped for irrigation at the beginning of each time step (mio. ha)
 pc41_AEI_start(j)               Area equipped for irrigation at the beginning of current time step (mio. ha)
 pc41_unitcost_AEI(i)            Unit cost of AEI expansion (USD04MER per ha)
 pc41_ovcost_AEI(t,i)            Overall costs od AEI expansion including previous annuities (USD04MER per ha)
;

variables
 vm_cost_AEI(i)                  Irrigation expansion costs (mio. USD04MER per yr)
 v41_cost_AEI_annuity(i)         Annuity costs of AEI expansion in the current time step (mio. USD04MER per yr)
;

positive variables
 v41_AEI(j)                      Area equipped for irrigation in each grid cell (mio. ha)
;

equations
 q41_area_irrig(j)               Irrigation area constraint (mio. ha)
 q41_cost_AEI_annuity(i)         Calculation of annuity costs of AEI expansion (mio. USD04MER)
 q41_cost_AEI(i)                 Calculation of costs of irrigation area expansion (mio. USD04MER)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_cost_AEI(t,i,type)           Irrigation expansion costs (mio. USD04MER per yr)
 ov41_cost_AEI_annuity(t,i,type) Annuity costs of AEI expansion in the current time step (mio. USD04MER per yr)
 ov41_AEI(t,j,type)              Area equipped for irrigation in each grid cell (mio. ha)
 oq41_area_irrig(t,j,type)       Irrigation area constraint (mio. ha)
 oq41_cost_AEI_annuity(t,i,type) Calculation of annuity costs of AEI expansion (mio. USD04MER)
 oq41_cost_AEI(t,i,type)         Calculation of costs of irrigation area expansion (mio. USD04MER)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
