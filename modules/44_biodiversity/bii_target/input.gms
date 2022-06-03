*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

scalars 
 s44_bii_target					Target value for global BII (1)									/ 0 /
 s44_bii_target_mode			BII target mode (binary)										/ 1 /
 s44_target_year				Year in which the BII target value is reached  (1)				/ 2100 /
 s44_start_year					Start year for interpolation towards BII target value (1) 		/ 2025 /
 s44_cost_bii_missing			Technical costs for missing BII increase (USD per unit of BII)	/ 1000000 /
;


table fm_bii_coeff(bii_class44,potnatveg) Biodiversity Intactness Index coefficients (unitless)
$ondelim
$include "./modules/44_biodiversity/bii_target/input/f44_bii_coeff.cs3"
$offdelim
;

table f44_biome(j,biome44) Share of biome type in each spatial unit (1)
$ondelim
$include "./modules/44_biodiversity/bii_target/input/biorealm_biome.cs3"
$offdelim
;
