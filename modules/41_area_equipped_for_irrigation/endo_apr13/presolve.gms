*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

p41_AEI_start(t,j) = pc41_AEI_start(j);
v41_AEI.lo(j) = pc41_AEI_start(j);

pc41_cost_AEI_past(i) = p41_cost_AEI_past(t,i);
pc41_unitcost_AEI(i) = f41_c_irrig(t,i);
