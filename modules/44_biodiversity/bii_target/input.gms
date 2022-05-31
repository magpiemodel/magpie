*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

scalars 
 s44_bii_start_year				start year for BII target (1)		/ 2025 /
 s44_bii_target					targeted annual change in BII (1) 	/ 0.0002 /
 s44_bii_max_lower_bound		maximum lower bound for BII (1)		/ 0.9 /
 s44_cost_bii_missing			technical costs for missing BII increase (USD per unit of BII)	/ 1000000 /
;



table fm_bii_coeff(bii_class44,potnatveg) Biodiversity Intactness Index coefficients (unitless)
$ondelim
$include "./modules/44_biodiversity/bii_target/input/f44_bii_coeff.cs3"
$offdelim
;

table f44_biome(j,biome44)
$ondelim
$include "./modules/44_biodiversity/bii_target/input/biorealm_biome.cs3"
$offdelim
;
