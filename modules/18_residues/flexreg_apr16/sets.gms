*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


sets

dm_nr(attributes) dry matter and nr
/dm, nr, c/

pk18(npk) subset of npk containing P and K nutrients
/p, k/

dev18 country develoment indicator
/high_income,low_income/

burn_scen18 scenario for burning residues on field
/constant,phaseout/

nonused18(kcr) crops that are not used as residues
/sunflower, oilpalm, foddr, begr, betr/

***Feeding groups***

   kres_kcr(kres,kcr) mapping of crops to different residue types
   /     res_cereals                   .(tece,maiz,trce,rice_pro)
         res_fibrous                   .(soybean,rapeseed,groundnut,
                                         puls_pro,sugr_beet,sugr_cane,
                                         cottn_pro)
         res_nonfibrous                .(potato,cassav_sp,others)
   /



;

*** EOF sets.gms ***
