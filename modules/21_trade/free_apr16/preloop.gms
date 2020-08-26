*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de



*set vm_cost_trade zero in order to avoid a free variable
vm_cost_trade.fx(i)               = 0;

pm_selfsuff_ext(t_ext,i,kforestry) = f21_self_suff("y2150",i,kforestry);
pm_selfsuff_ext(t_all,i,kforestry) = f21_self_suff(t_all,i,kforestry);
