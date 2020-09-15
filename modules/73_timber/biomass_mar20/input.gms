*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

scalars
  s73_timber_prod_cost      Cost for produccing a unit of timber (USD per tDM) / 2000/
  s73_timber_harvest_cost   Cost for harvesting timber (USD per ha) / 2000/
  s73_cost_multiplier       Multiplier for expensive harvest in natural vegetation (1) /1.5/
  s73_free_prod_cost        Very high cost for using non existing land for plantation establishment (USD per tDM) /1000000/
  s73_demand_switch         Logical switch to turn on or off timber demand 1=on 0=off (1)     / 0 /
  s73_foresight				      Boolean switch for establishment demand assumption 1=forward looking 0=myopic (1) / 0 /
;

table f73_prod_specific_timber(t_past,iso,total_wood_products) End use timber product demand (mio. m3 per yr)
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

parameter f73_volumetric_conversion(kforestry) Income elasticities of wood products (1)
/
$ondelim
$include "./modules/73_timber/input/f73_volumetric_conversion.csv"
$offdelim
/
;
