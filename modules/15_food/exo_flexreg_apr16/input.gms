*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

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

table f15_livestock_share(t_all,i,food_scen15)  Share of livestock calories within diet (1)
$ondelim
$include "./modules/15_food/input/f15_livestock_share.csv"
$offdelim;

table f15_vegfruit_share(t_all,i,food_scen15)   Share of vegetable and fruit calories within diet (1)
$ondelim
$include "./modules/15_food/input/f15_vegfruit_share.csv"
$offdelim;

table f15_staples_kcal_structure(t_all,i,kst)     Share of a staple product within total staples (1)
$ondelim
$include "./modules/15_food/input/f15_staples_kcal_structure.cs3"
$offdelim;

table f15_livestock_kcal_structure(t_all,i,kap)   Share of a livestock product within total staples (1)
$ondelim
$include "./modules/15_food/input/f15_livestock_kcal_structure.cs3"
$offdelim;

table f15_household_balance_flow(t_all,i,kall,dm_ge_nr)   Balance flow to take account of inhomogenous products and processes in statistics (Mio t DM)
$ondelim
$include "./modules/15_food/input/f15_household_balanceflow.cs3"
$offdelim;

table f15_nutrition_attributes(t_all,kall,nutrition) nutrition attributes of fooditems dedicated for fooduse (kcal per day or protein in g per day)
$ondelim
$include "./modules/15_food/input/f15_nutrition_attributes.cs3"
$offdelim;
