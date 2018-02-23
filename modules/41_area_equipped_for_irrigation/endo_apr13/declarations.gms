*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

parameters
 p41_cost_AEI_past(t,i)            costs for AEI expansion from the past (million US$)
 pc41_cost_AEI_past(i)             current costs for AEI expansion from the past (million US$)
 p41_AEI_start(t,j)            Area equipped for irrigation at the beginning of each timestep (mio ha)
 pc41_AEI_start(j)             Area equipped for irrigation at the beginning of current timestep (mio ha)
 pc41_unitcost_AEI(i)          unitcost of AEI expansion (US$ per ha)
;

variables
 vm_cost_AEI(i)                irrigation expansion costs (mio. US$)
 v41_cost_AEI_annuity(i)       annuity costs of AEI expansion in the current timestep (mio. US$)
;

positive variables
 v41_AEI(j)                    area equipped for irrigation in each gridcell (mio ha.)
;

equations
 q41_area_irrig(j)               irrigation area constraint
 q41_cost_AEI_annuity(i)                         Calculation of annuity costs of AEI expansion
 q41_cost_AEI(i)                     Calculation of costs of irrigation area expansion
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_cost_AEI(t,i,type)           irrigation expansion costs (mio. US$)
 ov41_cost_AEI_annuity(t,i,type) annuity costs of AEI expansion in the current timestep (mio. US$)
 ov41_AEI(t,j,type)              area equipped for irrigation in each gridcell (mio ha.)
 oq41_area_irrig(t,j,type)       irrigation area constraint
 oq41_cost_AEI_annuity(t,i,type) Calculation of annuity costs of AEI expansion
 oq41_cost_AEI(t,i,type)         Calculation of costs of irrigation area expansion
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
