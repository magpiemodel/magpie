*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
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
* 60 EUR/m3 = 72 USD/m3
* 72 USD/m3 / 0.6 = 120 USD/tDM
* https://unece.org/forests/prices
  s73_timber_prod_cost_wood            Cost for producing one unit of wood (USD per tDM) / 120 /
  s73_timber_prod_cost_woodfuel        Cost for prodcing one unit of woodfuel (USD per tDM) / 60 /
  s73_free_prod_cost                   Very high cost for settling demand without production (USD per tDM) / 20000 /
  s73_timber_demand_switch             Logical switch to turn on or off timber demand 1=on 0=off (1) / 1 /
  s73_increase_ceiling                 Limiter for not allowing a demand jump between time steps beyond a certain limit (1) / 1.025 /
  s73_residue_ratio                    Proportion of overall industrial roundwood production which ends up as residue during harvest (1) / 0.15 /
  s73_reisdue_removal_cost             Cost of removing residues left after industrial roundwood harvest (USD per tDM) / 2 /
  s73_expansion                        Construction wood demand expansion factor by end of century based on industrial roundwood demand as base (1=100 percent increase) / 0 /
;

** Residue numbers from
** "Spatially explicit assessment of roundwood and logging residues availability and costs for the EU28"
** "The total potential volume of logging residues in the “Reference scenario” is estimated to be 79 Mm3, corresponding to 13.5% of the roundwood potential volume. "

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

parameter f73_volumetric_conversion(kforestry) Volumetric conversion from mio t to m3 of wood (1)
/
$ondelim
$include "./modules/73_timber/input/f73_volumetric_conversion.csv"
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
