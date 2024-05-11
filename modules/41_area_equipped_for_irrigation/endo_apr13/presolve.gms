*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

p41_AEI_start(t,j) = pc41_AEI_start(j);

*' Updating existing capital stocks to account for depreciation
vm_AEI.lo(j) = pc41_AEI_start(j) / ((1 - s41_AEI_depreciation)**(m_timestep_length));

*' Unit costs for irrigation expansion
pc41_unitcost_AEI(i) = f41_c_irrig(t,i);
