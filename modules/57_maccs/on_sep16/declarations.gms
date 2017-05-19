*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

parameters
 im_maccs_mitigation(t,i,emis_source,pollutants)     technical mitigation of GHG emissions (percent reduction)
 p57_maccs_costs_integral(t,i,emis_source,pollutants)     costs of technical mitigation ($ per ton C)
 i57_mac_step(t,i)                                         helper to map CO2 prices and maccs_steps
;

equations
 q57_total_costs(i)                         calculation of total costs of technical mitigation
;

positive variables
 vm_maccs_costs(i)                           costs of technical mitigation of GHG emissions (mio US$2004)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_maccs_costs(t,i,type)   costs of technical mitigation of GHG emissions (mio US$2004)
 oq57_total_costs(t,i,type) calculation of total costs of technical mitigation
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
