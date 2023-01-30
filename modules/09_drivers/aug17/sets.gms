*** |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

sets
   pop_gdp_scen09  Population and GDP scenario
       / SSP1, SSP2, SSP3, SSP4, SSP5,
         SDP, SDP_EI,	SDP_MC,	SDP_RC,	SSP2EU,
         a1, a2, b1, b2 /

  pal_scen09  Physical activity level scenario
       / SSP1, SSP2, SSP3, SSP4, SSP5 /

  demography_scen09  Demography scenario
       / SSP1, SSP2, SSP3, SSP4, SSP5 /

   age Population age groups
       / 0--4, 5--9,   10--14, 15--19,
       20--24, 25--29, 30--34, 35--39,
       40--44, 45--49, 50--54, 55--59,
       60--64, 65--69, 70--74, 75--79
       80--84, 85--89, 90--94, 95--99, 100+ /

   sex Sex groups
       /M, F/

  pop_structure(demography_scen09,pop_gdp_scen09) Mapping between demography and population scenarios
       /
       SSP1        . (SSP1, SDP, SDP_EI, SDP_MC, SDP_RC)
       SSP2        . (SSP2, SSP2EU)
       SSP3        . (SSP3)
       SSP4        . (SSP4)
       SSP5        . (SSP5)
       /
;
