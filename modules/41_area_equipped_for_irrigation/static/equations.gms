*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @equations
  
 q41_area_irrig(j2) .. 
 sum(kcr, vm_area(j2,kcr,"irrigated")) =l= v41_AEI(j2);

*' This realization assures that irrigated crop production can only take place where
*' irrigation infrastructure is present, i.e. the sum of irrigated cropland `vm_area(j,kcr,"irrigated")`
*' over all crops in each grid cell has to be less than or equal to the area in this grid cell that is
*' equipped with irrigation infrastructure (`v41_AEI(j)`).