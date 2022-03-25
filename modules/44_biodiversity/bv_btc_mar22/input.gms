*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

scalars 
 s44_price_bii_loss		Price for biodiversity loss (USD per index point)  / 2000 / 
 s44_index_conversion 	Conversion factor / 100 /
 s44_start_year			Start year for linear interpolation (1) 	/ 2025 /
 s44_end_year			End year for linear interpolation (1)		/ 2050 /
 s44_start_value		Start value for linear interpolation (1) 	/ 0 /
 s44_target_value		Target value for linear interpolation (1) 	/ 1 /
;

table fm_bii_coeff(bii_class44,potnatveg) bii coeff (unitless)
$ondelim
$include "./modules/44_biodiversity/bv_btc_mar22/input/f44_bii_coeff.cs3"
$offdelim
;

parameters
f44_rr_layer(j) range rarity layer (unitless)
/
$ondelim
$include "./modules/44_biodiversity/bv_btc_mar22/input/rr_layer.cs2"
$offdelim
/
