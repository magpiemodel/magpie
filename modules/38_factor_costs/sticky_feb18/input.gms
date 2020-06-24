*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

scalars

* based on gtap7 share of capital in factor costs
* with factor costs excluding land rent and agricultural inputs
  s38_capital_cost_share capital cost share (share of costs) / 0.46 /
* depreciation rate assuming roughly 20 years linear depreciation for invesment goods
  s38_depreciation_rate depreciation rate (share of costs)  / 0.05 /
* years a farmer can delay an investment to facilitate switching from one crop to another
  s38_investment_flexibility possible delay of investments (years) / 5 /
* Share of immobile capital in perennial and yearly crops.
  s38_immobile_perennials  immobile capital in perennial crops (share) / 0.7 /
  s38_immobile  immobile capital in yearly crops (share) / 0.7 /
  s38_mi_start global management intensity in 1995 /0.47/
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
