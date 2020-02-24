*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations

*' Following is a dummy calculation for timber demand based on regression output.
*' Fo now the variable is not used in optimization but only used for testing prposes.

q73_timber_demand(i2,kforestry)..
  v73_timber_demand(i2,kforestry)
  =e=
  sum(ct,p73_wood_products_demand_reg(ct,i2,kforestry));

*' The following equation describes cellular level production of woody biomass
*' `vm_prod_reg` as the sum of the cluster level production of timber coming from
*' 'v73_prod_forestry' and 'v73_prod_natveg'.

q73_prod_timber(j2,kforestry)..
  vm_prod(j2,kforestry)
  =e=
  v73_prod_forestry(j2,kforestry)
  +
  sum((land_natveg,ac_sub),v73_prod_natveg(j2,land_natveg,ac_sub,kforestry))
  +
  vm_prod_heaven_timber(j2,kforestry);
  ;


*** Forestry production ***

** Plantations
*' Woody biomass production from plantations is calculated by multiplying the
*' area under production with corresponding yields of plantation forests.
*' Production of wood and woodfuel are differentiated because of different yields.

q73_prod_forestry(j2,kforestry)..
                          v73_prod_forestry(j2,kforestry)
                          =e=
                         sum((ac_sub,ct), vm_hvarea_forestry(j2,kforestry,ac_sub) * pm_growing_stock(ct,j2,ac_sub,kforestry,"forestry"))
                         ;


*** Natveg production ***

** Secondary forest
*' Woody biomass production from secondary forests is calculated by multiplying the
*' area under production with corresponding yields of secondary forests.
*' Production of wood and woodfuel are differentiated because of different yields.

q73_prod_secdforest(j2,ac_sub,kforestry)..
                          v73_prod_natveg(j2,"secdforest",ac_sub,kforestry)
                           =l=
						              vm_secdforest_change(j2,kforestry,ac_sub) * sum(ct,pm_growing_stock(ct,j2,ac_sub,kforestry,"secdforest"));

*' Real harvested area for secondary forests is calculated based on the production
*' realized from secondary forests divided by the corresponding growing stocks.

q73_hvarea_secdforest(j2,ac_sub,kforestry)..
                          vm_hvarea_secdforest(j2, ac_sub,kforestry)
                           =e=
                          v73_prod_natveg(j2,"secdforest",ac_sub,kforestry) / sum(ct, pm_growing_stock(ct,j2,ac_sub,kforestry,"secdforest"));

** Primary forest
*' Woody biomass production from primary forests is calculated by multiplying the
*' area under production with corresponding yields of primary forests.
*' Production of wood and woodfuel are differentiated because of different yields.

q73_prod_primforest(j2,kforestry)..
                           v73_prod_natveg(j2,"primforest","acx",kforestry)
                           =l=
                           vm_primforest_change(j2,kforestry) * sum(ct, pm_growing_stock(ct,j2,"acx",kforestry,"primforest"));

*' Real harvested area for primary forests is calculated based on the production
*' realized from primary forests divided by the corresponding growing stocks.

q73_hvarea_primforest(j2,kforestry)..
                          vm_hvarea_primforest(j2,kforestry)
                           =e=
                          v73_prod_natveg(j2,"primforest","acx",kforestry) / sum(ct, pm_growing_stock(ct,j2,"acx",kforestry,"primforest"));

** Other land
*' Wood-fuel production from other land is calculated by multiplying the area under
*' production with corresponding yields of other land. Wood production from other land
*' is not allowed.

q73_hvarea_other(j2,ac_sub)..
                         vm_hvarea_other(j2, ac_sub,"woodfuel")
                          =e=
                         v73_prod_natveg(j2,"other",ac_sub,"woodfuel") / sum(ct, pm_growing_stock(ct,j2,ac_sub,"woodfuel","other"));

*' Real harvested area from other land is calculated based on the wood-fuel production
*' realized from such areas divided by the corresponding growing stocks.

q73_prod_other(j2,ac_sub)..
                          v73_prod_natveg(j2,"other",ac_sub,"woodfuel")
                          =l=
                          vm_other_change(j2,"woodfuel",ac_sub) * sum(ct, pm_growing_stock(ct,j2,ac_sub,"woodfuel","other"))
                          ;

*** EOF equations.gms ***
