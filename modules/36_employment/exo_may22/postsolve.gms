*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de



*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov36_labor_costs(t,i,kall,"marginal") = v36_labor_costs.m(i,kall);
 ov36_employment(t,i,"marginal")       = v36_employment.m(i);
 oq36_employment(t,i,"marginal")       = q36_employment.m(i);
 oq36_labor_costs(t,i,kall,"marginal") = q36_labor_costs.m(i,kall);
 ov36_labor_costs(t,i,kall,"level")    = v36_labor_costs.l(i,kall);
 ov36_employment(t,i,"level")          = v36_employment.l(i);
 oq36_employment(t,i,"level")          = q36_employment.l(i);
 oq36_labor_costs(t,i,kall,"level")    = q36_labor_costs.l(i,kall);
 ov36_labor_costs(t,i,kall,"upper")    = v36_labor_costs.up(i,kall);
 ov36_employment(t,i,"upper")          = v36_employment.up(i);
 oq36_employment(t,i,"upper")          = q36_employment.up(i);
 oq36_labor_costs(t,i,kall,"upper")    = q36_labor_costs.up(i,kall);
 ov36_labor_costs(t,i,kall,"lower")    = v36_labor_costs.lo(i,kall);
 ov36_employment(t,i,"lower")          = v36_employment.lo(i);
 oq36_employment(t,i,"lower")          = q36_employment.lo(i);
 oq36_labor_costs(t,i,kall,"lower")    = q36_labor_costs.lo(i,kall);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################

