*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @realization The endo realization stands for endogenous implementation of
*' technological change and land use intensification. The intensification rates
*' are calculated endogenously based on an interplay between land use intensity
*' $\tau$ and technological change costs. This module realization contains the
*' implementation as described in @dietrich_forecasting_2014 with two
*' minor modifications:
*'
*'   * rates of previous investment decisions which still have to be paid are
*'     added to the technological change costs
*'   * the planning horizon for investments is unified over all investments in
*'     the model.
*'
*' Figure 1 shows schematically how this process is implemented.
*'
*' ![Implementation of technological change in MAgPIE
*' [@dietrich_forecasting_2014]](tc_schematic.png){ width=60% }
*'
*' Initial land use intensity $\tau$ values for the year 2000 come from
*' @dietrich_measuring_2012 and are shown in Figure 2.
*'
*' ![$\tau$-factors in world regions & global (GLO) for the year 2000.
*' [@dietrich_measuring_2012]](tau_regional.png){ width=60% }
*'
*' Investments into technological change (TC) trigger land use intensification
*' ($\tau$) which triggers in turn yields increases. How much intensification an
*' investment can trigger depends on the investment-yield ratio which depends
*' again on the current agricultural land use intensity. The higher the current
*' intensity level, the more expensive the additional intensification will
*' become. The interaction between land use intensity and production costs per
*' area as shown in the figure is not covered by this module and can be found
*' instead in [38_factor_costs].

q13_cost_tc(i2) ..
  v13_cost_tc(i2) =e= sum(ct, i13_land(i2) * i13_tc_factor(ct,i2)
                     * vm_tau(i2)**i13_tc_exponent(ct,i2)
                     * (1+pm_interest(i2))**15);

*' ![investment-yield ratio in relation to $\tau$-factor
*' [@dietrich_forecasting_2014]](tcc_regression.png){ width=60% }
*'
*' Relative technological change costs `v13_cost_tc` are calculated as a
*' heuristically derived power function of the land use intensity `vm_tau` for
*' the investment-yield-ratio (Figure 3) multiplied by the initial, regional
*' crop areas in 1995 `pm_land_start` and shifted 15 years into the future using the
*' region specific interest rate `pm_interest`. The shifting is performed
*' because investments into technological change require on average 15 years of
*' research before a yield increase is achieved, but the model has to see costs
*' and benefits concurrently in order to take the right investment decisions
*' (see also @dietrich_forecasting_2014). Investment costs scale with crop
*' area as a wider areal coverage means typically also higher variety in
*' biophysical conditions and therefore more research required for the same
*' overall intensity boost.

q13_tech_cost_annuity(i2) ..
 v13_tech_cost_annuity(i2) =e= (vm_tau(i2)/pc13_tau(i2)-1) * v13_cost_tc(i2)/pm_annuity_due(i2);

*' In order to get the full investments required for the desired intensification
*' the relative technological change costs are multiplied with the given
*' intensification rate. These full costs are then distributed over an estimated
*' planning horizon `sm_invest_horizon` with the annuity approach and the
*' corresponding annuity factor `pm_annuity_due(i)`.

q13_tech_cost(i2) ..
  vm_tech_cost(i2) =e= v13_tech_cost_annuity(i2) + pc13_tech_cost_past(i2);

*' Additionally, the technological change costs coming from past investment
*' decisions are added to the technological change costs of the current period.

*' @limitations This module significantly reduces the overall computational
*' performance of the model since these endogenous calculations are highly
*' computational intensive.
