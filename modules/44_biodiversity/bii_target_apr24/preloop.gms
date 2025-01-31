*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

* Calculate biome share
i44_biome_share(j,biome44) = 0;
i44_biome_share(j,biome44)$(sum(biome44_2, f44_biome_area(j,biome44_2)) > 0) = 
   f44_biome_area(j,biome44) / sum(biome44_2, f44_biome_area(j,biome44_2));

* Set i44_biome_area_reg
i44_biome_area_reg(i,biome44) = 
  sum((cell(i,j),land), pcm_land(j,land) * f44_rr_layer(j) * i44_biome_share(j,biome44));

p44_bii_lower_bound(t,i,biome44) = 0;
