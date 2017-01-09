*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

variables
 vm_cost_AEI(i)                              irrigation expansion costs (mio. US$)
;

positive variables
 v41_AEI(j)                                   area equipped for irrigation in each gridcell (mio ha.)
;

equations
 q41_area_irrig(j)               irrigation area constraint
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_cost_AEI(t,i,type)     irrigation expansion costs (mio. US$)
 ov41_AEI(t,j,type)        area equipped for irrigation in each gridcell (mio ha.)
 oq41_area_irrig(t,j,type) irrigation area constraint
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
