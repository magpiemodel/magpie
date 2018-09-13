*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

scalars

s42_reserved_fraction  Fraction of available water that is reserved for industry electricity and domestic use (1) / 0.5 /

s42_irrig_eff_scenario     Scenario for irrigation efficiency     (1)       / 1 /
*                                      1: global static value
*                                      2: regional static values from CS
*                                      3: gdp driven increase

s42_irrigation_efficiency              Value of irrigation efficiency       (1)        / 0.66 /
*                                      Only if global static value is requested

s42_env_flow_scenario              EFP scenario.     (1)          / 2 /
*                                  0: don't consider environmental flows.
*                                                                          s42_env_flow_base_fraction and
*                                                                          s42_env_flow_fraction have no effect.
*                                  1: Reserve a certain fraction of available water
*                                     specified by s42_env_flow_fraction for
*                                     environmental flows.
*                                  2: Each grid cell receives its own value for
*                                     environmental flow protection based on LPJ
*                                     results and a calculation algorithm by Smakhtin 2004.
*                                                                          s42_env_flow_fraction has no effect.

s42_env_flow_base_fraction         Fraction of available water that is reserved for the environment where no EFP policy is implemented (1) / 0.05 /
* 									(determined in the file EFR_protection_policy.csv)
s42_env_flow_fraction              Fraction of available water that is reserved for under protection policies (1) / 0.2 /
;

$setglobal c42_watdem_scenario  nocc
*   options:   cc  (climate change)
*             nocc (no climate change)


table f42_wat_req_kve(t_all,j,kve) LPJmL annual water demand for irrigation per ha (m^3 per yr)
$ondelim
$include "./modules/42_water_demand/input/lpj_airrig.cs2"
$offdelim
;
$if "%c42_watdem_scenario%" == "nocc" f42_wat_req_kve(t_all,j,kve) = f42_wat_req_kve("y1995",j,kve);
m_fillmissingyears(f42_wat_req_kve,"j,kve");


parameter f42_wat_req_kli(kli) Average water requirements of livestock commodities per region per tDM per year (m^3)
/
$ondelim
$include "./modules/42_water_demand/input/f42_wat_req_fao.csv"
$offdelim
/;


parameter f42_env_flows(t_all,j) Environmental flow requirements from LPJ and Smakhtin algorithm (mio. m^3)
/
$ondelim
$include "./modules/42_water_demand/input/lpj_envflow_grper.cs2"
$offdelim
/;
$if "%c42_watdem_scenario%" == "nocc" f42_env_flows(t_all,j) = f42_env_flows("y1995",j);
m_fillmissingyears(f42_env_flows,"j");

$setglobal c42_env_flow_policy  off

table f42_env_flow_policy(t_all,scen42) EFP policies
$ondelim
$include "./modules/42_water_demand/input/f42_env_flow_policy.cs3"
$offdelim
;
