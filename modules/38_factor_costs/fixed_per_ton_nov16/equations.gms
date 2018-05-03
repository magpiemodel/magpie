*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de


*' @equations


 q38_cost_prod_crop(i2,kcr) ..
   vm_cost_prod(i2,kcr) =e= sum((cell(i2,j2), w), vm_area(j2,kcr,w)*vm_yld(j2,kcr,w)
                                                           *f38_fac_req(kcr,w));



*' The factor requirement costs `vm_cost_prod` are the product of the volume of production (area times yield) and fixed per tone factor costs.
*' by multiplying the quantity of production with `vm_area` times `vm_yld`.
*' The crop-and-water specific factor costs per tone of production `f38_fac_req`
*' are obtained from a cross-sectional regression linking part of value-added costs from GTAP6
*' (see also and crop production and area harvested from FAO.

*' It is important to mention here that the part of value-added costs that we extract from GTAP6
*' excludes land rents (as MAgPIE calculates land rents endogenously)
*', chemical fertilizer as it is calculated in ([50_nr_soil_budget]) module)
*', and costs of intermediate inputs from the agriculture sector, e.g., seeds
*' in order to avoid double counting in the model.
