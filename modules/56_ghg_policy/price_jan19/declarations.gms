*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

parameters
 im_pollutant_prices(t,i,pollutants)      	  Certificate prices for N2O-N CH4 CO2-C used in the model (USD05MER per Mg)
 p56_pollutant_prices_input(t,i,pollutants)   Certificate prices for N2O-N CH4 CO2-C from input files (USD05MER per Mg)
 p56_ghg_price_growth_rate(t,i,pollutants)    Growth rate of certificate price (% per yr)
 p56_ghg_price_growth_rate_avg(i,pollutants)  Average over time of growth rate of certificate price (% per yr)
 p56_emis_policy(t,i,pollutants,emis_source)  GHG emission policy scenarios (binary)
;

equations
 q56_technical_mitigation_reg(i,pollutants,emis_source)   Application of maccs on emissions (Tg per yr)
 q56_technical_mitigation_cell(j,pollutants,emis_source)  Application of maccs on emissions (Tg per yr)
 q56_cell_to_reg(i,pollutants,emis_source)                Aggregation to regional emissions (Tg per yr)
 q56_emission_costs(i)                                    Calculation of total emission costs (mio. USD05MER per yr)
 q56_emission_costs_reg_yearly(i,emis_reg_yr56)       	  Calculation of regional costs for annual emissions (mio. USD05MER per yr)
 q56_emission_costs_reg_oneoff(i,emis_reg_one56)       	  Calculation of regional costs for emissions occuring only once in time (mio. USD05MER per yr)
 q56_emission_costs_cell_yearly(j,emis_cell_yr56)     	  Calculation of cellular costs for annual emissions (mio. USD05MER per yr)
 q56_emission_costs_cell_oneoff(j,emis_cell_one56)     	  Calculation of cellular costs for emissions occuring only once in time (mio. USD05MER per yr)
 q56_reward_cdr_aff_reg(i)                                Regional revenues for carbon captured by afforestation (mio. USD05MER per yr)
 q56_reward_cdr_aff(j)			                       	  Cellular revenues for carbon captured by afforestation (mio. USD05MER per yr)
;

positive variables
 v56_reward_cdr_aff(j)				 Cellular revenues for carbon captured by afforestation (mio. USD05MER per yr)
 vm_reward_cdr_aff(i)                Regional revenues for carbon captured by afforestation (mio. USD05MER per yr)
;

variables
 vm_btm_reg(i,emis_source,pollutants)                    Regional emissions before technical mitigation (Tg per yr)
 vm_btm_cell(j,emis_source,pollutants)                   Cellular emissions before technical mitigation (Tg per yr)
 vm_emission_costs(i)                                    Costs for emission rights for pollutants and greenhouse gases (mio. USD05MER per yr)
 vm_emissions_reg(i,emis_source,pollutants)              Regional emissions by source and gas after technical mitigation N CH4 C (Tg per yr)
 v56_emis_cell(j,emis_source,pollutants)                 Cellular emissions by source and gas after technical mitigation N CH4 C (Tg per yr)
 v56_emission_costs_reg_yearly(i,emis_reg_yr56)          Costs for emissions occuring yearly (mio. USD05MER per yr)
 v56_emission_costs_reg_oneoff(i,emis_reg_one56)         Costs for emissions occuring only once in time (mio. USD05MER per yr)
 v56_emission_costs_cell_yearly(j,emis_cell_yr56)        Costs for emissions occuring yearly (mio. USD05MER per yr)
 v56_emission_costs_cell_oneoff(j,emis_cell_one56)       Costs for emissions occuring only once in time (mio. USD05MER per yr)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov56_reward_cdr_aff(t,j,type)                                   Cellular revenues for carbon captured by afforestation (mio. USD05MER per yr)
 ov_reward_cdr_aff(t,i,type)                                     Regional revenues for carbon captured by afforestation (mio. USD05MER per yr)
 ov_btm_reg(t,i,emis_source,pollutants,type)                     Regional emissions before technical mitigation (Tg per yr)
 ov_btm_cell(t,j,emis_source,pollutants,type)                    Cellular emissions before technical mitigation (Tg per yr)
 ov_emission_costs(t,i,type)                                     Costs for emission rights for pollutants and greenhouse gases (mio. USD05MER per yr)
 ov_emissions_reg(t,i,emis_source,pollutants,type)               Regional emissions by source and gas after technical mitigation N CH4 C (Tg per yr)
 ov56_emis_cell(t,j,emis_source,pollutants,type)                 Cellular emissions by source and gas after technical mitigation N CH4 C (Tg per yr)
 ov56_emission_costs_reg_yearly(t,i,emis_reg_yr56,type)          Costs for emissions occuring yearly (mio. USD05MER per yr)
 ov56_emission_costs_reg_oneoff(t,i,emis_reg_one56,type)         Costs for emissions occuring only once in time (mio. USD05MER per yr)
 ov56_emission_costs_cell_yearly(t,j,emis_cell_yr56,type)        Costs for emissions occuring yearly (mio. USD05MER per yr)
 ov56_emission_costs_cell_oneoff(t,j,emis_cell_one56,type)       Costs for emissions occuring only once in time (mio. USD05MER per yr)
 oq56_technical_mitigation_reg(t,i,pollutants,emis_source,type)  Application of maccs on emissions (Tg per yr)
 oq56_technical_mitigation_cell(t,j,pollutants,emis_source,type) Application of maccs on emissions (Tg per yr)
 oq56_cell_to_reg(t,i,pollutants,emis_source,type)               Aggregation to regional emissions (Tg per yr)
 oq56_emission_costs(t,i,type)                                   Calculation of total emission costs (mio. USD05MER per yr)
 oq56_emission_costs_reg_yearly(t,i,emis_reg_yr56,type)          Calculation of regional costs for annual emissions (mio. USD05MER per yr)
 oq56_emission_costs_reg_oneoff(t,i,emis_reg_one56,type)         Calculation of regional costs for emissions occuring only once in time (mio. USD05MER per yr)
 oq56_emission_costs_cell_yearly(t,j,emis_cell_yr56,type)        Calculation of cellular costs for annual emissions (mio. USD05MER per yr)
 oq56_emission_costs_cell_oneoff(t,j,emis_cell_one56,type)       Calculation of cellular costs for emissions occuring only once in time (mio. USD05MER per yr)
 oq56_reward_cdr_aff_reg(t,i,type)                               Regional revenues for carbon captured by afforestation (mio. USD05MER per yr)
 oq56_reward_cdr_aff(t,j,type)                                   Cellular revenues for carbon captured by afforestation (mio. USD05MER per yr)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
