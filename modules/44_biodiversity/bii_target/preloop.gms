*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

i44_biome_share(j,biome44) = 0;
i44_biome_share(j,biome44)$(sum(land, pcm_land(j,land)) > 0) = f44_biome_area(j,biome44) / sum(land, pcm_land(j,land));

i44_biome_area_reg(i,biome44) = 
  sum((cell(i,j),land), pcm_land(j,land) * i44_biome_share(j,biome44));

loop(i,
  loop(biome44,
    if(i44_biome_area_reg(i,biome44) <= 0,
      v44_bii.fx(i,biome44) = 0;
      v44_bii_missing.fx(i,biome44) = 0;
    else
      v44_bii.l(i,biome44) = 
        sum((cell(i,j),potnatveg,landcover44), vm_bv.l(j,landcover44,potnatveg) * i44_biome_share(j,biome44))
        / i44_biome_area_reg(i,biome44);
    );
  );
);

p44_bii_lower_bound(t,i,biome44) = 0;
