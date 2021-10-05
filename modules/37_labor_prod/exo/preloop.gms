*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

pm_labor_prod(t,j) = f37_labor_prod_cc(t,j,"%c37_labour_rcp%","%c37_labour_metric%","%c37_labour_intensity%","%c37_labour_uncertainty%");
*pm_labor_prod(t,j)$(pm_labor_prod_cc(t,j) = 0) = 1;
