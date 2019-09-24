*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @code Timber production is fixed to 0 in case the model is run without
*' dynamic forestry turned on.

*vm_prod.fx(j,kforestry) = 0;

*' Wood demand is set to zero because forestry is not modeled in this realization.
*vm_supply.fx(i2,kforestry) = 0;

*' @stop
