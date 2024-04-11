*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations

 q41_area_irrig(j2) ..
 sum(kcr, vm_area(j2,kcr,"irrigated")) =l= vm_AEI(j2);

*' This realization assures that irrigated crop production can only take place where
*' irrigation infrastructure is present, i.e. the sum of irrigated cropland `vm_area(j,kcr,"irrigated")`
*' over all crops in each grid cell has to be less than or equal to the area in this grid cell that is
*' equipped with irrigation infrastructure (`vm_AEI(j)`).
