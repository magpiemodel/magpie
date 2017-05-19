*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de


sets

dm_nr(attributes) dry matter and nr
/dm, nr/

pk18(npk)
/p, k/

dev18
/high_income,low_income/

***Feeding groups***

   kres_kcr(kres,kcr)
   /     res_cereals                   .(tece,maiz,trce,rice_pro)
         res_fibrous                   .(soybean,rapeseed,groundnut,
                                         puls_pro,sugr_beet,sugr_cane,
                                         cottn_pro)
         res_nonfibrous                .(potato,cassav_sp,others)
   /



;

*** EOF sets.gms ***