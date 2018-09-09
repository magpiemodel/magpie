*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

parameters
 p41_cost_AEI_past(t,i)          Costs for AEI expansion from the past (mio. USD)
 pc41_cost_AEI_past(i)           Current costs for AEI expansion from the past (mio. USD)
 p41_AEI_start(t,j)              Area equipped for irrigation at the beginning of each timestep (mio ha)
 pc41_AEI_start(j)               Area equipped for irrigation at the beginning of current timestep (mio ha)
 pc41_unitcost_AEI(i)            Unitcost of AEI expansion (USD per ha)
;

variables
 vm_cost_AEI(i)                  Irrigation expansion costs (mio. USD)
 v41_cost_AEI_annuity(i)         Annuity costs of AEI expansion in the current timestep (mio. USD)
;

positive variables
 v41_AEI(j)                      Area equipped for irrigation in each gridcell (mio ha)
;

equations
 q41_area_irrig(j)               irrigation area constraint (mio. ha)
 q41_cost_AEI_annuity(i)         Calculation of annuity costs of AEI expansion (mio. USD)
 q41_cost_AEI(i)                 Calculation of costs of irrigation area expansion (mio. USD)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_cost_AEI(t,i,type)           Irrigation expansion costs (mio. USD)
 ov41_cost_AEI_annuity(t,i,type) Annuity costs of AEI expansion in the current timestep (mio. USD)
 ov41_AEI(t,j,type)              Area equipped for irrigation in each gridcell (mio ha)
 oq41_area_irrig(t,j,type)       irrigation area constraint (mio. ha)
 oq41_cost_AEI_annuity(t,i,type) Calculation of annuity costs of AEI expansion (mio. USD)
 oq41_cost_AEI(t,i,type)         Calculation of costs of irrigation area expansion (mio. USD)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
