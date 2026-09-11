*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

* BILATERAL TRANSPORT MARGINS
* Initialize bilateral margins from input; set minimum threshold for very
* small values to avoid near-zero transport costs that could cause
* unrealistic trade patterns.
i21_trade_margin(i_ex,i_im,k_trade) = f21_trade_margin(i_ex,i_im,k_trade);

i21_trade_margin(i_ex,i_im,k_trade)$(i21_trade_margin(i_ex,i_im,k_trade) < 1e-6) = 5;


* IMPORT SUPPLY RATIOS AND SCENARIO ADJUSTMENTS
* Initialize bilateral import supply ratios from historical FAOSTAT data.
* These ratios express the share of each importer's domestic supply that is
* sourced from each exporter (e.g. 0.15 means 15% of domestic supply is
* imported from that particular exporter).
i21_import_supply_historical(i_ex,i_im,t_all,k_trade) = f21_import_supply_historical(i_ex,i_im,t_all,k_trade);


* FLEXIBILITY BAND (ROLLING-RANGE BOUNDS)
* The flexibility band of import supply ratios is calculated from the historic trade matrix,
* by taking the rolling RANGE (max - min) of all 5-year, 10-year, and 15-year windows
* from 1990 onwards, for each importer-exporter-product combination.
* This gives, for each window length, the MEAN over all historically observed rolling ranges,
* showing how variable trade flows typically were over shorter and longer periods of time.
* 5/10/15 year historic windows are assigned to equivalent time steps after the calibration year
* (sm_fix_SSP2), giving progressively wider flexibility as the projection moves further
* from the historical period. The amount of flexibility is set to the MEAN observed range
* for each window length, allowing typical historical variability as future change.
* The mean rolling range widens with window length (empirically monotone on the historical data;
* the max variant is provably monotone). Options for max (peak observed variability, wider) and
* min (narrowest) also exist. The band is capped at 1 in preprocessing; the applied lib-scaled window
* (i21_trade_bilat_flexBand_capped, computed below) is additionally capped at 1.
loop(t_all,
  i21_trade_bilat_flexBand(t_all,i_ex,i_im,k_trade)$(m_year(t_all) = sm_fix_SSP2 + 5) = f21_trade_bilat_flexBand(i_ex,i_im,k_trade,"mean5");
  i21_trade_bilat_flexBand(t_all,i_ex,i_im,k_trade)$(m_year(t_all) = sm_fix_SSP2 + 10) = f21_trade_bilat_flexBand(i_ex,i_im,k_trade,"mean10");
  i21_trade_bilat_flexBand(t_all,i_ex,i_im,k_trade)$(m_year(t_all)  >= sm_fix_SSP2 + 15) = f21_trade_bilat_flexBand(i_ex,i_im,k_trade,"mean15");
);

* Remove intra-regional trade flexibility bands (e.g. EUR.EUR) because the
* current model does not reflect the incentives for intra-regional trade
  i21_trade_bilat_flexBand(t_all,i_ex,i_im,k_trade)$(sameas(i_ex,i_im)) = 0;

* BILATERAL TARIFFS
* Initialize tariffs from input data or set to zero depending on switch.
if ((s21_trade_tariff = 1),
  i21_trade_tariff(t_all, i_ex, i_im, k_trade) = f21_trade_tariff(i_ex, i_im, k_trade);
elseif (s21_trade_tariff = 0),
  i21_trade_tariff(t_all, i_ex, i_im, k_trade) = 0;
);

* Optional linear fade of tariffs towards a target multiplier between start
* and target year. s21_trade_tariff_factor is the target multiplier:
* 1 = no change, 0 = full fadeout, 0.5 = halve tariffs, 2 = double tariffs.
* Before the start year, tariffs are unchanged. After the target year, tariffs
* are held at the target multiplier level. Between start and target, a linear
* interpolation is applied. Only affects post-calibration periods.
loop(t_all,
  i21_trade_tariff(t_all,i_ex,i_im,k_trade)$(m_year(t_all) <= sm_fix_SSP2) = i21_trade_tariff(t_all,i_ex,i_im,k_trade);
  i21_trade_tariff(t_all,i_ex,i_im,k_trade)$(m_year(t_all) > sm_fix_SSP2
    and m_year(t_all) <= s21_trade_tariff_startyear) = i21_trade_tariff(t_all,i_ex,i_im,k_trade);
  i21_trade_tariff(t_all,i_ex,i_im,k_trade)$(m_year(t_all) > s21_trade_tariff_startyear
    and m_year(t_all) < s21_trade_tariff_targetyear) =
    i21_trade_tariff(t_all,i_ex,i_im,k_trade)
    * (1 + (s21_trade_tariff_factor - 1)
       * (m_year(t_all) - s21_trade_tariff_startyear)
       / (s21_trade_tariff_targetyear - s21_trade_tariff_startyear));
  i21_trade_tariff(t_all,i_ex,i_im,k_trade)$(m_year(t_all) >= s21_trade_tariff_targetyear) =
    i21_trade_tariff(t_all,i_ex,i_im,k_trade) * s21_trade_tariff_factor;
);

* FLEXIBILITY AND SCENARIO SCALARS
* i21_flexBand_lib_factor scales the width of the flexibility window.
* Before the calibration year it is 1 (historical bounds). After, it can be
* increased (more flexibility, trade liberalization) or decreased (more rigid
* trade patterns). Controlled by s21_flexBand_lib_factor.
loop(t_all,
  i21_flexBand_lib_factor(t_all)$(m_year(t_all) <= sm_fix_SSP2) =  1;
  i21_flexBand_lib_factor(t_all)$(m_year(t_all) > sm_fix_SSP2)=  s21_flexBand_lib_factor;
);

* APPLIED FLEXIBILITY WINDOW (capped at 1)
* The window entering the trade bounds is the lib-factor-scaled flexibility band, capped
* at 1 so that even under liberalization scenarios (s21_flexBand_lib_factor > 1) the window
* never exceeds 100% of the importer's domestic supply. Preprocessing already caps the raw
* band at 1; this cap additionally bounds the lib-scaled window used in q21_trade_lower/upper.
i21_trade_bilat_flexBand_capped(t_all,i_ex,i_im,k_trade) =
  min(i21_flexBand_lib_factor(t_all) * i21_trade_bilat_flexBand(t_all,i_ex,i_im,k_trade), 1);

* Apply scenario adjustments to import supply historical for future periods.
* f21_trade_scenario_adjustments currently remains
* all zeros so this addition has no effect until changes made in preprocessing
if ((s21_trade_scenario_adjustments = 1),
  loop(t_all$(m_year(t_all) > sm_fix_SSP2),
   i21_import_supply_historical(i_ex,i_im,t_all,k_trade) =
    i21_import_supply_historical(i_ex,i_im,t_all,k_trade)
    + f21_trade_scenario_adjustments(i_ex,i_im,t_all,k_trade);
  );
);


* CAP IMPORT SUPPLY RATIOS AT 1
* When i21_import_supply_scenario > 1, the scenario-scaled sum of import supply
* ratios across all exporters can exceed 1 for some importers and commodities,
* meaning modelled imports would exceed 100% of domestic supply, causing
* overproduction. We rescale i21_import_supply_historical proportionally for
* each (i_im, t_all, k_trade) combination where the scaled sum exceeds 1,
* preserving the relative bilateral shares while capping the total at 1.
p21_import_supply_sum(i_im,t_all,k_trade) =
  sum(i_ex, i21_import_supply_historical(i_ex,i_im,t_all,k_trade))
  * i21_import_supply_scenario(t_all);

i21_import_supply_historical(i_ex,i_im,t_all,k_trade)
  $(p21_import_supply_sum(i_im,t_all,k_trade) > 1) =
  i21_import_supply_historical(i_ex,i_im,t_all,k_trade)
  / p21_import_supply_sum(i_im,t_all,k_trade);



* Enforce minimum transport margin for forestry products to prevent
* unrealistically cheap long-distance wood trade.
i21_trade_margin(i_ex, i_im,"wood")$(i21_trade_margin(i_ex, i_im,"wood") < s21_min_trade_margin_forestry) = s21_min_trade_margin_forestry;
i21_trade_margin(i_ex, i_im,"woodfuel")$(i21_trade_margin(i_ex, i_im,"woodfuel") < s21_min_trade_margin_forestry) = s21_min_trade_margin_forestry;

v21_import_for_feasibility.fx(i_ex,i_im,k_trade) = 0;
v21_import_for_feasibility.lo(i_ex,i_im,k_import21) = 0;
v21_import_for_feasibility.up(i_ex,i_im,k_import21) = Inf;
