*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

scalars 
 s44_bii_start_year				blub (1) 							/ 2025 /
 s44_bii_change_annual			blub (1) 							/ 0.00015 /
 s44_bii_max_lower_bound		blub (1) 							/ 0.9 /
 s44_bii_mode					blub (1)							/ 1 /
;



table fm_bii_coeff(bii_class44,potnatveg) Biodiversity Intactness Index coefficients (unitless)
$ondelim
$include "./modules/44_biodiversity/bv_btc_mar21/input/f44_bii_coeff.cs3"
$offdelim
;

parameters
f44_rr_layer(j) Range-rarity restoration prioritization layer (unitless)
/
$ondelim
$include "./modules/44_biodiversity/bv_btc_mar21/input/rr_layer.cs2"
$offdelim
/
