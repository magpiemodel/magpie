*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

scalars


*' share of capital in the factor costs are based on the AgTFP Agricultural total factor productivity document by the USDA
*'http://www.ers.usda.gov/data-products/international-agricultural-productivity.aspx
s38_capital_cost_share capital cost share (share of costs) / 0.46 /
*' depreciation rate assuming roughly 20 years linear depreciation for invesment goods
s38_depreciation_rate depreciation rate (share of costs)  / 0.05 /
*' Share of immobile capital.
s38_immobile  immobile capital in perennial crops (share) / 0.7 /
*' Initial management intensity
s38_mi_start global management intensity in 1995 /0.47/
*' Maximum fraction of the total gdp invested in capital in agriculture
s38_fraction_gdp maximum percentage of the overall GDP /0.15/
;

parameter f38_fac_req_per_ton(kcr) Factor requirements (US$05 per ton DM)
/
$ondelim
$include "./modules/38_factor_costs/input/f38_fac_req_per_ton.csv"
$offdelim
/
;

table f38_region_yield(i,kcr) Regional crop yields (tDM per ha)
$ondelim
$include "./modules/38_factor_costs/sticky_feb18/input/f38_region_yield.csv"
$offdelim;

table f38_fac_req(kcr,w) Factor requirement costs (USD05MER per tDM)
$ondelim
$include "./modules/38_factor_costs/input/f38_fac_req.csv"
$offdelim;
