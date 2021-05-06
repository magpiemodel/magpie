*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

i39_cost_establish(t,land) = 0;
i39_cost_establish(t,land_establish39) = s39_cost_establish;

i39_cost_clearing(t,land) = 0;
i39_cost_clearing(t,land_clearing39) = f39_cost_fader(t) * s39_cost_clearing;
