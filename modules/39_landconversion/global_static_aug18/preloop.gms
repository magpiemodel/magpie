*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

s39_cost_establish = 8000;
s39_cost_clearing = 100;

i39_cost_establish(land) = 0;
i39_cost_establish(land_establish39) = s39_cost_establish;

i39_cost_clearing(land) = 0;
i39_cost_clearing(land_clearing39) = s39_cost_clearing;

p39_cost_landcon_past(t,j,land) = 0;
