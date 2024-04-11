*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

pm_labor_prod(t,j) = f37_labor_prod(t,j,"%c37_labor_rcp%","%c37_labor_metric%","%c37_labor_intensity%","%c37_labor_uncertainty%");
* set values to 1995 if nocc scenario is used, or to sm_fix_cc after sm_fix_cc if nocc_hist is used
$if "%c37_labor_prod_scenario%" == "nocc" pm_labor_prod(t,j) = pm_labor_prod("y1995",j);
$if "%c37_labor_prod_scenario%" == "nocc_hist" pm_labor_prod(t,j)$(m_year(t_all) > sm_fix_cc) = pm_labor_prod(t,j)$(m_year(t_all) = sm_fix_cc);
