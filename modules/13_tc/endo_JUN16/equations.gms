*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @equations

q13_cost_tc(i2) ..
  v13_cost_tc(i2) =e= sum(ct, i13_land(i2) * i13_tc_factor(ct,i2)
                     * vm_tau(i2)**i13_tc_exponent(ct,i2)
                     * (1+pm_interest(i2))**15);

*' Relative technological change costs `v13_cost_tc` are calculated as a
*' heuristically derived power function of the land use intensity `vm_tau` for
*' the investment-yield-ratio (see figure below) multiplied by the initial,
*' regional crop areas in 1995 `pm_land_start` and shifted 15 years into the
*' future using the region specific interest rate `pm_interest`.
*'
*' ![Investment-yield ratio in relation to $\tau$-factor
*' [@dietrich_forecasting_2014]](tcc_regression.png){ width=60% }
*'
*' The shifting is performed because investments into technological change
*' require on average 15 years of research before a yield increase is achieved,
*' but the model has to see costs and benefits concurrently in order to take the
*' right investment decisions (see also @dietrich_forecasting_2014). Investment
*' costs scale with crop area as a wider areal coverage means typically also
*' higher variety in biophysical conditions and therefore more research required
*' for the same overall intensity boost.

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
