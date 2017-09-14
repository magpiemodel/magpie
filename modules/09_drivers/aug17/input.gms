
$setglobal c09_pop_scenario  SSP2
*   options:   SSP: "SSP1", "SSP2", "SP3", "SSP4", "SSP5"
*             SRES: "a1", "a2", "b1", "b2"

$setglobal c09_gdp_scenario  SSP2
*   options:   SSP: "SSP1", "SSP2", "SSP3", "SSP4", "SSP5"
*             SRES: "a1", "a2", "b1", "b2"


table f09_gdp_ppp_iso(t_all,iso,gdp_scen09)  GDP per capita (USD 2005 PPP per capita per year)
$ondelim
$include "./modules/09_drivers/input/f09_gdp_ppp_iso.csv"
$offdelim;

table f09_gdp_mer_iso(t_all,iso,gdp_scen09)  GDP per capita (USD 2005 MER per capita per year)
$ondelim
$include "./modules/09_drivers/input/f09_gdp_mer_iso.csv"
$offdelim;

table f09_pop_iso(t_all,iso,pop_scen09) Population (mio people)
$ondelim
$include "./modules/09_drivers/input/f09_pop_iso.csv"
$offdelim;


table f09_development_state(t_all,i,gdp_scen09)  state of developement (function of GDP) as share in low middle and high income
$ondelim
$include "./modules/09_drivers/input/f09_development_state.cs3"
$offdelim;

