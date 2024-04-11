*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

sets
  t_ini10  Time periods with land initialization data
       / y1995, y2000, y2005, y2010, y2015 /

  luh2_side_layers10 side layers from LUH2
       / manpast, rangeland, primveg, secdveg, forested, nonforested /

  potnatveg(luh2_side_layers10) potentially forested biomes
       / forested, nonforested /
;

  alias(land,land_from);
  alias(land,land_to);
