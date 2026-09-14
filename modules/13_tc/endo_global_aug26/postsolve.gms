*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

* Overall TC cost for the current timestep

if((ord(t)>1),
 pc13_tcguess(h,tautype) = (v13_tau_core.l(h,tautype)/pc13_tau(h, tautype))**(1/m_yeardiff(t)) - 1;
);

pc13_tau(h, tautype) = v13_tau_core.l(h, tautype);
pc13_tau_consv(h, tautype) = v13_tau_consv.l(h, tautype);
pcm_tau(j, tautype) = vm_tau.l(j, tautype);

p13_rd_stock_per_area(t_all, i2, "crop") $ (m_year(t_all) >= m_year(t)) =  p13_rd_stock_per_area(t_all, i2, "crop")  +
                                   v13_rd_investment.l(i2, "crop") / pc13_land(i2, "crop")
                                   * sum(delay,f13_stock_payout(delay,"%c13_payout_curve%") $ (ord(delay)-1 = m_year(t_all)-m_year(t)));

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov13_tau_core(t,h,tautype,"marginal")                   = v13_tau_core.m(h,tautype);
 ov_tech_cost(t,i,"marginal")                            = vm_tech_cost.m(i);
 ov13_cost_tc(t,i,tautype,"marginal")                    = v13_cost_tc.m(i,tautype);
 ov13_rd_stock_per_area(t,i,tautype,"marginal")          = v13_rd_stock_per_area.m(i,tautype);
 ov13_rd_investment(t,i,tautype,"marginal")              = v13_rd_investment.m(i,tautype);
 ov13_tech_cost(t,i,tautype,"marginal")                  = v13_tech_cost.m(i,tautype);
 ov_tau(t,j,tautype,"marginal")                          = vm_tau.m(j,tautype);
 ov13_tau_consv(t,h,tautype,"marginal")                  = v13_tau_consv.m(h,tautype);
 ov13_rd_stock_per_area_global(t,tautype,"marginal")     = v13_rd_stock_per_area_global.m(tautype);
 ov13_rd_investment_init(t,t_past,i,"marginal")          = v13_rd_investment_init.m(t_past,i);
 ov13_rd_stock_per_area_init(t,t_all,i,"marginal")       = v13_rd_stock_per_area_init.m(t_all,i);
 ov13_rd_stock_per_area_global_init(t,t_past,"marginal") = v13_rd_stock_per_area_global_init.m(t_past);
 ov13_tau_init(t,t_past,h,"marginal")                    = v13_tau_init.m(t_past,h);
 ov13_init_approximation_error(t,"marginal")             = v13_init_approximation_error.m;
 oq13_tech_cost(t,i,tautype,"marginal")                  = q13_tech_cost.m(i,tautype);
 oq13_rd_stock_crop(t,i,"marginal")                      = q13_rd_stock_crop.m(i);
 oq13_tech_cost_sum(t,i,"marginal")                      = q13_tech_cost_sum.m(i);
 oq13_rd_investment_crop(t,i,"marginal")                 = q13_rd_investment_crop.m(i);
 oq13_tau(t,j,tautype,"marginal")                        = q13_tau.m(j,tautype);
 oq13_tau_consv(t,h,tautype,"marginal")                  = q13_tau_consv.m(h,tautype);
 oq13_rd_stock_global(t,"marginal")                      = q13_rd_stock_global.m;
 oq13_tech_cost_init(t,t_all,i,"marginal")               = q13_tech_cost_init.m(t_all,i);
 oq13_rd_stock_crop_init(t,t_all,i,"marginal")           = q13_rd_stock_crop_init.m(t_all,i);
 oq13_rd_stock_global_init(t,t_all,"marginal")           = q13_rd_stock_global_init.m(t_all);
 oq13_init_approximation_error(t,"marginal")             = q13_init_approximation_error.m;
 ov13_tau_core(t,h,tautype,"level")                      = v13_tau_core.l(h,tautype);
 ov_tech_cost(t,i,"level")                               = vm_tech_cost.l(i);
 ov13_cost_tc(t,i,tautype,"level")                       = v13_cost_tc.l(i,tautype);
 ov13_rd_stock_per_area(t,i,tautype,"level")             = v13_rd_stock_per_area.l(i,tautype);
 ov13_rd_investment(t,i,tautype,"level")                 = v13_rd_investment.l(i,tautype);
 ov13_tech_cost(t,i,tautype,"level")                     = v13_tech_cost.l(i,tautype);
 ov_tau(t,j,tautype,"level")                             = vm_tau.l(j,tautype);
 ov13_tau_consv(t,h,tautype,"level")                     = v13_tau_consv.l(h,tautype);
 ov13_rd_stock_per_area_global(t,tautype,"level")        = v13_rd_stock_per_area_global.l(tautype);
 ov13_rd_investment_init(t,t_past,i,"level")             = v13_rd_investment_init.l(t_past,i);
 ov13_rd_stock_per_area_init(t,t_all,i,"level")          = v13_rd_stock_per_area_init.l(t_all,i);
 ov13_rd_stock_per_area_global_init(t,t_past,"level")    = v13_rd_stock_per_area_global_init.l(t_past);
 ov13_tau_init(t,t_past,h,"level")                       = v13_tau_init.l(t_past,h);
 ov13_init_approximation_error(t,"level")                = v13_init_approximation_error.l;
 oq13_tech_cost(t,i,tautype,"level")                     = q13_tech_cost.l(i,tautype);
 oq13_rd_stock_crop(t,i,"level")                         = q13_rd_stock_crop.l(i);
 oq13_tech_cost_sum(t,i,"level")                         = q13_tech_cost_sum.l(i);
 oq13_rd_investment_crop(t,i,"level")                    = q13_rd_investment_crop.l(i);
 oq13_tau(t,j,tautype,"level")                           = q13_tau.l(j,tautype);
 oq13_tau_consv(t,h,tautype,"level")                     = q13_tau_consv.l(h,tautype);
 oq13_rd_stock_global(t,"level")                         = q13_rd_stock_global.l;
 oq13_tech_cost_init(t,t_all,i,"level")                  = q13_tech_cost_init.l(t_all,i);
 oq13_rd_stock_crop_init(t,t_all,i,"level")              = q13_rd_stock_crop_init.l(t_all,i);
 oq13_rd_stock_global_init(t,t_all,"level")              = q13_rd_stock_global_init.l(t_all);
 oq13_init_approximation_error(t,"level")                = q13_init_approximation_error.l;
 ov13_tau_core(t,h,tautype,"upper")                      = v13_tau_core.up(h,tautype);
 ov_tech_cost(t,i,"upper")                               = vm_tech_cost.up(i);
 ov13_cost_tc(t,i,tautype,"upper")                       = v13_cost_tc.up(i,tautype);
 ov13_rd_stock_per_area(t,i,tautype,"upper")             = v13_rd_stock_per_area.up(i,tautype);
 ov13_rd_investment(t,i,tautype,"upper")                 = v13_rd_investment.up(i,tautype);
 ov13_tech_cost(t,i,tautype,"upper")                     = v13_tech_cost.up(i,tautype);
 ov_tau(t,j,tautype,"upper")                             = vm_tau.up(j,tautype);
 ov13_tau_consv(t,h,tautype,"upper")                     = v13_tau_consv.up(h,tautype);
 ov13_rd_stock_per_area_global(t,tautype,"upper")        = v13_rd_stock_per_area_global.up(tautype);
 ov13_rd_investment_init(t,t_past,i,"upper")             = v13_rd_investment_init.up(t_past,i);
 ov13_rd_stock_per_area_init(t,t_all,i,"upper")          = v13_rd_stock_per_area_init.up(t_all,i);
 ov13_rd_stock_per_area_global_init(t,t_past,"upper")    = v13_rd_stock_per_area_global_init.up(t_past);
 ov13_tau_init(t,t_past,h,"upper")                       = v13_tau_init.up(t_past,h);
 ov13_init_approximation_error(t,"upper")                = v13_init_approximation_error.up;
 oq13_tech_cost(t,i,tautype,"upper")                     = q13_tech_cost.up(i,tautype);
 oq13_rd_stock_crop(t,i,"upper")                         = q13_rd_stock_crop.up(i);
 oq13_tech_cost_sum(t,i,"upper")                         = q13_tech_cost_sum.up(i);
 oq13_rd_investment_crop(t,i,"upper")                    = q13_rd_investment_crop.up(i);
 oq13_tau(t,j,tautype,"upper")                           = q13_tau.up(j,tautype);
 oq13_tau_consv(t,h,tautype,"upper")                     = q13_tau_consv.up(h,tautype);
 oq13_rd_stock_global(t,"upper")                         = q13_rd_stock_global.up;
 oq13_tech_cost_init(t,t_all,i,"upper")                  = q13_tech_cost_init.up(t_all,i);
 oq13_rd_stock_crop_init(t,t_all,i,"upper")              = q13_rd_stock_crop_init.up(t_all,i);
 oq13_rd_stock_global_init(t,t_all,"upper")              = q13_rd_stock_global_init.up(t_all);
 oq13_init_approximation_error(t,"upper")                = q13_init_approximation_error.up;
 ov13_tau_core(t,h,tautype,"lower")                      = v13_tau_core.lo(h,tautype);
 ov_tech_cost(t,i,"lower")                               = vm_tech_cost.lo(i);
 ov13_cost_tc(t,i,tautype,"lower")                       = v13_cost_tc.lo(i,tautype);
 ov13_rd_stock_per_area(t,i,tautype,"lower")             = v13_rd_stock_per_area.lo(i,tautype);
 ov13_rd_investment(t,i,tautype,"lower")                 = v13_rd_investment.lo(i,tautype);
 ov13_tech_cost(t,i,tautype,"lower")                     = v13_tech_cost.lo(i,tautype);
 ov_tau(t,j,tautype,"lower")                             = vm_tau.lo(j,tautype);
 ov13_tau_consv(t,h,tautype,"lower")                     = v13_tau_consv.lo(h,tautype);
 ov13_rd_stock_per_area_global(t,tautype,"lower")        = v13_rd_stock_per_area_global.lo(tautype);
 ov13_rd_investment_init(t,t_past,i,"lower")             = v13_rd_investment_init.lo(t_past,i);
 ov13_rd_stock_per_area_init(t,t_all,i,"lower")          = v13_rd_stock_per_area_init.lo(t_all,i);
 ov13_rd_stock_per_area_global_init(t,t_past,"lower")    = v13_rd_stock_per_area_global_init.lo(t_past);
 ov13_tau_init(t,t_past,h,"lower")                       = v13_tau_init.lo(t_past,h);
 ov13_init_approximation_error(t,"lower")                = v13_init_approximation_error.lo;
 oq13_tech_cost(t,i,tautype,"lower")                     = q13_tech_cost.lo(i,tautype);
 oq13_rd_stock_crop(t,i,"lower")                         = q13_rd_stock_crop.lo(i);
 oq13_tech_cost_sum(t,i,"lower")                         = q13_tech_cost_sum.lo(i);
 oq13_rd_investment_crop(t,i,"lower")                    = q13_rd_investment_crop.lo(i);
 oq13_tau(t,j,tautype,"lower")                           = q13_tau.lo(j,tautype);
 oq13_tau_consv(t,h,tautype,"lower")                     = q13_tau_consv.lo(h,tautype);
 oq13_rd_stock_global(t,"lower")                         = q13_rd_stock_global.lo;
 oq13_tech_cost_init(t,t_all,i,"lower")                  = q13_tech_cost_init.lo(t_all,i);
 oq13_rd_stock_crop_init(t,t_all,i,"lower")              = q13_rd_stock_crop_init.lo(t_all,i);
 oq13_rd_stock_global_init(t,t_all,"lower")              = q13_rd_stock_global_init.lo(t_all);
 oq13_init_approximation_error(t,"lower")                = q13_init_approximation_error.lo;
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
