*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations

 q38_cost_prod_crop_labor(i2) ..
  vm_cost_prod_crop(i2,"labor") =e= sum(kcr, vm_prod_reg(i2,kcr) * sum(ct,i38_fac_req(ct,i2,kcr))) * 
                                    sum(ct,pm_cost_share_crops(ct,i2,"labor") * (1/pm_productivity_gain_from_wages(ct,i2)) * 
                                    (pm_hourly_costs(ct,i2,"scenario") / pm_hourly_costs(ct,i2,"baseline")));

 q38_cost_prod_crop_capital(i2) ..
  vm_cost_prod_crop(i2,"capital") =e= sum(kcr, vm_prod_reg(i2,kcr) * sum(ct,i38_fac_req(ct,i2,kcr))) *
                                      sum(ct,pm_cost_share_crops(ct,i2,"capital"));

*' The factor costs for crops `vm_cost_prod_crop` are calculated as product of
*' production quantity `vm_prod_reg` and crop-specific factor requirements
*' (either global or regional averages) per volume of production `i38_fac_req`.
*' The volume depending factor requirements, which remain fixed overtime, are obtained
*' from FAO Value of Production, to which the USDA factor cost share out of total 
*' costs was applied. Labor and capital costs are split by applying the corresponding
*' share out of total factor costs.
*' To account for increased hourly labor costs and producitivity in case of an external 
*' wage scenario, the total labor costs are scaled by the corresponding increase in hourly
*' labor costs and the related productivity gain from [36_employment].
*'
*' It is worth to mention again that the factor costs in this module
*' do not include land rents (as MAgPIE calculates land rents endogenously),
*' chemical fertilizer costs (as they are calculated in [50_nr_soil_budget]
*' module), and costs of agricultural intermediate inputs such as seeds
*' (to avoid double counting in the model).
