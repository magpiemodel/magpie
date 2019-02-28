*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

parameters
 im_maccs_mitigation(t,i,emis_source,pollutants)        Technical mitigation of GHG emissions (percent)
 i57_mac_step_n2o(t,i)                                  Helper to map C prices and maccs_steps (1)
 i57_mac_step_ch4(t,i)                                  Helper to map C prices and maccs_steps (1)
 p57_maccs_costs_n2o(t,i)     							Costs of technical N emission abatement (USD95MER per Tg N)
 p57_maccs_costs_CH4(t,i)     							Costs of technical CH4 emission abatement (USD95MER per Tg CH4)
;

equations
 q57_total_costs(i)  Calculation of total costs of technical mitigation (mio. USD95MER per yr)
;

positive variables
 vm_maccs_costs(i)   Costs of technical mitigation of GHG emissions (mio. USD95MER per yr)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_maccs_costs(t,i,type)   Costs of technical mitigation of GHG emissions (mio. USD95MER per yr)
 oq57_total_costs(t,i,type) Calculation of total costs of technical mitigation (mio. USD95MER per yr)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
