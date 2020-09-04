*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

$setglobal c43_watavail_scenario  nocc
*   options:   cc  (climate change)
*             nocc (no climate change)

parameters
f43_wat_avail(t_all,j) Surface water available for irrigation per cell from LPJmL (mio. m^3 per yr)
/
$ondelim
$include "./modules/43_water_availability/input/lpj_watavail_grper.cs2"
$offdelim
/
;
$if "%c43_watavail_scenario%" == "nocc" f43_wat_avail(t_all,j) = f43_wat_avail("y1995",j);
m_fillmissingyears(f43_wat_avail,"j");
