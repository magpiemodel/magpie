*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations

q73_prod_timber(j2,kforestry)..
  vm_prod(j2,kforestry)
  =e=
  v73_prod_forestry(j2,kforestry)
  +
  sum((land_natveg,ac_sub),v73_prod_natveg(j2,land_natveg,ac_sub,kforestry))
  ;

*** Forestry production
q73_prod_forestry(j2,kforestry)..
                          v73_prod_forestry(j2,kforestry)
                          =e=
                         sum((ac_sub,ct), vm_hvarea_forestry(j2,kforestry,ac_sub) * pm_growing_stock(ct,j2,ac_sub,kforestry,"forestry"))
                         ;


**** Natveg production

** Secondary forest
q73_prod_secdforest(j2,ac_sub,kforestry)..
                          v73_prod_natveg(j2,"secdforest",ac_sub,kforestry)
                           =l=
						              vm_secdforest_change(j2,kforestry,ac_sub) * sum(ct,pm_growing_stock(ct,j2,ac_sub,kforestry,"secdforest"));

q73_hvarea_secdforest(j2,ac_sub,kforestry)..
                          vm_hvarea_secdforest(j2, ac_sub,kforestry)
                           =e=
                          v73_prod_natveg(j2,"secdforest",ac_sub,kforestry) / sum(ct, pm_growing_stock(ct,j2,ac_sub,kforestry,"secdforest"));

** Primary forest
q73_prod_primforest(j2,kforestry)..
                           v73_prod_natveg(j2,"primforest","acx",kforestry)
                           =l=
                           vm_primforest_change(j2,kforestry) * sum(ct, pm_growing_stock(ct,j2,"acx",kforestry,"primforest"));

q73_hvarea_primforest(j2,kforestry)..
                          vm_hvarea_primforest(j2,kforestry)
                           =e=
                          v73_prod_natveg(j2,"primforest","acx",kforestry) / sum(ct, pm_growing_stock(ct,j2,"acx",kforestry,"primforest"));

** Other land
q73_hvarea_other(j2,ac_sub)..
                         vm_hvarea_other(j2, ac_sub,"woodfuel")
                          =e=
                         v73_prod_natveg(j2,"other",ac_sub,"woodfuel") / sum(ct, pm_growing_stock(ct,j2,ac_sub,"woodfuel","other"));

q73_prod_other(j2,ac_sub)..
                          v73_prod_natveg(j2,"other",ac_sub,"woodfuel")
                          =l=
                          vm_other_change(j2,"woodfuel",ac_sub) * sum(ct, pm_growing_stock(ct,j2,ac_sub,"woodfuel","other"))
                          ;
***************************************************************************************************
*** EOF equations.gms ***
