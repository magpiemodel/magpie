*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

$setglobal c35_protect_scenario  WDPA
$setglobal c35_ad_policy  npi
$setglobal c35_aolc_policy  npi

scalars
s35_selective_logging_flag Flag for turning of selective logging in percentage. One equals clearcut   / 1 /
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

table f35_ageclass_area(j,ac_poulter) Forest age class area (Mha)
$ondelim
$include "./modules/35_natveg/input/f35_forestageclasses.cs3"
$offdelim
;
