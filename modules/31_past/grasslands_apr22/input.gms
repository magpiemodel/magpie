*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


scalars
  s31_cost_expansion   Grasslands expansion costs (USD05MER per hectare)          / 1 /
  s31_cost_grass_prod  Grasslands factor costs (USD05MER per tDM)                 / 1 /
;

$setglobal c31_past_suit_scen  ssp370

table f31_pastr_suitability(t_all,j,ssp_past) Areas suitable for pasture management (mio. ha)
$ondelim
$include "./modules/31_past/input/f31_pastr_suitability.cs3"

$offdelim
;

table f31_LUH2v2(t_all,j,f31_luh) Different land type areas (mio. ha)
$ondelim
$include "./modules/31_past/input/f31_LUH2v2.cs3"
$offdelim
;

scalar s31_limit_calib   Relative managament calibration switch (1=limited 0=pure relative) / 1 /;

table f31_grassl_yld(t_all,j,grassland,w) LPJmL potential yields per cell (rainfed only) (tDM per ha)
$ondelim
$include "./modules/31_past/input/f31_grassl_yld.cs3"
$offdelim
;

table f31_grass_bio(t_all,i, grassland) Estimated regional grass biomass consumption in the past (tDM)
$ondelim
$include "./modules/31_past/input/f31_grass_bio_hist.cs3"
$offdelim;
