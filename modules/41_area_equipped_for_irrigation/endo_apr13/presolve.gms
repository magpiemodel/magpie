*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

p41_AEI_start(t,j) = pc41_AEI_start(j);
v41_AEI.lo(j) = pc41_AEI_start(j);

pc41_cost_AEI_past(i) = p41_cost_AEI_past(t,i);
pc41_unitcost_AEI(i) = f41_c_irrig(t,i);
