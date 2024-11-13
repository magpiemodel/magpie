*** |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

* Calculate biome share
i44_biome_share(j,biome44) = 
   (f44_biome_area(j,biome44) + 1e-10) / sum(biome44_2, f44_biome_area(j,biome44_2) + 1e-10);

* Update i44_biome_area_reg
i44_biome_area_reg(i,biome44) = 
  sum((cell(i,j),land), pcm_land(j,land) * f44_rr_layer(j) * i44_biome_share(j,biome44));

* Update v44_bii.l based on vm_bv.l
loop(i,
  loop(biome44,
    if(i44_biome_area_reg(i,biome44) <= 0,
      v44_bii.fx(i,biome44) = 0;
      v44_bii_missing.fx(i,biome44) = 0;
    else
      v44_bii.l(i,biome44) = 
        sum((cell(i,j),potnatveg,landcover44), vm_bv.l(j,landcover44,potnatveg) * f44_rr_layer(j) * i44_biome_share(j,biome44))
        / i44_biome_area_reg(i,biome44);
    );
  );
);

p44_bii_lower_bound(t,i,biome44) = 0;
