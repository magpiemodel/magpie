*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de



table f20_processing_balanceflow(t_all,i,ksd) Processing balance flow  (mio. tDM)
$ondelim
$include "./modules/20_processing/coupleproducts_feb17/input/f20_processing_balanceflow.cs3"
$offdelim

table f20_processing_conversion_factors(t_all,processing20,ksd,kpr) Conversion factors of primary products into secondary products (1)
$ondelim
$include "./modules/20_processing/coupleproducts_feb17/input/f20_processing_conversion_factors.cs3"
$offdelim       ;

table f20_processing_shares(t_all,i,ksd,kpr)   Shares of secondary products coming from a primary product (1)
$ondelim
$include "./modules/20_processing/coupleproducts_feb17/input/f20_processing_shares.cs3"
$offdelim       ;

table f20_processing_unitcosts(ksd,kpr)   Costs of transforming x units kpr into 1 unit ksd (USD05MER per tDM)
$ondelim
$include "./modules/20_processing/coupleproducts_feb17/input/f20_processing_unitcosts.cs3"
$offdelim       ;
