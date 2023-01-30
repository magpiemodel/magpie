*** |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations
*' For all commodites, the regional supply should be larger or equal to the
*' regional demand.

q21_notrade(h2,kall)..
  sum(supreg(h2,i2),vm_prod_reg(i2,kall)) =g= sum(supreg(h2,i2), vm_supply(i2,kall));
