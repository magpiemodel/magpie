*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

i39_cost_establish(t,i,"crop")$(im_governance_indicator(t,i) < 0.4) = 2000;
i39_cost_establish(t,i,"crop")$(im_governance_indicator(t,i) >= 0.4) = s39_cost_establish_crop*im_governance_indicator(t,i);
