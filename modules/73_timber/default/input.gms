*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


$setglobal c73_wood_scen  default
* options default, construction
$setglobal c73_build_demand  BAU
* options BAU, 10pc, 50pc, 90pc

scalars
  s73_timber_prod_cost_wood            Cost for producing one unit of wood (USD17MER per m3) / 89 /
  s73_timber_prod_cost_woodfuel        Cost for producing one unit of woodfuel (USD17MER per m3) / 44 /
  s73_free_prod_cost                   Very high cost for settling demand without production (USD17MER per tDM) / 1e+06 /
  s73_timber_demand_switch             Logical switch to turn on or off timber demand 1=on 0=off (1) / 1 /
  s73_income_threshold                 Threshold for income-elastic industrial roundwood demand (USD17PPP per cap per yr) / 10000 /
  s73_residue_ratio                    Proportion of timber harvest recoverable as logging residues such as branches and tops (1) / 0.15 /
  s73_residue_removal_cost             Cost of removing residues left after industrial roundwood harvest (USD17MER per tDM) / 2.7 /
  s73_expansion                        Construction wood demand expansion factor by end of century based on industrial roundwood demand as base (1=100 percent increase) / 0 /
  s73_natveg_cost_premium              Cost premium for natveg timber production relative to plantation (1) / 0.15 /
  s73_woodfuel_stacking_factor         Stacking factor to convert stere to solid m3 (1) / 0.65 /
;

table f73_prod_specific_timber(t_all,iso,total_wood_products) End use timber product demand (mio. m3 per yr)
$ondelim
$include "./modules/73_timber/input/f73_prod_specific_timber.csv"
$offdelim
;

parameter f73_income_elasticity(total_wood_products) Income elasticities of wood products (1)
/
$ondelim
$include "./modules/73_timber/input/f73_income_elasticity.csv"
$offdelim
/
;

table f73_demand_modifier(t_ext,scen_73) Factor diminishing paper use  (1)
$ondelim
$include "./modules/73_timber/input/f73_demand_modifier.csv"
$offdelim
;

table f73_regional_timber_demand(t_all,i,total_wood_products) End use timber product demand (mio. m3 per yr)
$ondelim
$include "./modules/73_timber/input/f73_regional_timber_demand.csv"
$offdelim
;

table f73_construction_wood_demand(t_all,i,pop_gdp_scen09,build_scen) Construction wood demand (mio. tDM)
$ondelim
$include "./modules/73_timber/input/f73_construction_wood_demand.cs3"
$offdelim
;
