*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations


 q38_cost_prod_crop(i2,kcr) ..
  vm_cost_prod(i2,kcr) =e= vm_prod_reg(i2,kcr) * f38_fac_req_per_ton(kcr);

  q38_cost_prod_inv(i2).. vm_cost_inv(i2)=e=0;


*' The factor requirement costs `vm_cost_prod` are  calculated as product of
*' production quantity `vm_prod_reg` and crop-specific world average
*' factor costs of production per volume `f38_fac_req_per_ton`.
*' The volume depending factor costs, which remains fixed overtime, are obtained
*' from value-added costs which correspond to the factor of production included
*' in this module from GTAP7 (@narayanan_gtap7_2008).
*' It worth to mention again that the factor costs in this module
*' do not include land rents (as MAgPIE calculates land rents endogenously),
*' chemical fertilizer costs (as they are calculated in [50_nr_soil_budget]
*' module), and costs of agricultural intermediate inputs such as seeds
*' (to avoid double counting in the model).
