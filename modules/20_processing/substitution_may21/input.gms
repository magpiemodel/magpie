*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

$setglobal c20_scp_type  sugar

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
$include "./modules/20_processing/substitution_may21/input/f20_quality_cost.cs3"
$offdelim       ;

table  f20_scp_type_shr(scptype,scen20)  selected scenario values for scp type (1)
$ondelim
$include "./modules/20_processing/input/f20_scp_type_shr.csv"
$offdelim;

table f20_scp_processing_shares(kpr,scen20) Feedstock processing shares for SCP in different scenarios (1)
$ondelim
$include "./modules/20_processing/input/f20_scp_processing_shares.csv"
$offdelim;

parameter f20_scp_unitcosts(scptype) Costs of production of one unit of SCP exclusive of feedstock costs (USD per tDM)
/
$ondelim
$include "./modules/20_processing/input/f20_scp_unitcosts.csv"
$offdelim
/;
