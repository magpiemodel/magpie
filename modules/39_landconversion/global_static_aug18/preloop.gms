*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

s39_cost_establish = 8000;
s39_cost_clearing = 5;

i39_cost_establish(land) = 0;
i39_cost_establish(land_establish39) = s39_cost_establish;

i39_cost_clearing(land) = 0;
i39_cost_clearing(land_clearing39) = s39_cost_clearing;

p39_cost_landcon_past(t,j,land) = 0;
