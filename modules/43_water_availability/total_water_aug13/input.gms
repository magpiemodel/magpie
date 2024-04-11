*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


$setglobal c43_watavail_scenario  cc
*   options:   cc       (climate change)
*             nocc      (no climate change)
*             nocc_hist (no climate change after year defined by sm_fix_cc)


parameters
f43_wat_avail(t_all,j) Surface water available for irrigation per cell from LPJmL (mio. m^3 per yr)
/
$ondelim
$include "./modules/43_water_availability/input/lpj_watavail_grper.cs2"
$offdelim
/
;
* set values to 1995 if nocc scenario is used, or to sm_fix_cc after sm_fix_cc if nocc_hist is used
$ifthen "%c43_watavail_scenario%" == "nocc" f43_wat_avail(t_all,j) = f43_wat_avail("y1995",j);
$elseif "%c43_watavail_scenario%" == "nocc_hist" f43_wat_avail(t_all,j)$(m_year(t_all) > sm_fix_cc) = f43_wat_avail(t_all,j)$(m_year(t_all) = sm_fix_cc);
$endif
m_fillmissingyears(f43_wat_avail,"j");
