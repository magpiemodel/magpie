*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @code Timber production is fixed to 0 in case the model is run without
*' dynamic forestry turned on.

vm_prod_cell_forestry.fx(j,kforestry) = 0;
vm_prod_cell_natveg.fx(j,kforestry) = 0;
vm_prod.fx(j,kforestry) = 0;
vm_prod_heaven_timber.fx(j,kforestry)  = 0;

*' @stop
