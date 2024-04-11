*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

i71_urban_area_share(j) =
       pm_land_start(j,"urban")/sum(cell(i,j),sum(cell2(i,j3),pm_land_start(j3,"urban")))
     ;

s71_scale_mon = 1.10;
s71_punish_additional_mon = 15000;

* Minimal regional production of `kli_rum` to avoid division by zero in `q71_feed_balanceflow`.
vm_prod_reg.lo(i,kli_rum) = 10**(-6);

