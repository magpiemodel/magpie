*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

scalars
 s57_step_length										Step length in MACC data (yr)
;

parameters
 im_maccs_mitigation(t,i,emis_source,pollutants)        Technical mitigation of GHG emissions (percent)
 i57_mac_step_n2o(t,i)                                  Helper to map N2O prices and maccs_steps (1)
 i57_mac_step_ch4(t,i)                                  Helper to map CH4 prices and maccs_steps (1)
 p57_maccs_costs_integral(t,i,emis_source,pollutants)   Costs of technical mitigation (USD95MER per Tg N CH4 C)
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
