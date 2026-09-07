*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov21_cost_tariff_reg(t,i,k_trade,"marginal")                = v21_cost_tariff_reg.m(i,k_trade);
 ov21_trade(t,i_ex,i_im,k_trade,"marginal")                  = v21_trade.m(i_ex,i_im,k_trade);
 ov21_cost_margin_reg(t,i,k_trade,"marginal")                = v21_cost_margin_reg.m(i,k_trade);
 ov_cost_trade_tariff(t,i,"marginal")                        = vm_cost_trade_tariff.m(i);
 ov_cost_trade_margin(t,i,"marginal")                        = vm_cost_trade_margin.m(i);
 ov_cost_trade_feasibility(t,i,"marginal")                   = vm_cost_trade_feasibility.m(i);
 ov21_import_for_feasibility(t,i_ex,i_im,k_trade,"marginal") = v21_import_for_feasibility.m(i_ex,i_im,k_trade);
 oq21_notrade(t,h,k_notrade,"marginal")                      = q21_notrade.m(h,k_notrade);
 oq21_trade_reg(t,h,k_trade,"marginal")                      = q21_trade_reg.m(h,k_trade);
 oq21_trade_lower(t,i_ex,i_im,k_trade,"marginal")            = q21_trade_lower.m(i_ex,i_im,k_trade);
 oq21_trade_upper(t,i_ex,i_im,k_trade,"marginal")            = q21_trade_upper.m(i_ex,i_im,k_trade);
 oq21_costs_tariffs(t,i,k_trade,"marginal")                  = q21_costs_tariffs.m(i,k_trade);
 oq21_costs_margins(t,i,k_trade,"marginal")                  = q21_costs_margins.m(i,k_trade);
 oq21_cost_trade_tariff(t,i,"marginal")                      = q21_cost_trade_tariff.m(i);
 oq21_cost_trade_margin(t,i,"marginal")                      = q21_cost_trade_margin.m(i);
 oq21_cost_trade_feasibility(t,i,"marginal")                 = q21_cost_trade_feasibility.m(i);
 ov21_cost_tariff_reg(t,i,k_trade,"level")                   = v21_cost_tariff_reg.l(i,k_trade);
 ov21_trade(t,i_ex,i_im,k_trade,"level")                     = v21_trade.l(i_ex,i_im,k_trade);
 ov21_cost_margin_reg(t,i,k_trade,"level")                   = v21_cost_margin_reg.l(i,k_trade);
 ov_cost_trade_tariff(t,i,"level")                           = vm_cost_trade_tariff.l(i);
 ov_cost_trade_margin(t,i,"level")                           = vm_cost_trade_margin.l(i);
 ov_cost_trade_feasibility(t,i,"level")                      = vm_cost_trade_feasibility.l(i);
 ov21_import_for_feasibility(t,i_ex,i_im,k_trade,"level")    = v21_import_for_feasibility.l(i_ex,i_im,k_trade);
 oq21_notrade(t,h,k_notrade,"level")                         = q21_notrade.l(h,k_notrade);
 oq21_trade_reg(t,h,k_trade,"level")                         = q21_trade_reg.l(h,k_trade);
 oq21_trade_lower(t,i_ex,i_im,k_trade,"level")               = q21_trade_lower.l(i_ex,i_im,k_trade);
 oq21_trade_upper(t,i_ex,i_im,k_trade,"level")               = q21_trade_upper.l(i_ex,i_im,k_trade);
 oq21_costs_tariffs(t,i,k_trade,"level")                     = q21_costs_tariffs.l(i,k_trade);
 oq21_costs_margins(t,i,k_trade,"level")                     = q21_costs_margins.l(i,k_trade);
 oq21_cost_trade_tariff(t,i,"level")                         = q21_cost_trade_tariff.l(i);
 oq21_cost_trade_margin(t,i,"level")                         = q21_cost_trade_margin.l(i);
 oq21_cost_trade_feasibility(t,i,"level")                    = q21_cost_trade_feasibility.l(i);
 ov21_cost_tariff_reg(t,i,k_trade,"upper")                   = v21_cost_tariff_reg.up(i,k_trade);
 ov21_trade(t,i_ex,i_im,k_trade,"upper")                     = v21_trade.up(i_ex,i_im,k_trade);
 ov21_cost_margin_reg(t,i,k_trade,"upper")                   = v21_cost_margin_reg.up(i,k_trade);
 ov_cost_trade_tariff(t,i,"upper")                           = vm_cost_trade_tariff.up(i);
 ov_cost_trade_margin(t,i,"upper")                           = vm_cost_trade_margin.up(i);
 ov_cost_trade_feasibility(t,i,"upper")                      = vm_cost_trade_feasibility.up(i);
 ov21_import_for_feasibility(t,i_ex,i_im,k_trade,"upper")    = v21_import_for_feasibility.up(i_ex,i_im,k_trade);
 oq21_notrade(t,h,k_notrade,"upper")                         = q21_notrade.up(h,k_notrade);
 oq21_trade_reg(t,h,k_trade,"upper")                         = q21_trade_reg.up(h,k_trade);
 oq21_trade_lower(t,i_ex,i_im,k_trade,"upper")               = q21_trade_lower.up(i_ex,i_im,k_trade);
 oq21_trade_upper(t,i_ex,i_im,k_trade,"upper")               = q21_trade_upper.up(i_ex,i_im,k_trade);
 oq21_costs_tariffs(t,i,k_trade,"upper")                     = q21_costs_tariffs.up(i,k_trade);
 oq21_costs_margins(t,i,k_trade,"upper")                     = q21_costs_margins.up(i,k_trade);
 oq21_cost_trade_tariff(t,i,"upper")                         = q21_cost_trade_tariff.up(i);
 oq21_cost_trade_margin(t,i,"upper")                         = q21_cost_trade_margin.up(i);
 oq21_cost_trade_feasibility(t,i,"upper")                    = q21_cost_trade_feasibility.up(i);
 ov21_cost_tariff_reg(t,i,k_trade,"lower")                   = v21_cost_tariff_reg.lo(i,k_trade);
 ov21_trade(t,i_ex,i_im,k_trade,"lower")                     = v21_trade.lo(i_ex,i_im,k_trade);
 ov21_cost_margin_reg(t,i,k_trade,"lower")                   = v21_cost_margin_reg.lo(i,k_trade);
 ov_cost_trade_tariff(t,i,"lower")                           = vm_cost_trade_tariff.lo(i);
 ov_cost_trade_margin(t,i,"lower")                           = vm_cost_trade_margin.lo(i);
 ov_cost_trade_feasibility(t,i,"lower")                      = vm_cost_trade_feasibility.lo(i);
 ov21_import_for_feasibility(t,i_ex,i_im,k_trade,"lower")    = v21_import_for_feasibility.lo(i_ex,i_im,k_trade);
 oq21_notrade(t,h,k_notrade,"lower")                         = q21_notrade.lo(h,k_notrade);
 oq21_trade_reg(t,h,k_trade,"lower")                         = q21_trade_reg.lo(h,k_trade);
 oq21_trade_lower(t,i_ex,i_im,k_trade,"lower")               = q21_trade_lower.lo(i_ex,i_im,k_trade);
 oq21_trade_upper(t,i_ex,i_im,k_trade,"lower")               = q21_trade_upper.lo(i_ex,i_im,k_trade);
 oq21_costs_tariffs(t,i,k_trade,"lower")                     = q21_costs_tariffs.lo(i,k_trade);
 oq21_costs_margins(t,i,k_trade,"lower")                     = q21_costs_margins.lo(i,k_trade);
 oq21_cost_trade_tariff(t,i,"lower")                         = q21_cost_trade_tariff.lo(i);
 oq21_cost_trade_margin(t,i,"lower")                         = q21_cost_trade_margin.lo(i);
 oq21_cost_trade_feasibility(t,i,"lower")                    = q21_cost_trade_feasibility.lo(i);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
