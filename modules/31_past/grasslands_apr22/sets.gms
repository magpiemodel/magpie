*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

sets

 f31_luh LHUv2 land cover types
   / primf, primn, secdf, secdn, urban, c3ann, c4ann, c3per, c4per, c3nfx, pastr, range /

 grassland(f31_luh) Grassland cover types (pastr = managed pastures and range = rangelands)
   / pastr, range /

 grass_to31(grassland) pasture management options
   / pastr,range /

 grass_from31(grassland) pasture management options
   / pastr,range /

;
