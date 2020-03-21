*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de



table f20_processing_balanceflow(t_all,i,ksd) Processing balance flow  (mio. tDM)
$ondelim
$include "./modules/20_processing/input/f20_processing_balanceflow.cs3"
$offdelim       ;

table f20_processing_conversion_factors(t_all,processing20,ksd,kpr) Conversion factors of primary products into secondary products (1)
$ondelim
$include "./modules/20_processing/input/f20_processing_conversion_factors.cs3"
$offdelim       ;

table f20_processing_shares(t_all,i,ksd,kpr)   Shares of secondary products coming from a primary product (1)
$ondelim
$include "./modules/20_processing/input/f20_processing_shares.cs3"
$offdelim       ;

table f20_processing_unitcosts(ksd,kpr)   Costs of transforming x units kpr into 1 unit ksd (USD05MER per tDM)
$ondelim
$include "./modules/20_processing/input/f20_processing_unitcosts.cs3"
$offdelim       ;

table f20_quality_cost(ksd,kpr)   Costs for difference in quality between secondary products from diverging origins (USD per tDM)
$ondelim
$include "./modules/20_processing/substitution_dec18/input/f20_quality_cost.cs3"
$offdelim       ;

table f20_calibration(ksd,kpr)   Additional calibration costs to avoid substitution in historical period (USD05 per tDM)
$ondelim
$include "./modules/20_processing/substitution_dec18/input/f20_calibration.cs3"
$offdelim       ;
