*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

$setglobal c35_protect_scenario  WDPA
$setglobal c35_ad_policy  none
$setglobal c35_emis_policy  none

table f35_protect_area(j,prot_type) conservation priority areas [mio. ha]
$ondelim
$include "./modules/35_natveg/input/protect_area.cs3"
$offdelim
;

table f35_min_forest(t_all,j,pol35) npi+indc avoided deforestation policy (minimum forest stock in Mha)
$ondelim
$include "./modules/35_natveg/input/indc_ad_pol.cs3"
$offdelim
;

table f35_min_cstock(t_all,j,pol35) npi+indc emission reduction policy (minimum carbon stock in tC)
$ondelim
$include "./modules/35_natveg/input/indc_emis_pol.cs3"
$offdelim
;
