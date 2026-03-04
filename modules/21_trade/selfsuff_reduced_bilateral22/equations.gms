*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' Global production must cover global supply plus calibration balance flows.
*' This ensures that total world production is sufficient to meet all demand,
*' regardless of how trade distributes products across regions.
 q21_trade_glo(k_trade)..
  sum(i2, vm_prod_reg(i2,k_trade)) =g=
  sum(i2, vm_supply(i2,k_trade)) + sum((ct, i2), f21_trade_regional_balanceflow(ct, i2, k_trade));


*' Regional material balance: production within a super-region must cover
*' domestic supply minus imports plus exports, adjusted by calibration balance
*' flows. Imports are the sum of trade flowing into region i from all exporters;
*' exports are the sum of trade flowing out of region i to all importers.
q21_trade_bilat(h2,k_trade)..
 sum(supreg(h2, i2), vm_prod_reg(i2, k_trade)) =g= sum(supreg(h2,i2), vm_supply(i2, k_trade) -
                              sum(i_ex, v21_trade(i_ex, i2, k_trade))  + sum(i_im, v21_trade(i2, i_im, k_trade)) +
                              sum(ct, f21_trade_export_balanceflow(ct, i2, k_trade)) +
                              sum(ct, f21_trade_regional_balanceflow(ct, i2, k_trade)));

*' For non-tradable commodities, the regional supply should be larger or equal to the regional demand.
 q21_notrade(h2,k_notrade)..
  sum(supreg(h2,i2),vm_prod_reg(i2,k_notrade)) =g= sum(supreg(h2,i2), vm_supply(i2,k_notrade));


*' Lower bound on bilateral trade: each exporter-importer flow must be at least
*' the importer's supply multiplied by the historical import supply ratio
*' (optionally scaled by `i21_import_supply_scenario`), minus a flexibility
*' window defined by the historical standard deviation times the liberalization
*' factor. A larger `i21_stddev_lib_factor` widens the window and allows trade
*' to deviate further below the historical pattern.
q21_trade_lower(i_ex,i_im,k_trade)..
 v21_trade(i_ex,i_im,k_trade) =g=
    vm_supply(i_im,k_trade)
    * sum(ct, i21_import_supply_historical(i_ex,i_im,ct,k_trade) * i21_import_supply_scenario(ct)
       - i21_stddev_lib_factor(ct) * i21_trade_bilat_stddev(ct,i_ex,i_im,k_trade));


*' Upper bound on bilateral trade: each exporter-importer flow must not exceed
*' the importer's supply multiplied by the historical import supply ratio,
*' plus the flexibility window (standard deviation times liberalization factor).
*' Together with `q21_trade_lower`, these bounds create a corridor around the
*' historical bilateral trade pattern within which the optimizer can adjust
*' flows to minimize total costs.
q21_trade_upper(i_ex,i_im,k_trade)..
 v21_trade(i_ex,i_im,k_trade) =l=
    vm_supply(i_im,k_trade)
    * sum(ct, i21_import_supply_historical(i_ex,i_im,ct,k_trade)
       + i21_stddev_lib_factor(ct) * i21_trade_bilat_stddev(ct,i_ex,i_im,k_trade));


*' Tariff costs for each exporting region are the sum over all bilateral flows
*' of the traded volume times the bilateral specific duty tariff rate (USD/tDM).
*' Tariffs are assigned to the exporting region.
q21_costs_tariffs(i2,k_trade)..
 v21_cost_tariff_reg(i2,k_trade) =e= sum((ct,i_im), v21_trade(i2,i_im,k_trade) * i21_trade_tariff(ct,i2,i_im,k_trade));


*' Transport margin costs (freight and insurance) for each exporting region are
*' the sum of bilateral margin rates times traded volumes across all importers.
*' Margins are defined at the region-pair level, reflecting actual transport
*' distances between specific world regions.
q21_costs_margins(i2,k_trade)..
 v21_cost_margin_reg(i2,k_trade) =g=
  sum(i_im, i21_trade_margin(i2,i_im,k_trade) * v21_trade(i2,i_im,k_trade));

*' Regional trade costs per commodity are the sum of tariff and transport margin
*' costs. These feed into the objective function via `vm_cost_trade`.
q21_cost_trade_reg(i2,k_trade)..
  v21_cost_trade_reg(i2,k_trade) =g=
  v21_cost_tariff_reg(i2,k_trade) + v21_cost_margin_reg(i2,k_trade);

*' Total trade costs per region, aggregated over all tradable commodities.
*' This variable enters the global objective function.
 q21_cost_trade(i2)..
 vm_cost_trade(i2) =e= sum(k_trade, v21_cost_trade_reg(i2,k_trade));
