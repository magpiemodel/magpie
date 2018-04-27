*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de


*' @equations


 q38_cost_prod_crop(i2,kcr) ..
   vm_cost_prod(i2,kcr) =e= sum((cell(i2,j2), w), vm_area(j2,kcr,w)*f38_region_yield(i2,kcr)
                                                  *vm_tau(i2)/fm_tau1995(i2)*f38_fac_req(kcr,w));


*' The equation above shows that factor requirement costs `vm_cost_prod` mainly depends on area harvested `vm_area`.
*' The crop-and-water specific factor costs per tone of factor costs `f38_fac_req`
*' are obtained from a cross-sectional regression linking part of value-added costs extracted from GTAP6,
*' and crop production and area harvested from FAO.
*' We, then, use regional crop-specific yields `f38_region_yield` to convert
*' these average global crop-specific per tone costs into region-crop-specific per area costs.
*' The equation also shows that costs at each time step will be influenced by the $\tau$ - `vm_tau`
*' at each time step relative to the initial $\tau$ - in 1995 `fm_tau1995`.
*' This is based on empirical observation (cf. @dietrich_measuring_2012 and @dietrich_forecasting_2014)
*' such that factor requirement costs move together with costs of agricultural technology.
*' Of course, the positive association between factor costs and technological changes somehow reflects the substitutability 
*' between factors and productivity enhancing investments. 
*' Remember that the cross-price elasticity of demand of substitutes is positive. 
*' That is, other things remaining constant, higher technological costs will induce
*' higher employment of labor and capital which in turn increases total factor costs of production.
*' It is important to mention here that the part of value-added costs that we extract from GTAP6
*' excludes land rents (as MAgPIE calculates land rents endogenously),
*' chemical fertilizer (as it is calculated in [50_nr_soil_budget] module),
*' and costs of intermediate inputs from the agriculture sector itself, e.g., seeds (see in [16_demand])
*' in order to avoid double counting in the model.
*' Making factor costs dependent on area limits cropland land expansion,
*' and thus helps to allocate production into most productive regions.
*' Nonetheless,since the production costs in this realization do not depend on the cellular yields,
*' production costs per area are the same for all cells within a regions
*' no matter whether they are high-or low-productive.
*' This implicitly gives an incentive to allocate and concentrate production in high-productive cells.
*' By including the regional average yield level in the cost function,
*' factor costs per area are relatively high for regions with high levels of crop yields.
*' On the other hand, for given product prices, profit in low yield regions may accrue to lower production costs.
