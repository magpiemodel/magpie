*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

variables
 vm_cost_AEI(i)                  Irrigation expansion costs (mio. USD04MER)
;

positive variables
 vm_AEI(j)                       Area equipped for irrigation in each grid cell (mio. ha)
;

equations
 q41_area_irrig(j)               Irrigation area constraint (mio. ha)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_cost_AEI(t,i,type)     Irrigation expansion costs (mio. USD04MER)
 ov_AEI(t,j,type)          Area equipped for irrigation in each grid cell (mio. ha)
 oq41_area_irrig(t,j,type) Irrigation area constraint (mio. ha)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
