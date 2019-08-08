*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de



table f51_ipcc_ef(ipcc_ef51,emis_uncertainty51) ipcc emission factors for various emission types X (tX-N per tN)
$ondelim
$include "./modules/51_nitrogen/input/f51_ipcc_ef.csv"
$offdelim
;

table f51_ef_n_soil(n_pollutants_direct,emis_source_n_cropsoils51) ipcc emission factors for various emission types X (tX-N per tN)
$ondelim
$include "./modules/51_nitrogen/ipcc2006_sep16/input/f51_ef_n_soil.cs3"
$offdelim
;

parameter f51_ef3_confinement(i,kli,awms_conf,n_pollutants_direct) emissions from manure managed in confinement for various emission types X (tX-N per tN)
/
$ondelim
$include "./modules/51_nitrogen/ipcc2006_sep16/input/f51_ef3_confinement.cs4"
$offdelim
/
;

parameter f51_ef3_prp(i,n_pollutants_direct,kli) emissions from manure on pasture range and paddocks for various emission types X (tX-N per tN)
/
$ondelim
$include "./modules/51_nitrogen/ipcc2006_sep16/input/f51_ef3_prp.cs4"
$offdelim
/;
