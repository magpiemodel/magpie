*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @equations


 q38_cost_prod_crop(i2,kcr) ..
   vm_cost_prod(i2,kcr) =e= vm_prod_reg(i2,kcr) * f38_fac_req_per_ton(kcr);

   
*' The factor requirement costs `vm_cost_prod` are the product of the quantity of production `vm_prod` 
*' and crop-specific world average fixed per tone of production `f38_fac_req`.
*' The fixed per tone costs are obtained from a cross-sectional regression 
*' linking part of value-added costs from GTAP6
*' ,and crop production and area harvested from FAO.
*' Here, again, it is important to recall that the part of value-added costs from GTAP6
*' that went as dependent variable in our regression excludes land rents 
*' (as MAgPIE calculates land rents endogenously)
*' , chemical fertilizer as it is calculated in ([50_nr_soil_budget]) module.
*' , and costs of intermediate inputs from the agriculture sector
*' e.g., seeds (see in [16_demand]) in order to avoid double counting in the model.