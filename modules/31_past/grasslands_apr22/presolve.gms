*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @code

*' Socioeconomic and environmental conditions determine the potential managed pastures
*' areas ('i31_manpast_suit'). 'i31_manpast_suit' is estimated by determining areas
*' with more than five inhabitants per km2 and with aridity greater than 0.5 following
*' the methodology established by @KleinGoldewijk.2017

v31_grass_area.up(j,"pastr") = i31_manpast_suit(t,j);

*' Total grassland area cannot be smaller than legally protected grassland area
vm_land.lo(j,"past") = sum(consv_type, pm_land_conservation(t,j,"past",consv_type));

*' @stop
