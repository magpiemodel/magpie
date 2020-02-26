*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

$ifthen "%c60_2ndgen_biodem%" == "coupling" i60_bioenergy_dem(t,i) = f60_bioenergy_dem_coupling(t,i);
$elseif "%c60_2ndgen_biodem%" == "emulator" i60_bioenergy_dem(t,i) = f60_bioenergy_dem_emulator(t)/card(i);
$else i60_bioenergy_dem(t,i) = f60_bioenergy_dem(t,i,"%c60_2ndgen_biodem%");
$endif
* Add minimal bioenergy demand in case of zero demand to avoid zero prices
i60_bioenergy_dem("y2005",i) = 0;
i60_bioenergy_dem("y2010",i) = 0;
i60_bioenergy_dem(t,i)$(i60_bioenergy_dem(t,i) = 0) = 0.01;


i60_res_2ndgenBE_dem(t,i) =
             f60_res_2ndgenBE_dem(t,i,"%c60_res_2ndgenBE_dem%");

i60_1stgen_bioenergy_dem(t,i,kall) =
             f60_1stgen_bioenergy_dem(t,i,"%c60_1stgen_biodem%",kall);
