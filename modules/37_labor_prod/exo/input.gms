*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

$setglobal c37_labor_prod_scenario  cc
*   options:  cc        (climate change)
*             nocc      (no climate change)
*             nocc_hist (no climate change after year defined by sm_fix_cc)

$setglobal c37_labor_rcp  rcp119
$setglobal c37_labor_metric  ISO
$setglobal c37_labor_intensity  400W
$setglobal c37_labor_uncertainty  ensmean

table f37_labor_prod(t_all,j,rcp37,metric37,intensity37,uncertainty37) labor productivity factor (1)
$ondelim
$include "./modules/37_labor_prod/exo/input/f37_labourprodimpact.cs3"
$offdelim
;
m_fillmissingyears(f37_labor_prod,"j,rcp37,metric37,intensity37,uncertainty37");
* set values in different data sets between 1995 and the year set by sm_fix_cc to values from the default setting.
f37_labor_prod(t_all,j,rcp37,metric37,intensity37,uncertainty37)$(m_year(t_all) <= sm_fix_cc) = 
f37_labor_prod(t_all,j,"rcp119","ISO","400W","ensmean")$(m_year(t_all) <= sm_fix_cc);
