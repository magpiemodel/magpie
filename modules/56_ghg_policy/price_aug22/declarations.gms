*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

parameters
 im_pollutant_prices(t_all,i,pollutants,emis_source)          Certificate prices for N2O-N CH4 CO2-C used in the model (USD05MER per Mg)
 p56_pollutant_prices_input(t_all,i,pollutants,emis_source)   Certificate prices for N2O-N CH4 CO2-C from input files (USD05MER per Mg)
 p56_c_price_aff(t_all,i,ac)                      C price used for afforestation decision-making (USD05MER per tC)
 pc56_c_price_induced_aff                         Helper for fixing C price driven afforestation to zero for historic time steps (binary)
 p56_region_price_shr(t_all,i)                    GHG price share of the region (1)
 p56_country_dummy(iso)                           Dummy parameter indicating whether country is affected by selected GHG policy (1)
 p56_region_fader_shr(t_all,i)                    GHG policy fader share of the region (1)
 p56_country_dummy2(iso)                          Dummy parameter indicating whether country is affected by selected GHG policy fader (1)
 p56_fader(t_all)                                 GHG policy fader (1)
 p56_fader_reg(t_all,i)                           Regional GHG policy fader (1)
;

equations
 q56_emission_costs(i)                                  Calculation of total emission costs (mio. USD05MER per yr)
 q56_emission_cost_annual(i,emis_annual)            Calculation of regional costs for annual emissions (mio. USD05MER per yr)
 q56_emission_cost_oneoff(i,emis_oneoff)            Calculation of regional costs for emissions occuring only once in time (mio. USD05MER per yr)
 q56_reward_cdr_aff_reg(i)                              Regional revenues for carbon captured by afforestation (mio. USD05MER per yr)
 q56_reward_cdr_aff(j)                              Cellular revenues for carbon captured by afforestation (mio. USD05MER per yr)
 q56_emis_pricing(i,pollutants,emis_source)   Calculation of annual CO2 emissions for pricing (Tg per yr)
 q56_emis_pricing_co2(i,emis_oneoff)  Calculation of annual CO2 emissions for pricing (Tg per yr)
;

positive variables
 vm_carbon_stock(j,land,c_pools,stockType)     Carbon stock in vegetation soil and litter for different land types (mio. tC)
;


variables
 vm_emission_costs(i)                                    Costs for emission rights for pollutants and greenhouse gases (mio. USD05MER per yr)
 vm_emissions_reg(i,emis_source,pollutants)              Regional emissions by source and gas after technical mitigation N CH4 C (Tg per yr)
 v56_emis_pricing(i,emis_source,pollutants)              Regional emissions by source and gas after technical mitigation N CH4 C (Tg per yr)
 v56_emission_cost(i,emis_source)                  GHG emissions cost (mio. USD05MER per yr)
 vm_reward_cdr_aff(i)                                    Regional average annual expected revenue from afforestation (mio. USD05MER per yr)
 v56_reward_cdr_aff(j)                             Cellular average annual expected revenue from afforestation (mio. USD05MER per yr)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_carbon_stock(t,j,land,c_pools,stockType,type)   Carbon stock in vegetation soil and litter for different land types (mio. tC)
 ov_emission_costs(t,i,type)                        Costs for emission rights for pollutants and greenhouse gases (mio. USD05MER per yr)
 ov_emissions_reg(t,i,emis_source,pollutants,type)  Regional emissions by source and gas after technical mitigation N CH4 C (Tg per yr)
 ov56_emis_pricing(t,i,emis_source,pollutants,type) Regional emissions by source and gas after technical mitigation N CH4 C (Tg per yr)
 ov56_emission_cost(t,i,emis_source,type)           GHG emissions cost (mio. USD05MER per yr)
 ov_reward_cdr_aff(t,i,type)                        Regional average annual expected revenue from afforestation (mio. USD05MER per yr)
 ov56_reward_cdr_aff(t,j,type)                      Cellular average annual expected revenue from afforestation (mio. USD05MER per yr)
 oq56_emission_costs(t,i,type)                      Calculation of total emission costs (mio. USD05MER per yr)
 oq56_emission_cost_annual(t,i,emis_annual,type)    Calculation of regional costs for annual emissions (mio. USD05MER per yr)
 oq56_emission_cost_oneoff(t,i,emis_oneoff,type)    Calculation of regional costs for emissions occuring only once in time (mio. USD05MER per yr)
 oq56_reward_cdr_aff_reg(t,i,type)                  Regional revenues for carbon captured by afforestation (mio. USD05MER per yr)
 oq56_reward_cdr_aff(t,j,type)                      Cellular revenues for carbon captured by afforestation (mio. USD05MER per yr)
 oq56_emis_pricing(t,i,pollutants,emis_source,type) Calculation of annual CO2 emissions for pricing (Tg per yr)
 oq56_emis_pricing_co2(t,i,emis_oneoff,type)        Calculation of annual CO2 emissions for pricing (Tg per yr)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
