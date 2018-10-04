*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

parameters
 im_maccs_mitigation(t,i,emis_source,pollutants)          technical mitigation of GHG emissions (1 per 100)
 p57_maccs_costs_integral(t,i,emis_source,pollutants)     costs of technical mitigation (USD95MER per tC)
 i57_mac_step(t,i)                                        helper to map CO2 prices and maccs_steps (1)
;

equations
 q57_total_costs(i)  calculation of total costs of technical mitigation (mio.USD95MER per yr)
;

positive variables
 vm_maccs_costs(i)   costs of technical mitigation of GHG emissions (mio. USD95MER per yr)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_maccs_costs(t,i,type)   costs of technical mitigation of GHG emissions (mio. USD95MER per yr)
 oq57_total_costs(t,i,type) calculation of total costs of technical mitigation (mio.USD95MER per yr)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
