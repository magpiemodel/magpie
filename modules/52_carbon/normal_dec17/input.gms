*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

scalar
 s52_forestry_plantation switch for using natveg (0) or plantation (1) growth curves for afforestation in forestry module / 1 /
;

$setglobal c52_carbon_scenario  nocc
*   options:   cc  (climate change)
*             nocc (no climate change)

$setglobal c52_carbon_switch  default_lpjml
*   options:  default_lpjml  (old lpj data)
*             lpjml4 (new lpj data)

$if "%c52_carbon_switch%" == "default_lpjml" table fm_carbon_density(t_all,j,land,c_pools) LPJmL carbon density for land and carbon pools (tC per ha)
$if "%c52_carbon_switch%" == "default_lpjml" $ondelim
$if "%c52_carbon_switch%" == "default_lpjml" $include "./modules/52_carbon/input/lpj_carbon_stocks.cs3"
$if "%c52_carbon_switch%" == "default_lpjml" $offdelim
$if "%c52_carbon_switch%" == "default_lpjml" ;

$if "%c52_carbon_switch%" == "lpjml4" table fm_carbon_density(t_all,j,land,c_pools) LPJmL carbon density for land and carbon pools (tC per ha)
$if "%c52_carbon_switch%" == "lpjml4" $ondelim
$if "%c52_carbon_switch%" == "lpjml4" $include "./modules/52_carbon/input/lpj_carbon_stocks_LPJ4.cs3"
$if "%c52_carbon_switch%" == "lpjml4" $offdelim
$if "%c52_carbon_switch%" == "lpjml4" ;

$if "%c52_carbon_scenario%" == "nocc" fm_carbon_density(t_all,j,land,c_pools) = fm_carbon_density("y1995",j,land,c_pools);
m_fillmissingyears(fm_carbon_density,"j,land,c_pools");

parameter fm_growth_par(clcl,chap_par,type52) Parameters for chapman-richards equation (1)
/
$ondelim
$include "./modules/52_carbon/input/f52_growth_par.csv"
$offdelim
/
;
