*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de


*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov43_watavail(t,wat_src,j,"marginal") = v43_watavail.m(wat_src,j);
 oq43_water(t,j,"marginal")            = q43_water.m(j);
 ov43_watavail(t,wat_src,j,"level")    = v43_watavail.l(wat_src,j);
 oq43_water(t,j,"level")               = q43_water.l(j);
 ov43_watavail(t,wat_src,j,"upper")    = v43_watavail.up(wat_src,j);
 oq43_water(t,j,"upper")               = q43_water.up(j);
 ov43_watavail(t,wat_src,j,"lower")    = v43_watavail.lo(wat_src,j);
 oq43_water(t,j,"lower")               = q43_water.lo(j);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################

