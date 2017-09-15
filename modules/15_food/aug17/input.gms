$setglobal c15_food_scenario  SSP2
*   options:   SSP: "SSP1", "SSP2", "SSP3", "SSP4", "SSP5"
*             SRES: "A1", "A2", "B1", "B2"
*            OTHER: "SSP1_boundary", "SSP2_boundary", "SSP3_boundary", "SSP4_boundary", "SSP5_boundary"

$setglobal c15_calibscen  fadeout2050
*   options:   fadeout2050

$setglobal c15_rumscen  halving2050
*   options:   constant, halving2050

scalar s15_elastic_demand  / 0 /
*   options : 0(exogenous demand), 1(elastic demand)

table f15_household_balance_flow(t_all,i,kall,dm_ge_nr)   Balance flow to take account of inhomogenous products and processes in statistics (Mio t DM)
$ondelim
$include "./modules/15_food/input/f15_household_balanceflow.cs3"
$offdelim;

table f15_nutrition_attributes(t_all,kall,nutrition) nutrition attributes of fooditems dedicated for fooduse (million kcal or protein per ton DM)
$ondelim
$include "./modules/15_food/input/f15_nutrition_attributes.cs3"
$offdelim;


*** Food Demand Model

table f15_kcal_pc_iso(t_all,iso,kfo)  Observed per-capita calories in the past (kcal per captia per day)
$ondelim
$include "./modules/15_food/input/f15_kcal_pc_iso.csv"
$offdelim;


parameter f15_prices_initial(kall) Food prices in initialisation period (USD05 per ton DM)
/
$ondelim
$include "./modules/15_food/input/f15_prices_initial.csv"
$offdelim
/;


parameter f15_price_index(t_all) Food prices index in initialisation period (USD05 per ton DM)
/
$ondelim
$include "./modules/15_food/input/f15_prices_index.csv"
$offdelim
/;


table f15_kcal_balanceflow_fadeout(t_all,calibscen15)
$ondelim
$include "./modules/15_food/input/f15_kcal_balanceflow_fadeout.csv"
$offdelim
;

table f15_ruminant_fadeout(t_all,ruminantfadeoutscen15)
$ondelim
$include "./modules/15_food/input/f15_ruminant_fadeout.csv"
$offdelim
;


*** EOF input.gms ***
