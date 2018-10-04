*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @equations

*' ![Investment-yield ratio in relation to $\tau$-factor
*' [@dietrich_forecasting_2014]](tcc_regression.png){ width=60% }
*'
*' Relative technological change costs `v13_cost_tc` are calculated as a
*' heuristically derived power function of the land use intensity `vm_tau` for
*' the investment-yield-ratio (see figure above) multiplied by the current
*' regional crop areas `pc13_land` (taken from previous time step) and shifted
*' 15 years into the future using the region specific interest
*' rate `pm_interest`:

q13_cost_tc(i2) ..
  v13_cost_tc(i2) =e= sum(ct, pc13_land(i2) * i13_tc_factor(ct,i2)
                     * vm_tau(i2)**i13_tc_exponent(ct,i2)
                     * (1+pm_interest(i2))**15);

*' The shifting is performed because investments into technological change
*' require on average 15 years of research before a yield increase is achieved,
*' but the model has to see costs and benefits concurrently in order to take the
*' right investment decisions (see also @dietrich_forecasting_2014). Investment
*' costs are scaled in relation to crop area, since a wider areal coverage means
*' typically also higher variety in biophysical conditions, which would require
*' more research for the same overall intensity boost.
*'
*' In order to get the full investments required for the desired intensification
*' the relative technological change costs are multiplied with the given
*' intensification rate. These full costs are then distributed over an infinite
*' time horizon by multiplication with the interest rate `pm_interest(i)`
*' (annuity with infinite time horizon):

q13_tech_cost_annuity(i2) ..
 v13_tech_cost_annuity(i2) =e= (vm_tau(i2)/pc13_tau(i2)-1) * v13_cost_tc(i2)
                               * pm_interest(i2)/(1+pm_interest(i2));

*' Additionally, the technological change costs coming from past investment
*' decisions are added to the technological change costs of the current period:

q13_tech_cost(i2) ..
  vm_tech_cost(i2) =e= v13_tech_cost_annuity(i2) + pc13_tech_cost_past(i2);
