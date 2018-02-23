*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de



table f51_ipcc_ef(ipcc_ef51,emis_uncertainty51) ipcc emission factors
$ondelim
$include "./modules/51_nitrogen/input/f51_ipcc_ef.csv"
$offdelim
;

table f51_ef_n_soil(n_pollutants_direct,emis_source_n_cropsoils51) ipcc emission factors
$ondelim
$include "./modules/51_nitrogen/ipcc2006_sep16/input/f51_ef_n_soil.cs3"
$offdelim
;

parameter f51_ef3_confinement(i,kli,awms_conf,n_pollutants_direct) emissions from manure managed in confinement (share of Nr)
/
$ondelim
$include "./modules/51_nitrogen/ipcc2006_sep16/input/f51_ef3_confinement.cs4"
$offdelim
/
;

parameter f51_ef3_prp(i,n_pollutants_direct,kli) emissions from manure on pasture range and paddocks (share of Nr)
/
$ondelim
$include "./modules/51_nitrogen/ipcc2006_sep16/input/f51_ef3_prp.cs4"
$offdelim
/;
