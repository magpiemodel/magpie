*** |  (C) 2008-2022 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 oq22_min_forest(t,j,"marginal") = q22_min_forest.m(j);
 oq22_min_other(t,j,"marginal")  = q22_min_other.m(j);
 oq22_min_forest(t,j,"level")    = q22_min_forest.l(j);
 oq22_min_other(t,j,"level")     = q22_min_other.l(j);
 oq22_min_forest(t,j,"upper")    = q22_min_forest.up(j);
 oq22_min_other(t,j,"upper")     = q22_min_other.up(j);
 oq22_min_forest(t,j,"lower")    = q22_min_forest.lo(j);
 oq22_min_other(t,j,"lower")     = q22_min_other.lo(j);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################

