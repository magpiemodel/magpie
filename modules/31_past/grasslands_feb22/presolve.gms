*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

$ontext
v31_grass_area.up(j2,"range","rainfed")$(cell("CAZ",j2)) = f31_LUH2v2("y2010",j2,"range");
v31_grass_area.up(j2,"range","rainfed")$(cell("CHA",j2)) = f31_LUH2v2("y2010",j2,"range");
v31_grass_area.up(j2,"range","rainfed")$(cell("EUR",j2)) = f31_LUH2v2("y2010",j2,"range");
v31_grass_area.up(j2,"range","rainfed")$(cell("IND",j2)) = f31_LUH2v2("y2010",j2,"range");
v31_grass_area.up(j2,"range","rainfed")$(cell("JPN",j2)) = f31_LUH2v2("y2010",j2,"range");
v31_grass_area.up(j2,"range","rainfed")$(cell("MEA",j2)) = f31_LUH2v2("y2010",j2,"range");
v31_grass_area.up(j2,"range","rainfed")$(cell("NEU",j2)) = f31_LUH2v2("y2010",j2,"range");
v31_grass_area.up(j2,"range","rainfed")$(cell("REF",j2)) = f31_LUH2v2("y2010",j2,"range");
v31_grass_area.up(j2,"range","rainfed")$(cell("SSA",j2)) = f31_LUH2v2("y2010",j2,"range");
v31_grass_area.up(j2,"range","rainfed")$(cell("USA",j2)) = f31_LUH2v2("y2010",j2,"range");
$offtext

*v31_grass_area.up(j2,"range","rainfed") = f31_LUH2v2("y2010",j2,"range");
