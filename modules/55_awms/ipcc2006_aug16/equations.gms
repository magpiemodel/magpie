*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de


 q55_bal_intake_confinement(i2,kli,npk) ..
         v55_feed_intake(i2, kli, "confinement",npk)
         =e=
         sum(kcr,vm_dem_feed(i2,kli,kcr) * fm_attributes(npk,kcr))
         + sum(kap,vm_dem_feed(i2,kli,kap) * fm_attributes(npk,kap))
         + sum(ksd,vm_dem_feed(i2,kli,ksd) * fm_attributes(npk,ksd))
         + sum(kres,vm_dem_feed(i2,kli,kres) * fm_attributes(npk,kres) * (1-sum(ct,im_development_state(ct,i2))*0.25))
         ;

 q55_bal_intake_grazing_pasture(i2,kli,npk) ..
         v55_feed_intake(i2, kli, "grazing",npk)
         =e=
         (vm_dem_feed(i2,kli,"pasture")) * fm_attributes(npk,"pasture")*(1-ic55_manure_fuel_shr(i2,kli))
         ;

 q55_bal_intake_fuel(i2,kli,npk) ..
         v55_feed_intake(i2, kli, "fuel",npk)
         =e=
         (vm_dem_feed(i2,kli,"pasture")) * fm_attributes(npk,"pasture")*sum(ct,ic55_manure_fuel_shr(i2,kli))
         ;

 q55_bal_intake_grazing_cropland(i2,kli,npk) ..
         v55_feed_intake(i2, kli, "stubble_grazing",npk)
         =e=
         sum(kres,vm_dem_feed(i2,kli,kres) * fm_attributes(npk,kres)  * sum(ct,im_development_state(ct,i2))*0.25)
         ;

 q55_bal_manure(i2,kli,awms,npk) ..
         vm_manure(i2, kli, awms,npk)
         =e=
         v55_feed_intake(i2, kli, awms,npk) * (1-sum(ct,im_slaughter_feed_share(ct,i2,kli,npk)));

  q55_manure_confinement(i2,kli,awms_conf,npk) ..
         vm_manure_confinement(i2,kli,awms_conf, npk) =e=
         vm_manure(i2, kli, "confinement", npk) * ic55_awms_shr(i2,kli,awms_conf)
         ;

 q55_manure_recycling(i2,npk) ..
         vm_manure_recycling(i2,npk) =e=
         sum((awms_conf,kli),
             vm_manure_confinement(i2,kli,awms_conf, npk)
             * i55_manure_recycling_share(i2,kli,awms_conf,npk)
         );
