*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

i21_trade_bal_reduction(t_all,k_trade)=f21_trade_bal_reduction(t_all,"easytrade","%c21_trade_liberalization%");
i21_trade_bal_reduction(t_all,k_hardtrade21)=f21_trade_bal_reduction(t_all,"hardtrade","%c21_trade_liberalization%");


i21_trade_margin(i_ex,i_im,k_trade) = f21_trade_margin(i_ex,i_im,k_trade);

i21_trade_margin(i_ex,i_im,k_trade)$(i21_trade_margin(i_ex,i_im,k_trade) < 1e-6) = 5;


*** Initialize import supply historical from file
i21_import_supply_historical(i_ex,i_im,t_all,k_trade) = f21_import_supply_historical(i_ex,i_im,t_all,k_trade);

*** Apply scenario adjustments if switch is on
*** Adjustments are hardcoded here and written into f21_trade_scenario_adjustments
*** which is initialized to 0 from the input file. Applied for all t >= s21_trade_adj_startyear.
if (s21_trade_scenario_adjustments = 1,

*** Soybean adjustments
  f21_trade_scenario_adjustments("USA","CHA",t_all,"soybean")$(m_year(t_all) >= s21_trade_adj_startyear) = -0.2;
  f21_trade_scenario_adjustments("LAM","CHA",t_all,"soybean")$(m_year(t_all) >= s21_trade_adj_startyear) = -0.4;
  f21_trade_scenario_adjustments("IND","CHA",t_all,"soybean")$(m_year(t_all) >= s21_trade_adj_startyear) = 0.2;
  f21_trade_scenario_adjustments("SSA","CHA",t_all,"soybean")$(m_year(t_all) >= s21_trade_adj_startyear) = 0.2;

*** Maize adjustments
  f21_trade_scenario_adjustments("USA","MEA",t_all,"maiz")$(m_year(t_all) >= s21_trade_adj_startyear) = 0.1;
  f21_trade_scenario_adjustments("USA","OAS",t_all,"maiz")$(m_year(t_all) >= s21_trade_adj_startyear) = 0.1;
  f21_trade_scenario_adjustments("USA","EUR",t_all,"maiz")$(m_year(t_all) >= s21_trade_adj_startyear) = 0.1;
  f21_trade_scenario_adjustments("REF","EUR",t_all,"maiz")$(m_year(t_all) >= s21_trade_adj_startyear) = -0.1;
  f21_trade_scenario_adjustments("REF","MEA",t_all,"maiz")$(m_year(t_all) >= s21_trade_adj_startyear) = -0.1;
  f21_trade_scenario_adjustments("USA","SSA",t_all,"maiz")$(m_year(t_all) >= s21_trade_adj_startyear) = 0.1;

*** Wheat (tece) adjustments
  f21_trade_scenario_adjustments("REF","MEA",t_all,"tece")$(m_year(t_all) >= s21_trade_adj_startyear) = -0.1;
  f21_trade_scenario_adjustments("REF","NEU",t_all,"tece")$(m_year(t_all) >= s21_trade_adj_startyear) = -0.2;
  f21_trade_scenario_adjustments("USA","MEA",t_all,"tece")$(m_year(t_all) >= s21_trade_adj_startyear) = 0.1;

*** Oilcakes adjustments
  f21_trade_scenario_adjustments("LAM","EUR",t_all,"oilcakes")$(m_year(t_all) >= s21_trade_adj_startyear) = -0.1;
  f21_trade_scenario_adjustments("REF","EUR",t_all,"oilcakes")$(m_year(t_all) >= s21_trade_adj_startyear) = -0.05;

*** Sugar adjustments
  f21_trade_scenario_adjustments("LAM","EUR",t_all,"sugar")$(m_year(t_all) >= s21_trade_adj_startyear) = -0.05;
  f21_trade_scenario_adjustments("LAM","CHA",t_all,"sugar")$(m_year(t_all) >= s21_trade_adj_startyear) = -0.1;
  f21_trade_scenario_adjustments("OAS","CHA",t_all,"sugar")$(m_year(t_all) >= s21_trade_adj_startyear) = 0.05;
  f21_trade_scenario_adjustments("IND","CHA",t_all,"sugar")$(m_year(t_all) >= s21_trade_adj_startyear) = 0.05;

*** Other crop adjustments
  f21_trade_scenario_adjustments("USA","CHA",t_all,"trce")$(m_year(t_all) >= s21_trade_adj_startyear) = -0.3;
  f21_trade_scenario_adjustments("REF","NEU",t_all,"sunflower")$(m_year(t_all) >= s21_trade_adj_startyear) = -0.1;
  f21_trade_scenario_adjustments("CAZ","CHA",t_all,"puls_pro")$(m_year(t_all) >= s21_trade_adj_startyear) = -0.2;
  f21_trade_scenario_adjustments("USA","EUR",t_all,"groundnut")$(m_year(t_all) >= s21_trade_adj_startyear) = -0.2;

*** Livestock milk adjustments
  f21_trade_scenario_adjustments("USA","EUR",t_all,"livst_milk")$(m_year(t_all) >= s21_trade_adj_startyear) = 0.1;
  f21_trade_scenario_adjustments("EUR","EUR",t_all,"livst_milk")$(m_year(t_all) >= s21_trade_adj_startyear) = -0.1;
  f21_trade_scenario_adjustments("CAZ","CHA",t_all,"livst_milk")$(m_year(t_all) >= s21_trade_adj_startyear) = -0.1;
  f21_trade_scenario_adjustments("EUR","CHA",t_all,"livst_milk")$(m_year(t_all) >= s21_trade_adj_startyear) = -0.05;
  f21_trade_scenario_adjustments("IND","CHA",t_all,"livst_milk")$(m_year(t_all) >= s21_trade_adj_startyear) = 0.1;

*** Livestock ruminant meat adjustments
  f21_trade_scenario_adjustments("USA","EUR",t_all,"livst_rum")$(m_year(t_all) >= s21_trade_adj_startyear) = 0.1;
  f21_trade_scenario_adjustments("EUR","EUR",t_all,"livst_rum")$(m_year(t_all) >= s21_trade_adj_startyear) = -0.1;
  f21_trade_scenario_adjustments("LAM","CHA",t_all,"livst_rum")$(m_year(t_all) >= s21_trade_adj_startyear) = -0.05;

*** Livestock chicken adjustments
  f21_trade_scenario_adjustments("USA","EUR",t_all,"livst_chick")$(m_year(t_all) >= s21_trade_adj_startyear) = 0.05;

*** Livestock pig adjustments
  f21_trade_scenario_adjustments("EUR","CHA",t_all,"livst_pig")$(m_year(t_all) >= s21_trade_adj_startyear) = -0.05;

*** Now apply adjustments to import supply historical
  i21_import_supply_historical(i_ex,i_im,t_all,k_trade) =
    i21_import_supply_historical(i_ex,i_im,t_all,k_trade) + f21_trade_scenario_adjustments(i_ex,i_im,t_all,k_trade);

);


  loop(t_all,
     i21_trade_bilat_stddev(t_all,i_ex,i_im,k_trade)$(m_year(t_all) = sm_fix_SSP2 + 5) = f21_trade_bilat_stddev(i_ex,i_im,k_trade,"minsd5");
     i21_trade_bilat_stddev(t_all,i_ex,i_im,k_trade)$(m_year(t_all) = sm_fix_SSP2 + 10) = f21_trade_bilat_stddev(i_ex,i_im,k_trade,"minsd10");
    i21_trade_bilat_stddev(t_all,i_ex,i_im,k_trade)$(m_year(t_all)  >= sm_fix_SSP2 + 15) = f21_trade_bilat_stddev(i_ex,i_im,k_trade,"minsd15");
  );



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

 loop(t_all,
    i21_trade_tariff(t_all,i_ex,i_im,k_trade)$(m_year(t_all) <= sm_fix_SSP2) =  i21_trade_tariff(t_all,i_ex,i_im,k_trade);
    i21_trade_tariff(t_all,i_ex,i_im,k_trade)$(m_year(t_all) > sm_fix_SSP2)=  i21_trade_tariff(t_all,i_ex,i_im,k_trade) * s21_tariff_factor;
  );


 loop(t_all,
    i21_stddev_lib_factor(t_all)$(m_year(t_all) <= sm_fix_SSP2) =  1;
    i21_stddev_lib_factor(t_all)$(m_year(t_all) > sm_fix_SSP2)=  s21_stddev_lib_factor;
   );

  i21_import_supply_scenario(t_all) = 1;

 m_linear_time_interpol(i21_import_supply_scenario,sm_fix_SSP2,s21_import_supply_scenario_targetyear,1,s21_import_supply_scenario);


i21_trade_margin(i_ex, i_im,"wood")$(i21_trade_margin(i_ex, i_im,"wood") < s21_min_trade_margin_forestry) = s21_min_trade_margin_forestry;
i21_trade_margin(i_ex, i_im,"woodfuel")$(i21_trade_margin(i_ex, i_im,"woodfuel") < s21_min_trade_margin_forestry) = s21_min_trade_margin_forestry;
