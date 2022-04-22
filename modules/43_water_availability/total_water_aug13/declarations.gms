*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

parameters
 im_wat_avail(t,wat_src,j)        Water availability (mio. m^3 per yr)
 p43_exo_wat_req(t_all,j)         Water demand at the time of initialization (mio. m^3 per yr)
 i43_crop_area(t_all,j,w,kcr)    Input parameter to capture crop area at the time of initialization (mio. ha)
;

variables
  v43_watavail(wat_src,j)         Water available from different sources (mio. m^3 per yr)
;

equations
  q43_water(j)                    Local seasonal water constraints (mio. m^3 per yr)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov43_watavail(t,wat_src,j,type) Water available from different sources (mio. m^3 per yr)
 oq43_water(t,j,type)            Local seasonal water constraints (mio. m^3 per yr)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
