*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations

*' BLUB

q73_cost_timber(i2)..
                    vm_cost_timber(i2)
                    =e=
                      sum(cell(i2,j2), vm_prod(j2,"wood"))      * s73_timber_prod_cost_wood
                    + sum(cell(i2,j2), vm_prod(j2,"woodfuel"))  * s73_timber_prod_cost_woodfuel
					;

q73_est(j2).. 
	sum(ac_est, v32_land(j2,"plant",ac_est)) =e= sum(ac_sub, vm_hvarea_forestry(j2,ac_sub));
