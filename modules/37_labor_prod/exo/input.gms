*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

$setglobal c37_labour_rcp  rcp119
$setglobal c37_labour_metric  ISO
$setglobal c37_labour_intensity  400W
$setglobal c37_labour_uncertainty  ensmean

table f37_labor_prod(t_all,j,rcp37,metric37,intensity37,uncertainty37) labour productivity factor (1)
$ondelim
$include "./modules/37_labor_prod/exo/input/f37_labourprodimpact.cs3"
$offdelim
;
m_fillmissingyears(f37_labor_prod,"j,rcp37,metric37,intensity37,uncertainty37");
