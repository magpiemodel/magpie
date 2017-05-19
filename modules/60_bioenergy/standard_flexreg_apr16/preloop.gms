*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

$ifthen "%c60_2ndgen_biodem%" == "coupling" i60_bioenergy_dem(t,i) = f60_bioenergy_dem_coupling(t,i);
$else i60_bioenergy_dem(t,i) = f60_bioenergy_dem(t,i,"%c60_2ndgen_biodem%");
$endif
* Add minimal bioenergy demand to avoid zero prices
i60_bioenergy_dem(t,i) = i60_bioenergy_dem(t,i) + 0.01;