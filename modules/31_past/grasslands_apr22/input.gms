*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


scalars
  s31_cost_expansion   Grasslands expansion costs (USD05MER per hectare)          / 1 /
  s31_cost_grass_prod  Grasslands factor costs (USD05MER per tDM)                 / 1 /
;

$setglobal c31_grassl_yld_scenario  cc
*   options:  cc        (climate change)
*             nocc      (no climate change)
*             nocc_hist (no climate change after year defined by sm_fix_cc)

parameter f31_pastr_suitability(t_all,j) Areas suitable for pasture management (mio. ha)
/
$ondelim
$include "./modules/31_past/input/f31_pastr_suitability.cs2"
$offdelim
/;

i31_manpast_suit(t_all,j) = f31_pastr_suitability(t_all,j)
* set values to 1995 if nocc scenario is used, or to sm_fix_cc after sm_fix_cc if nocc_hist is used
$if "%c31_grassl_yld_scenario%" == "nocc" i31_manpast_suit(t_all,j) = f31_pastr_suitability("y1995",j);
$if "%c31_grassl_yld_scenario%" == "nocc_hist" i31_manpast_suit(t_all,j)$(m_year(t_all) > sm_fix_cc) = i31_manpast_suit(t_all,j)$(m_year(t_all) = sm_fix_cc);


scalar s31_limit_calib   Relative managament calibration switch (1=limited 0=pure relative) / 1 /;


table f31_grassl_yld(t_all,j,grassland,w) LPJmL potential yields per cell (rainfed only) (tDM per ha)
$ondelim
$include "./modules/31_past/input/f31_grassl_yld.cs3"
$offdelim
;
* set values to 1995 if nocc scenario is used, or to sm_fix_cc after sm_fix_cc if nocc_hist is used
$if "%c31_grassl_yld_scenario%" == "nocc" f31_grassl_yld(t_all,j,grassland,w) = f31_grassl_yld("y1995",j,grassland,w);
$if "%c31_grassl_yld_scenario%" == "nocc_hist" f31_grassl_yld(t_all,j,grassland,w)$(m_year(t_all) > sm_fix_cc) = f31_grassl_yld(t_all,j,grassland,w)$(m_year(t_all) = sm_fix_cc);


table f31_grass_bio(t_all,i, grassland) Estimated regional grass biomass consumption in the past (tDM)
$ondelim
$include "./modules/31_past/input/f31_grass_bio_hist.cs3"
$offdelim;



table f31_LUH2v2(t_all,j, f31_luh) LUH2v2 land classes separating rangelands from managed pastures
$ondelim
$include "./modules/31_past/input/f31_LUH2v2.cs3"
$offdelim;
