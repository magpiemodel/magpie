*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

variables
 vm_cost_AEI(i)                  Irrigation expansion costs (mio. USD04MER)
;

positive variables
 v41_AEI(j)                      Area equipped for irrigation in each grid cell (mio. ha)
;

equations
 q41_area_irrig(j)               Irrigation area constraint (mio. ha)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_cost_AEI(t,i,type)     irrigation expansion costs (mio. USD04MER)
 ov41_AEI(t,j,type)        area equipped for irrigation in each gridcell (mio. ha)
 oq41_area_irrig(t,j,type) irrigation area constraint (mio. ha)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
