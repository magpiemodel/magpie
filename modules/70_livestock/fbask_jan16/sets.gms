*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

sets
   cost_regr Cost regression parameters
    /cost_regr_a,cost_regr_b/

   feed_scen70  scenarios
       / ssp1,ssp2,ssp3,ssp4,ssp5,constant /

   sys Livestock production systems
     /sys_pig, sys_beef, sys_chicken, sys_hen, sys_dairy/

   sys_meat(sys) Livestock meat production systems
     /sys_pig, sys_beef, sys_chicken/

   sys_nonmeat(sys) Livestock non-meat production systems
     /sys_hen, sys_dairy/


  sys_to_kli(sys,kli) Mapping between livestock producton systems and livestock products
  /sys_pig    . livst_pig
   sys_beef    . livst_rum
   sys_chicken  . livst_chick
   sys_hen . livst_egg
   sys_dairy .livst_milk
   /

;
