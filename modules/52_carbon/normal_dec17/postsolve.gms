*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 oq52_emis_co2_actual(t,i,emis_oneoff,"marginal") = q52_emis_co2_actual.m(i,emis_oneoff);
 oq52_emis_co2_actual(t,i,emis_oneoff,"level")    = q52_emis_co2_actual.l(i,emis_oneoff);
 oq52_emis_co2_actual(t,i,emis_oneoff,"upper")    = q52_emis_co2_actual.up(i,emis_oneoff);
 oq52_emis_co2_actual(t,i,emis_oneoff,"lower")    = q52_emis_co2_actual.lo(i,emis_oneoff);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################

