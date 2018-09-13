*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
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
