*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @equations

q41_area_irrig(j2) ..
	sum(kcr, vm_area(j2,kcr,"irrigated")) =l= v41_AEI(j2);
	

q41_cost_AEI_annuity(i2)..  
	v41_cost_AEI_annuity(i2) =e=
    sum(cell(i2,j2),(v41_AEI(j2)-pc41_AEI_start(j2)))
	* pc41_unitcost_AEI(i2)*pm_interest(i2)/(1+pm_interest(i2));

*' Investment costs in the current time step for each region are calculated by multiplying the AEI expansion in each
*' cluster of the region by the regional unit cost per hectare.
*' MAgPIE has a common planning horizon to which all one time investments are distributed using an annuity
*' approach. Due to this distribution, part of the costs from previous investments in AEI still entail costs
*' in the current time step.

q41_cost_AEI(i2)..  
	vm_cost_AEI(i2) =e=
    v41_cost_AEI_annuity(i2) + pc41_cost_AEI_past(i2);
