*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations
*' The equation of this realization is straight forward.
*' Costs of processing are calculated by the product of the quantity of secondary products and the unit processing costs
*' and unit processing costs (which arbitrarily is set to be 5000 USD for all processing types and secondary products).

q20_processing_costs(i2) ..
  vm_cost_processing(i2) =e= sum(ksd, vm_prod_reg(i2,ksd) * 5000);
