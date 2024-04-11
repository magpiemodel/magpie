*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

Scalar s51_snupe_base assumption on implicit SNuPE in ipcc guidelines (1) / 0.5 /;
Scalar s51_nue_pasture_base assumption on implicit SNuPE in ipcc guidelines (1) / 0.5 /;

table f51_ipcc_ef(ipcc_ef51,emis_uncertainty51) ipcc emission factors for various emission types X (tX-N per tN)
$ondelim
$include "./modules/51_nitrogen/rescaled_jan21/input/f51_ipcc_ef.csv"
$offdelim
;

table f51_ef_n_soil(t_all,i,n_pollutants_direct,emis_source_n_cropsoils51) ipcc emission factors for various emission types X (tX-N per tN)
$ondelim
$include "./modules/51_nitrogen/rescaled_jan21/input/f51_ef_n_soil_reg.cs3"
$offdelim
;

parameter f51_ef3_confinement(i,kli,awms_conf,n_pollutants_direct) emissions from manure managed in confinement for various emission types X (tX-N per tN)
/
$ondelim
$include "./modules/51_nitrogen/rescaled_jan21/input/f51_ef3_confinement.cs4"
$offdelim
/
;

parameter f51_ef3_prp(i,n_pollutants_direct,kli) emissions from manure on pasture range and paddocks for various emission types X (tX-N per tN)
/
$ondelim
$include "./modules/51_nitrogen/rescaled_jan21/input/f51_ef3_prp.cs4"
$offdelim
/;

parameter f51_ef_resid_burn(n_pollutants_direct) emission factor for residual burning (tX-N per t DM)
/
$ondelim
$include "./modules/51_nitrogen/rescaled_jan21/input/f51_ef_resid_burn.cs4"
$offdelim
/;
