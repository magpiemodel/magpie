*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de



*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov36_employment(t,i,"marginal")       = v36_employment.m(i);
 ov36_employment_maccs(t,i,"marginal") = v36_employment_maccs.m(i);
 oq36_employment(t,i,"marginal")       = q36_employment.m(i);
 oq36_employment_maccs(t,i,"marginal") = q36_employment_maccs.m(i);
 ov36_employment(t,i,"level")          = v36_employment.l(i);
 ov36_employment_maccs(t,i,"level")    = v36_employment_maccs.l(i);
 oq36_employment(t,i,"level")          = q36_employment.l(i);
 oq36_employment_maccs(t,i,"level")    = q36_employment_maccs.l(i);
 ov36_employment(t,i,"upper")          = v36_employment.up(i);
 ov36_employment_maccs(t,i,"upper")    = v36_employment_maccs.up(i);
 oq36_employment(t,i,"upper")          = q36_employment.up(i);
 oq36_employment_maccs(t,i,"upper")    = q36_employment_maccs.up(i);
 ov36_employment(t,i,"lower")          = v36_employment.lo(i);
 ov36_employment_maccs(t,i,"lower")    = v36_employment_maccs.lo(i);
 oq36_employment(t,i,"lower")          = q36_employment.lo(i);
 oq36_employment_maccs(t,i,"lower")    = q36_employment_maccs.lo(i);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################

