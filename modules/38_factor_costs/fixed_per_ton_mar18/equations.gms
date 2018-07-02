*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @equations


 q38_cost_prod_crop(i2,kcr) ..
  vm_cost_prod(i2,kcr) =e= vm_prod_reg(i2,kcr) * f38_fac_req_per_ton(kcr);

   
*' The factor requirement costs, `vm_cost_prod`, is the product of the quantity of production (`vm_prod_reg`)
*' and crop-specific world average per tone of production (`f38_fac_req_per_ton`) factor costs of production.
*' The per tone factor costs, which remains fixed overtime, are obtained from a cross-country regression
*' linking parts of value-added costs(which correspond to the factor of production included in this module) 
*' from GTAP7, @narayanan_gtap7_2008, and crop production and area harvested from @FAOSTAT.
*' It worth to mention again that the factor costs in this module
*' doesn't include land rents (as MAgPIE calculates land rents endogenously),
*' chemical fertilizer costs (as they are calculated in [50_nr_soil_budget] module),
*' and costs of agricultural intermediate inputs such as seeds (to avoid double counting in the model).