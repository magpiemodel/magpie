*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

parameters
 im_wat_avail(t,wat_src,j)        water availability (million m^3)
;

variables 
  v43_watavail(wat_src,j)                      amount of water available from different sources(mio. m^3)
;

equations
  q43_water(j)                    local seasonal water constraints
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov43_watavail(t,wat_src,j,type) amount of water available from different sources(mio. m^3)
 oq43_water(t,j,type)            local seasonal water constraints
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################

