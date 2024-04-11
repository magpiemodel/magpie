*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations

q41_area_irrig(j2) ..
  sum(kcr, vm_area(j2,kcr,"irrigated")) =l= vm_AEI(j2);


*' Investment costs in the current time step for each region are calculated by multiplying the AEI expansion in each
*' cluster of the region by the regional unit cost per hectare and a depreciation rate.
*' MAgPIE has a common planning horizon to which all one time investments are distributed using an annuity
*' approach.

q41_cost_AEI(i2)..
  vm_cost_AEI(i2) =e=
    sum(cell(i2,j2),(vm_AEI(j2)-pc41_AEI_start(j2)))
  * pc41_unitcost_AEI(i2)
  *((1-s41_AEI_depreciation)*
  sum(ct,pm_interest(ct,i2)/(1+pm_interest(ct,i2)))
      + s41_AEI_depreciation)
      ;
