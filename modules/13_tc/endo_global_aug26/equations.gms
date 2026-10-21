*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations

*' ![Investment-yield ratio in relation to $\tau$-factor
*' [@dietrich_forecasting_2014]](tcc_regression.png){ width=60% }
*'
*' Relative technological change costs `v13_cost_tc` are calculated as a
*' heuristically derived power function of the land use intensity `v13_tau_core` for
*' the investment-yield-ratio (see figure above) multiplied by the current
*' regional crop areas `pc13_land` (taken from previous time step) and shifted
*' 15 years into the future using the region specific interest
*' rate `pm_interest`:
*' 
*' Scaling the stock by `s13_tc_exponent` accounts for the different
*' cost definitions in `endo_jan22` and `endo_global_aug26` and allows using the same
*' factor and exponent values.

q13_rd_stock_crop(i2)..
  sum(supreg(h2,i2), v13_tau_core(h2,"crop")**(s13_tc_exponent * s13_glob_mix_sharpness)) =e= 
    (1-s13_tc_investment_global_share) * (v13_rd_stock_per_area(i2, "crop") * s13_tc_exponent / s13_tc_factor)**(s13_glob_mix_sharpness) +
    s13_tc_investment_global_share * (v13_rd_stock_per_area_global("crop") * s13_tc_exponent / s13_tc_factor)**(s13_glob_mix_sharpness);


q13_rd_investment_crop(i2)..
  pc13_land(i2, "crop") * v13_rd_stock_per_area(i2, "crop") =e= pc13_land(i2, "crop") * sum(ct, p13_rd_stock_per_area(ct, i2, "crop")) +
                                    v13_rd_investment(i2, "crop");

q13_rd_stock_global..
  v13_rd_stock_per_area_global("crop") * sum(i2, pc13_land(i2,"crop")) =e= sum(i2, v13_rd_stock_per_area(i2, "crop") * pc13_land(i2,"crop"));


q13_tech_cost(i2, tautype) ..
  v13_tech_cost(i2, tautype) 
  =e= 
  v13_rd_investment(i2, tautype) * (1 + sum(ct, pm_interest(ct, i2)))**15 / 
  pc13_interest_annuity(i2);
*  sum(ct,(1+pm_interest(ct, i2))/pm_interest(ct, i2));


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

q13_tech_cost_sum(i2) ..
 vm_tech_cost(i2) =e= sum(tautype, v13_tech_cost(i2, tautype));


*' The overall land use intensity factor `vm_tau` is a linear combination between the
*' land use intensity factors `v13_tau_core` for regular cropland and `v13_tau_consv`
*' for cropland in conservation priority areas.

q13_tau(j2,tautype)..
    vm_tau(j2,tautype) =e= sum((ct, cell(i2,j2), supreg(h2,i2)), (1-p13_cropland_consv_shr(ct,j2)) * v13_tau_core(h2,tautype) + p13_cropland_consv_shr(ct,j2) * v13_tau_consv(h2,tautype));

*' `v13_tau_consv` for cropland in conservation priority areas is linked to `v13_tau_core`
*' through a multiplication factor that can lower land use intensity in
*' conservation priority areas.

q13_tau_consv(h2,tautype)$(c13_croparea_consv_tau_increase = 1 OR sum(ct, m_year(ct)) < s13_croparea_consv_start)..
 v13_tau_consv(h2,tautype) =e= p13_croparea_consv_tau_factor(h2) * v13_tau_core(h2,tautype);


*' The subsequent equations belong to the standalone stock initialization model, which is
*' executed before MAgPIE. They are excluded from the run of MAgPIE itself.

q13_tech_cost_init(t_past, i2)..
    (sum(supreg(h2,i2),v13_tau_init(t_past, h2)))**(s13_tc_exponent * s13_glob_mix_sharpness) =e= 
    (1-s13_tc_investment_global_share) * (v13_rd_stock_per_area_init(t_past, i2) * s13_tc_exponent / s13_tc_factor)**(s13_glob_mix_sharpness) +
    s13_tc_investment_global_share * (v13_rd_stock_per_area_global_init(t_past) * s13_tc_exponent / s13_tc_factor)**(s13_glob_mix_sharpness);

q13_rd_stock_crop_init(t_all, i2)..
    v13_rd_stock_per_area_init(t_all, i2) =e= sum(t_past, v13_rd_investment_init(t_past, i2)
                                   * sum(delay,f13_stock_payout(delay,"%c13_payout_curve%") $ (ord(delay)-1 = m_year(t_all)-m_year(t_past))));


q13_rd_stock_global_init(t_past)..
  v13_rd_stock_per_area_global_init(t_past) * sum(i2, pc13_land(i2,"crop")) =e= sum(i2, v13_rd_stock_per_area_init(t_past, i2) * pc13_land(i2,"crop"));

*' To initialize the TC R&D stock, historical investments to reproduce the historical tau values are estimated.
*' In order to get accurate estimates in the relevant range (1995 and after), an expected initial overshoot of investments
*' from 0 investments before 1965 is allowed by excluding 1965 and 1970 from the loss calculation.
q13_init_approximation_error..
  v13_init_approximation_error =e= sum((t_past, h2), sqr(v13_tau_init(t_past, h2) - f13_tau_historical(t_past, h2))$(m_year(t_past) > 1970 AND f13_tau_historical(t_past, h2) > 0));
