*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


$setglobal c55_scen_conf  ssp2
$setglobal c55_scen_conf_noselect  ssp2
*   options:   SSP: "ssp1", "ssp2", "ssp3", "ssp4", "ssp5", "constant"
*             SRES: "a1", "a2", "b1", "b2"
*             GoodPractice: "GoodPractice"

* Set-switch for countries affected by regional ghg policy
* Default: all iso countries selected
sets
  scen_countries55(iso) countries to be affected by awm scenario / ABW, DEU /
;

parameter f55_awms_recycling_share(i,kli,awms_conf) share of Nr in confinement recycled (tNr per tNr)
/
$ondelim
$include "./modules/55_awms/ipcc2006_aug16/input/f55_awms_recycling_share.cs4"
$offdelim
/
;

parameter f55_awms_shr(t_all,i,scen_conf55,kli,awms_conf) share of Nr in confinement recycled (tNr per tNr)
/
$ondelim
$include "./modules/55_awms/ipcc2006_aug16/input/f55_awms_shr.cs4"
$offdelim
/
;

parameter f55_manure_fuel_shr(t_all,i,kli,gdp_scen09) share of Nr in confinement recycled (tNr per tNr)
/
$ondelim
$include "./modules/55_awms/ipcc2006_aug16/input/f55_manure_fuel_shr.cs4"
$offdelim
/
;
