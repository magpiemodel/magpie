*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

parameters
 im_maccs_mitigation(t,i,emis_source,pollutants)     Technical mitigation of GHG emissions (percent)
;

positive variables
 vm_maccs_costs(i)        Costs of technical mitigation of GHG emissions (mio. USD95MER per yr)
;


*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_maccs_costs(t,i,type) Costs of technical mitigation of GHG emissions (mio. USD95MER per yr)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
