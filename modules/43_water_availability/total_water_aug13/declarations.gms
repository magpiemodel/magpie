*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

parameters
 im_wat_avail(t,wat_src,j)        Water availability (mio. m^3)
;

variables 
  v43_watavail(wat_src,j)         Water available from different sources (mio. m^3)
;

equations
  q43_water(j)                    Local seasonal water constraints (mio. m^3)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov43_watavail(t,wat_src,j,type) Water available from different sources (mio. m^3)
 oq43_water(t,j,type)            Local seasonal water constraints (mio. m^3)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################

