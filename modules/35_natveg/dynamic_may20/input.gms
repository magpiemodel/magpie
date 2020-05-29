*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

$setglobal c35_protect_scenario  WDPA
$setglobal c35_ad_policy  npi
$setglobal c35_aolc_policy  npi

scalars
s35_natveg_harvest_shr Constrains the allowed wood harvest from natural vegetation (share of natveg area in each cell) 1 equals to no constraint /1/
s35_secdf_distribution Flag for secdf initialization (0 = all secondary forest in highest acx 1 = Equal distribution among all age classes) /0/
;

table f35_protect_area(j,prot_type) Conservation priority areas (mio. ha)
$ondelim
$include "./modules/35_natveg/input/protect_area.cs3"
$offdelim
;

table f35_min_land_stock(t_all,j,pol35,pol_stock35) Land protection policies [minimum land stock] (Mha)
$ondelim
$include "./modules/35_natveg/input/npi_ndc_ad_aolc_pol.cs3"
$offdelim
;
