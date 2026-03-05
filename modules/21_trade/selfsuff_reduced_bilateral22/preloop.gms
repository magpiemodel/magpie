*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

** TRADE BALANCE REDUCTION
** Map trade liberalization regime to easy/hard trade product groups
i21_trade_bal_reduction(t_all,k_trade)=f21_trade_bal_reduction(t_all,"easytrade","%c21_trade_liberalization%");
i21_trade_bal_reduction(t_all,k_hardtrade21)=f21_trade_bal_reduction(t_all,"hardtrade","%c21_trade_liberalization%");

** BILATERAL TRANSPORT MARGINS
** Initialize bilateral margins from input; set minimum threshold for very
** small values to avoid near-zero transport costs that could cause
** unrealistic trade patterns.
i21_trade_margin(i_ex,i_im,k_trade) = f21_trade_margin(i_ex,i_im,k_trade);

i21_trade_margin(i_ex,i_im,k_trade)$(i21_trade_margin(i_ex,i_im,k_trade) < 1e-6) = 5;


** IMPORT SUPPLY RATIOS AND SCENARIO ADJUSTMENTS
** Initialize bilateral import supply ratios from historical FAOSTAT data.
** These ratios express the share of each importer's domestic supply that is
** sourced from each exporter (e.g. 0.15 means 15% of domestic supply is
** imported from that particular exporter).
i21_import_supply_historical(i_ex,i_im,t_all,k_trade) = f21_import_supply_historical(i_ex,i_im,t_all,k_trade);


** FLEXIBILITY WINDOW (STANDARD DEVIATION BOUNDS)
** The flexibility window around historical import supply ratios is defined
** by the observed standard deviation of these ratios. Three rolling windows
** are available from the input data: 5-year, 10-year, and 15-year.
** These are assigned to successive time steps after the calibration year
** (sm_fix_SSP2), giving progressively wider flexibility as the projection
** moves further from the historical period.
  loop(t_all,
     i21_trade_bilat_stddev(t_all,i_ex,i_im,k_trade)$(m_year(t_all) = sm_fix_SSP2 + 5) = f21_trade_bilat_stddev(i_ex,i_im,k_trade,"maxsd5");
     i21_trade_bilat_stddev(t_all,i_ex,i_im,k_trade)$(m_year(t_all) = sm_fix_SSP2 + 10) = f21_trade_bilat_stddev(i_ex,i_im,k_trade,"maxsd10");
    i21_trade_bilat_stddev(t_all,i_ex,i_im,k_trade)$(m_year(t_all)  >= sm_fix_SSP2 + 15) = f21_trade_bilat_stddev(i_ex,i_im,k_trade,"maxsd15");
  );

** BILATERAL TARIFFS
** Initialize tariffs from input data or set to zero depending on switch.
** Optional linear fadeout reduces tariffs to zero between start and target
** year. Post-calibration, tariffs can be further scaled by s21_tariff_factor.

if ((s21_trade_tariff=1),
    i21_trade_tariff(t_all, i_ex,i_im,k_trade) = f21_trade_tariff(i_ex,i_im,k_trade);
  elseif (s21_trade_tariff=0),
     i21_trade_tariff(t_all, i_ex,i_im,k_trade) = 0;
 );

 if ((s21_trade_tariff_fadeout=1),
 loop(t_all,
    i21_trade_tariff(t_all,i_ex,i_im,k_trade)$(m_year(t_all) > s21_trade_tariff_startyear and m_year(t_all) < s21_trade_tariff_targetyear) = (1-((m_year(t_all)-s21_trade_tariff_startyear) /
                                                                                                                                            (s21_trade_tariff_targetyear-s21_trade_tariff_startyear))) * 
                                                                                                                                            i21_trade_tariff(t_all,i_ex,i_im,k_trade);
 i21_trade_tariff(t_all,i_ex,i_im,k_trade)$(m_year(t_all) <= s21_trade_tariff_startyear) = i21_trade_tariff(t_all,i_ex,i_im,k_trade); 
 i21_trade_tariff(t_all,i_ex,i_im,k_trade)$(m_year(t_all) >= s21_trade_tariff_targetyear) = 0 ; 
 );
 );

** Apply post-calibration tariff scaling factor
 loop(t_all,
    i21_trade_tariff(t_all,i_ex,i_im,k_trade)$(m_year(t_all) <= sm_fix_SSP2) =  i21_trade_tariff(t_all,i_ex,i_im,k_trade);
    i21_trade_tariff(t_all,i_ex,i_im,k_trade)$(m_year(t_all) > sm_fix_SSP2)=  i21_trade_tariff(t_all,i_ex,i_im,k_trade) * s21_tariff_factor;
  );

** FLEXIBILITY AND SCENARIO SCALARS
** i21_stddev_lib_factor scales the width of the flexibility window.
** Before the calibration year it is 1 (historical bounds). After, it can be
** increased (more flexibility, trade liberalization) or decreased (more rigid
** trade patterns). Controlled by s21_stddev_lib_factor.
 loop(t_all,
    i21_stddev_lib_factor(t_all)$(m_year(t_all) <= sm_fix_SSP2) =  1;
    i21_stddev_lib_factor(t_all)$(m_year(t_all) > sm_fix_SSP2)=  s21_stddev_lib_factor;
   );

** i21_import_supply_scenario scales the historical import supply ratios.
** Linearly interpolated from 1 at calibration year to the target value
** (s21_import_supply_scenario) at the target year. Values >1 amplify
** historical trade dependence; <1 reduce it (autarky scenario).
  i21_import_supply_scenario(t_all) = 1;

 m_linear_time_interpol(i21_import_supply_scenario,sm_fix_SSP2,s21_import_supply_scenario_targetyear,1,s21_import_supply_scenario);

** SCENARIO ADJUSTMENTS TO BILATERAL IMPORT SUPPLY RATIOS
** Optionally apply exogenous scenario adjustments to specific bilateral
** ratios. Controlled by c21_trade_scenario (off, USAex, CHAdom, EURex).
** Adjustments are additive perturbations written into the zero-initialized
** f21_trade_scenario_adjustments table and applied to i21_import_supply_historical
** for time steps after sm_fix_SSP2.

$ifthen "%c21_trade_scenario%" == "USAex"
** USA export expansion: USA increases exports of key commodities to
** major importing regions.

** Soybean and crop adjustments
  f21_trade_scenario_adjustments("USA","CHA",t_all,"soybean") = 0.15;
  f21_trade_scenario_adjustments("USA","OAS",t_all,"maiz") = 0.15;
  f21_trade_scenario_adjustments("USA","EUR",t_all,"maiz") = 0.15;
  f21_trade_scenario_adjustments("USA","SSA",t_all,"maiz") = 0.15;
  f21_trade_scenario_adjustments("USA","MEA",t_all,"tece") = 0.15;
  f21_trade_scenario_adjustments("USA","CHA",t_all,"trce") = 0.15;
  f21_trade_scenario_adjustments("USA","EUR",t_all,"groundnut") = 0.15;

** Livestock adjustments
  f21_trade_scenario_adjustments("USA","EUR",t_all,"livst_milk") = 0.10;
  f21_trade_scenario_adjustments("USA","OAS",t_all,"livst_milk") = 0.10;
  f21_trade_scenario_adjustments("USA","LAM",t_all,"livst_milk") = 0.10;
  f21_trade_scenario_adjustments("USA","JPN",t_all,"livst_milk") = 0.10;
  f21_trade_scenario_adjustments("USA","CAZ",t_all,"livst_milk") = 0.10;
  f21_trade_scenario_adjustments("USA","EUR",t_all,"livst_rum") = 0.10;
  f21_trade_scenario_adjustments("USA","MEA",t_all,"livst_rum") = 0.10;
  f21_trade_scenario_adjustments("USA","EUR",t_all,"livst_chick") = 0.10;
  f21_trade_scenario_adjustments("USA","OAS",t_all,"livst_chick") = 0.10;
  f21_trade_scenario_adjustments("USA","SSA",t_all,"livst_chick") = 0.10;
  f21_trade_scenario_adjustments("USA","LAM",t_all,"livst_pig") = 0.10;
  f21_trade_scenario_adjustments("USA","JPN",t_all,"livst_pig") = 0.10;
  f21_trade_scenario_adjustments("USA","CAZ",t_all,"livst_pig") = 0.10;
  f21_trade_scenario_adjustments("USA","CHA",t_all,"livst_pig") = 0.10;

$elseif "%c21_trade_scenario%" == "CHAdom"
** China domestication: China reduces import dependence on major
** exporters, diversifying or reducing key bilateral flows.

** Soybean adjustments
  f21_trade_scenario_adjustments("USA","CHA",t_all,"soybean") = -0.15;
  f21_trade_scenario_adjustments("LAM","CHA",t_all,"soybean") = -0.3;
  f21_trade_scenario_adjustments("IND","CHA",t_all,"soybean") = 0.10;
  f21_trade_scenario_adjustments("SSA","CHA",t_all,"soybean") = 0.10;

** Sugar adjustments
  f21_trade_scenario_adjustments("LAM","CHA",t_all,"sugar") = -0.10;
  f21_trade_scenario_adjustments("OAS","CHA",t_all,"sugar") = 0.05;
  f21_trade_scenario_adjustments("IND","CHA",t_all,"sugar") = 0.05;

** Other crop adjustments
  f21_trade_scenario_adjustments("USA","CHA",t_all,"trce") = -0.3;
  f21_trade_scenario_adjustments("CAZ","CHA",t_all,"puls_pro") = -0.3;
  f21_trade_scenario_adjustments("CAZ","CHA",t_all,"rapeseed") = -0.1;
  f21_trade_scenario_adjustments("SSA","CHA",t_all,"rapeseed") = 0.05;
  f21_trade_scenario_adjustments("OAS","CHA",t_all,"cassav_sp") = -0.1;
  f21_trade_scenario_adjustments("LAM","CHA",t_all,"cassav_sp") = 0.05;

** Livestock adjustments
  f21_trade_scenario_adjustments("CAZ","CHA",t_all,"livst_milk") = -0.15;
  f21_trade_scenario_adjustments("EUR","CHA",t_all,"livst_milk") = -0.1;
  f21_trade_scenario_adjustments("EUR","USA",t_all,"livst_milk") = -0.03;
  f21_trade_scenario_adjustments("CAZ","CHA",t_all,"livst_rum") = -0.05;
  f21_trade_scenario_adjustments("LAM","CHA",t_all,"livst_rum") = -0.05;
  f21_trade_scenario_adjustments("OAS","CHA",t_all,"livst_rum") = -0.03;
  f21_trade_scenario_adjustments("EUR","CHA",t_all,"livst_pig") = -0.05;

$elseif "%c21_trade_scenario%" == "EURex"
** EU trade restructuring: Shifts in European and REF region trade
** patterns, reducing REF exports and adjusting EU trade flows.

** Wheat (tece) adjustments
  f21_trade_scenario_adjustments("REF","MEA",t_all,"tece") = -0.1;
  f21_trade_scenario_adjustments("EUR","MEA",t_all,"tece") = 0.1;
  f21_trade_scenario_adjustments("REF","NEU",t_all,"tece") = -0.2;

** Oilcakes and sugar adjustments
  f21_trade_scenario_adjustments("LAM","EUR",t_all,"oilcakes") = -0.15;
  f21_trade_scenario_adjustments("LAM","EUR",t_all,"sugar") = -0.05;

** Other crop adjustments
  f21_trade_scenario_adjustments("REF","NEU",t_all,"sunflower") = -0.03;
  f21_trade_scenario_adjustments("USA","EUR",t_all,"groundnut") = -0.2;

** Livestock adjustments
  f21_trade_scenario_adjustments("EUR","CHA",t_all,"livst_pig") = 0.12;

$endif

** Apply scenario adjustments to import supply historical for future periods.
** When c21_trade_scenario is "off", f21_trade_scenario_adjustments remains
** all zeros so this addition has no effect.
  loop(t_all$(m_year(t_all) > sm_fix_SSP2),
    i21_import_supply_historical(i_ex,i_im,t_all,k_trade) =
      i21_import_supply_historical(i_ex,i_im,t_all,k_trade)
      + f21_trade_scenario_adjustments(i_ex,i_im,t_all,k_trade);
  );



** Enforce minimum transport margin for forestry products to prevent
** unrealistically cheap long-distance wood trade.
i21_trade_margin(i_ex, i_im,"wood")$(i21_trade_margin(i_ex, i_im,"wood") < s21_min_trade_margin_forestry) = s21_min_trade_margin_forestry;
i21_trade_margin(i_ex, i_im,"woodfuel")$(i21_trade_margin(i_ex, i_im,"woodfuel") < s21_min_trade_margin_forestry) = s21_min_trade_margin_forestry;
