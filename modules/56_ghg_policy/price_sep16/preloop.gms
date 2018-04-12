*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de


*select ghg prices
$ifthen "%c56_pollutant_prices%" == "coupling" im_pollutant_prices(t_all,i,pollutants) = f56_pollutant_prices_coupling(t_all,i,pollutants);
$elseif "%c56_pollutant_prices%" == "emulator" im_pollutant_prices(t_all,i,pollutants) = f56_pollutant_prices_emulator(t_all,pollutants);
$else im_pollutant_prices(t_all,i,pollutants) = f56_pollutant_prices(t_all,i,pollutants,"%c56_pollutant_prices%");
$endif

*reward neg emissions depending on s56_reward_neg_emis
v56_emission_costs_cell_oneoff.lo(j2,emis_cell_oneoff56) = s56_reward_neg_emis;

*calculate ghg price growth rate
*http://de.wikihow.com/Berechnung-einer-Wachstumsrate#/Bild:Calculate-Growth-Rate-Step-6.jpg
p56_ghg_price_growth_rate(t,i,pollutants) = 0;
p56_ghg_price_growth_rate(t,i,pollutants)$(ord(t)>1 AND im_pollutant_prices(t-1,i,pollutants) > 0) = (im_pollutant_prices(t,i,pollutants)/im_pollutant_prices(t-1,i,pollutants))**(1/m_yeardiff(t))-1;
*remove values exceeding 10%
p56_ghg_price_growth_rate(t,i,pollutants)$(p56_ghg_price_growth_rate(t,i,pollutants) > 0.1) = 0.1;
*limit deviation from average growth rate over time to 1%
p56_ghg_price_growth_rate_avg(i,pollutants) = sum(t, p56_ghg_price_growth_rate(t,i,pollutants))/card(t);
p56_ghg_price_growth_rate(t,i,pollutants)$(p56_ghg_price_growth_rate(t,i,pollutants) > p56_ghg_price_growth_rate_avg(i,pollutants)+0.01) = p56_ghg_price_growth_rate_avg(i,pollutants)+0.01;
p56_ghg_price_growth_rate(t,i,pollutants)$(p56_ghg_price_growth_rate(t,i,pollutants) < p56_ghg_price_growth_rate_avg(i,pollutants)-0.01) = p56_ghg_price_growth_rate_avg(i,pollutants)-0.01;
*calculate annuity factor for ghg emission costs
p56_ghg_price_annuity(t,i,pollutants) = 1;
p56_ghg_price_annuity(t,i,pollutants)$(p56_ghg_price_growth_rate(t,i,pollutants) > 0) = m_annuity_due(p56_ghg_price_growth_rate(t,i,pollutants),sm_invest_horizon);
