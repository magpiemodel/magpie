*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

v44_bv_weighted.l(j) = 0.3;
m_linear_time_interpol(p44_price_bv_loss,s44_start_year,s44_target_year,s44_start_price,s44_target_price);
p44_price_bv_loss(t_all)$(m_year(t_all) < s44_start_year) = 0;
display p44_price_bv_loss;
