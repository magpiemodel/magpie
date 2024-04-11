*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


*' @equations


*' GHG emissions for pricing can differ for CO2 emissions from land-use change depending on `c56_carbon_stock_pricing`.
*' CO2 emission subject to emission pricing are calculated based on changes in carbon stocks between timesteps in the interface `vm_carbon_stock`, depending on `c56_carbon_stock_pricing`.

 q56_emis_pricing(i2,pollutants,emis_annual) ..
  v56_emis_pricing(i2,emis_annual,pollutants) =e=
    vm_emissions_reg(i2,emis_annual,pollutants);

 q56_emis_pricing_co2(i2,emis_oneoff) ..
  v56_emis_pricing(i2,emis_oneoff,"co2_c") =e=
                 sum((cell(i2,j2),emis_land(emis_oneoff,land,c_pools)),
                 (vm_carbon_stock.l(j2,land,c_pools,"actual") - vm_carbon_stock(j2,land,c_pools,"%c56_carbon_stock_pricing%"))/m_timestep_length);

*** Emission costs

*' **Emission costs** are calculated by multiplying regional emissions with the emission price `im_pollutant_prices`,
*' taking into account the price policy that was defined above in `c56_emis_policy`.

 q56_emission_cost_annual(i2,emis_annual) ..
                 v56_emission_cost(i2,emis_annual) =e=
                 sum(pollutants,
                     v56_emis_pricing(i2,emis_annual,pollutants) *
                     sum(ct, im_pollutant_prices(ct,i2,pollutants,emis_annual)));

*' As MAgPIE is a recursive dynamic model, within the optimization of the current time step it does not account for benefits or costs in future time steps.
*' This can be problematic for the treatment of emissions that occur only once under continuous management (such as deforestation,
*' where the forest has been cut down the cropland can be continuously cultivated without further deforestation emissions) versus
*' emissions that occur continously (such as fertilization emissions, that will re-occur every year for continuously management).
*' We therefore distinguish one-off and yearly emissions, and discount one-off emissions assuming an infinite time-horizon to
*' level them with yearly emissions. Since one-off emissions in `vm_emissions_reg` and `v56_emis_cell_pricing` are expressed as annual emissions
*' they are converted back into emissions of the entire timestep by multiplication with `m_timestep_length`, and are then
*' transformed into annual costs by multiplication with the emission price (`im_pollutant_prices`)
*' and an annuity (annuity due with infinite time horizon) factor that depends on `pm_interest`.

 q56_emission_cost_oneoff(i2,emis_oneoff) ..
                 v56_emission_cost(i2,emis_oneoff) =e=
                 sum(pollutants,
                     v56_emis_pricing(i2,emis_oneoff,pollutants)
                     * m_timestep_length
                     * sum(ct,
                       im_pollutant_prices(ct,i2,pollutants,emis_oneoff)
                      * pm_interest(ct,i2)/(1+pm_interest(ct,i2))));

*' **Total regional emission costs** consist of costs from yearly and one-off emissions.

 q56_emission_costs(i2) ..
                 vm_emission_costs(i2) =e=
                 sum(emis_source, v56_emission_cost(i2,emis_source));

*' The value of CDR from C-price induced afforestation enters the objective function as negative costs.
*' The reward, which serves as incentive for afforestation, is calculated in 3 steps:
*' First, the sum of the expected CDR for each 5-year age-class and the carbon equivalent of local biophysical effects (`vm_cdr_aff`)
*' are multiplied by the corresponding future C price (`p56_c_price_aff`).
*' Second, these future cash flows are discounted to present value, depending on `pm_interest`.
*' Third, an annuity factor (annuity due with infinite time horizon) is used to obtain average annual rewards

 q56_reward_cdr_aff_reg(i2) ..
                 vm_reward_cdr_aff(i2) =e=
                 sum(cell(i2,j2),
                 v56_reward_cdr_aff(j2)
                 );

 q56_reward_cdr_aff(j2) ..
                 v56_reward_cdr_aff(j2) =e=
               s56_c_price_induced_aff*
               sum(ac,
               (sum(aff_effect,(1-s56_buffer_aff)*vm_cdr_aff(j2,ac,aff_effect)) * sum((cell(i2,j2),ct), p56_c_price_aff(ct,i2,ac)))
               / ((1+sum((cell(i2,j2),ct),pm_interest(ct,i2)))**(ac.off*5)))
                 *sum((cell(i2,j2),ct),pm_interest(ct,i2)/(1+pm_interest(ct,i2)));
