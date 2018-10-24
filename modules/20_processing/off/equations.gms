*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @equations
*' The equation of this realization is straight forward.
*' Costs of processing are calculated by the product of the quantity of secondary products and the unit processing costs
*' and unit processing costs (which arbitrarily is set to be 5000 USD for all processing types and secondary products).

q20_processing_costs(i2) ..
  vm_cost_processing(i2) =e= sum(ksd, vm_prod_reg(i2,ksd) * 5000);
