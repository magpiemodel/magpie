$setglobal c15_food_scenario  SSP2
*   options:   SSP: "SSP1", "SSP2", "SSP3", "SSP4", "SSP5"
*             SRES: "A1", "A2", "B1", "B2"
*            OTHER: "SSP1_boundary", "SSP2_boundary", "SSP3_boundary", "SSP4_boundary", "SSP5_boundary"

$setglobal c15_pop_scenario  pop_SSP2
*   options:   SSP: "pop_SSP1", "pop_SSP2", "pop_SSP3", "pop_SSP4", "pop_SSP5"
*             SRES: "pop_a1", "pop_a2", "pop_b1", "pop_b2"

$setglobal c15_gdp_scenario  gdp_SSP2
*   options:   SSP: "gdp_SSP1", "gdp_SSP2", "gdp_SSP3", "gdp_SSP4", "gdp_SSP5"
*             SRES: "gdp_a1", "gdp_a2", "gdp_b1", "gdp_b2"


table f15_gdp_iso(t_all,iso,gdp_scen15)  GDP per capita (USD 2005 MER per capita per year)
$ondelim
$include "./modules/15_food/input/f15_gdp_iso.csv"
$offdelim;

table f15_pop_iso(t_all,iso,pop_scen15) Population (mio people)
$ondelim
$include "./modules/15_food/input/f15_pop_iso.csv"
$offdelim;


table f15_development_state(t_all,i,gdp_scen15)  state of developement (function of GDP) as share in low middle and high income
$ondelim
$include "./modules/15_food/input/fm_development_state.cs3"
$offdelim;

table f15_kcal_pc(t_all,i,food_scen15) Per capita calories (kcal per capita per day)
$ondelim
$include "./modules/15_food/input/f15_kcal_pc.csv"
$offdelim;
*i16_kcal_pc(t,i) = f16_kcal_pc(t,i,"%c16_demand_scenario%")

table f15_livestock_share(t_all,i,food_scen15)  Share of livestock calories within diet (1)
$ondelim
$include "./modules/15_food/input/f15_livestock_share.csv"
$offdelim;
*i16_livestock_share(t,i) = f16_livestock_share(t,i,"%c16_demand_scenario%")

table f15_vegfruit_share(t_all,i,food_scen15)   Share of vegetable and fruit calories within diet (1)
$ondelim
$include "./modules/15_food/input/f15_vegfruit_share.csv"
$offdelim;
*i16_vegfruit_share(t,i) = f16_vegfruit_share(t,i,"%c16_demand_scenario%")

table f15_staples_kcal_structure(t_all,i,kst)     Share of a staple product within total staples (1)
$ondelim
$include "./modules/15_food/input/f15_staples_kcal_structure.cs3"
$offdelim;
*i16_staples_kcal_structure(t,i,kst) = f16_staples_kcal_structure(t,i,kst,"%c16_demand_scenario%")

table f15_livestock_kcal_structure(t_all,i,kap)   Share of a livestock product within total staples (1)
$ondelim
$include "./modules/15_food/input/f15_livestock_kcal_structure.cs3"
$offdelim;
*i16_livestock_kcal_structure(t,i,kli) = f16_livestock_kcal_structure(t,i,kli,"%c16_demand_scenario%")

table f15_household_balance_flow(t_all,i,kall,dm_ge_nr)   Balance flow to take account of inhomogenous products and processes in statistics (Mio t DM)
$ondelim
$include "./modules/15_food/input/f15_household_balanceflow.cs3"
$offdelim;

table f15_nutrition_attributes(t_all,kall,nutrition) nutrition attributes of fooditems dedicated for fooduse (million kcal or protein per ton DM)
$ondelim
$include "./modules/15_food/input/f15_nutrition_attributes.cs3"
$offdelim;

*** Food Demand Model



table f15_staples_kcal_structure_iso(t_all,iso,kst)     Share of a staple product within total staples (1)
$ondelim
$include "./modules/15_food/input/f15_staples_kcal_structure_iso.cs3"
$offdelim;
*i16_staples_kcal_structure(t,i,kst) = f16_staples_kcal_structure(t,i,kst,"%c16_demand_scenario%")

table f15_livestock_kcal_structure_iso(t_all,iso,kap)   Share of a livestock product within total staples (1)
$ondelim
$include "./modules/15_food/input/f15_livestock_kcal_structure_iso.cs3"
$offdelim;
*i16_livestock_kcal_structure(t,i,kli) = f16_livestock_kcal_structure(t,i,kli,"%c16_demand_scenario%")

parameter f15_prices_initial(kall) Food prices in initialisation period (USD05 per ton DM)
/
$ondelim
$include "./modules/15_food/input/f15_prices_initial.csv"
$offdelim
/;


parameter f15_price_index(t_all) Food prices in initialisation period (USD05 per ton DM)
/
$ondelim
$include "./modules/15_food/input/f15_prices_index.csv"
$offdelim
/;

*** EOF input.gms ***
