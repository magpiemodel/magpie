*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

$setglobal c35_ad_policy  npi
$setglobal c35_aolc_policy  npi
$setglobal c35_shock_scenario  none

$setglobal c35_pot_forest_scenario  cc
*   options:  cc        (climate change)
*             nocc      (no climate change)
*             nocc_hist (no climate change after year defined by sm_fix_cc)

scalars
s35_hvarea Flag for harvested area (0=zero 1=exognous 2=endogneous) / 2 /
s35_hvarea_secdforest annual secdforest harvest rate for s35_hvarea equals 1 (percent per year) / 0 /
s35_hvarea_primforest annual primforest harvest rate for s35_hvarea equals 1 (percent per year) / 0 /
s35_hvarea_other annual other land harvest rate for s35_hvarea equals 1 (percent per year) / 0 /
s35_timber_harvest_cost_secdforest   Cost for harvesting from secondary forest (USD per ha) / 2000/
s35_timber_harvest_cost_other        Cost for harvesting from other land (USD per ha) / 1500 /
s35_timber_harvest_cost_primforest   Cost for harvesting from primary forest (USD per ha) / 3000/
s35_natveg_harvest_shr Constrains the allowed wood harvest from natural vegetation (1=unconstrained) (1) /1/
s35_secdf_distribution Flag for secdf initialization (0=all secondary forest in highest age class 1=Equal distribution among all age classes 2=Poulter distribution from MODIS satellite data) (1) / 2 /
s35_forest_damage Damage simulation in forests (0=none 1=shifting agriculture 2= Damage from shifting agriculture is faded out by c35_forest_damage_end 4= f35_forest_shock scenario) / 2 /
s35_forest_damage_end   Year of forest damage end  (1)              / 2050 /
;

table f35_forest_lost_share(i,driver_source) Share of area damanged by forest fires (1)
$ondelim
$include "./modules/35_natveg/input/f35_forest_lost_share.cs3"
$offdelim
;

table f35_min_land_stock(t_all,j,pol35,pol_stock35) Avoided deforestation and land protection policies [minimum land stock] (Mha)
$ondelim
$include "./modules/35_natveg/input/npi_ndc_ad_aolc_pol.cs3"
$offdelim
;

table f35_forest_shock(t_all, shock_scen) Forest carbon shock scenarios (area share affected per year)
$ondelim
$include "./modules/35_natveg/input/f35_forest_shock.csv"
$offdelim
;

parameter f35_forest_disturbance_share(i) Share of area damanged by forest disturbances (1)
/
$ondelim
$include "./modules/35_natveg/input/f35_forest_disturbance_share.cs4"
$offdelim
/;

parameter f35_pot_forest_area(t_all,j) Potential forest area (mio. ha)
/
$ondelim
$include "./modules/35_natveg/input/pot_forest_area.cs2"
$offdelim
/;

$if "%c35_pot_forest_scenario%" == "nocc" f35_pot_forest_area(t_all,j) = f35_pot_forest_area("y1995",j);
$if "%c35_pot_forest_scenario%" == "nocc_hist" f35_pot_forest_area(t_all,j)$(m_year(t_all) > sm_fix_cc) = f35_pot_forest_area(t_all,j)$(m_year(t_all) = sm_fix_cc);
m_fillmissingyears(f35_pot_forest_area,"j");
