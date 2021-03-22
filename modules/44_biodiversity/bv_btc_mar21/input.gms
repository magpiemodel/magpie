*** (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

$setglobal c44_price_bv_loss  p0


table fm_bii_coeff(bii_class44,potnatveg) bii coeff
$ondelim
$include "./modules/44_biodiversity/bv_btc_mar21/input/f44_bii_coeff.cs3"
$offdelim
;

table f44_price_bv_loss(t_all,price_biodiv44) price biodiv loss
$ondelim
$include "./modules/44_biodiversity/bv_btc_mar21/input/f44_price_biodiv_loss.csv"
$offdelim
;

parameters
f44_rr_layer(j) range rarity layer
/
$ondelim
$include "./modules/44_biodiversity/bv_btc_mar21/input/rr_layer.cs2"
$offdelim
/
