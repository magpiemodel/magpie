*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations

*' Timber production cost covering cost of harvest as well as the cost incurred by
*' utilizing free variable with a very high cost. Ideally this free variable is only
*' used when there is no other way to meet timber demand.

q73_cost_timber(i2)..
                    vm_cost_timber(i2)
                    =e=
                    v73_cost_hvarea(i2)
                    + sum((cell(i2,j2),kforestry), v73_prod_heaven_timber(j2,kforestry)) * 1000000
                    ;


*' Harvested cost is defined as the const incurred while removing biomass from forests.
*' Harvestig natural vegetation is made less attractive to the model by providing higher
*' harvesting costs. This is to mimic the difficulties in accessing primary and secondary
*' forests.

q73_cost_hvarea(i2)..
                    v73_cost_hvarea(i2)
                    =e=
                    sum(cell(i2,j2),
                    sum(ac_sub, vm_hvarea_forestry(j2,ac_sub)) * s73_timber_harvest_cost
                  + (sum(ac_sub, vm_hvarea_secdforest(j2,ac_sub))
                  + sum(ac_sub, v73_hvarea_other(j2, ac_sub))
                  + vm_hvarea_primforest(j2)) * (s73_timber_harvest_cost * s73_cost_multiplier))
                    ;

*' The following equation describes cellular level production of woody biomass
*' `vm_prod_reg` as the sum of the cluster level production of timber coming from
*' 'v73_prod_forestry' and 'v73_prod_natveg'.

*prod in ton
q73_prod_timber(j2,kforestry)..
  vm_prod(j2,kforestry)
  =e=
  sum(ac_sub, v73_prod_forestry(j2,ac_sub,kforestry))
  +
  sum((land_natveg,ac_sub),v73_prod_natveg(j2,land_natveg,ac_sub,kforestry))
  +
  v73_prod_heaven_timber(j2,kforestry);
  ;


*** Forestry production *** in ton

** Plantations
*' Woody biomass production from plantations is calculated by multiplying the
*' area under production with corresponding yields of plantation forests.
*' Production of wood and woodfuel are differentiated because of different yields.

q73_prod_forestry(j2,ac_sub)..
                         sum(kforestry, v73_prod_forestry(j2,ac_sub,kforestry))
                         =l=
                         sum(type32, vm_forestry_reduction(j2,type32,ac_sub)) * sum(ct, pm_timber_yield(ct,j2,ac_sub,"forestry"));

q73_hvarea_forestry(j2,ac_sub) ..
                          vm_hvarea_forestry(j2,ac_sub)
                          =e=
                          sum(kforestry, v73_prod_forestry(j2,ac_sub,kforestry)) / sum(ct, pm_timber_yield(ct,j2,ac_sub,"forestry"));

*** Natveg production ***

** Secondary forest
*' Woody biomass production from secondary forests is calculated by multiplying the
*' area under production with corresponding yields of secondary forests.
*' Production of wood and woodfuel are differentiated because of different yields.

q73_prod_secdforest(j2,ac_sub)..
                           sum(kforestry, v73_prod_natveg(j2,"secdforest",ac_sub,kforestry))
                           =l=
						    vm_secdforest_reduction(j2,ac_sub) * sum(ct,pm_timber_yield(ct,j2,ac_sub,"secdforest"));

*' Real harvested area for secondary forests is calculated based on the production
*' realized from secondary forests divided by the corresponding growing stocks.

q73_hvarea_secdforest(j2,ac_sub)..
                          vm_hvarea_secdforest(j2,ac_sub)
                           =e=
                          sum(kforestry, v73_prod_natveg(j2,"secdforest",ac_sub,kforestry)) / sum(ct, pm_timber_yield(ct,j2,ac_sub,"secdforest"));

** Primary forest
*' Woody biomass production from primary forests is calculated by multiplying the
*' area under production with corresponding yields of primary forests.
*' Production of wood and woodfuel are differentiated because of different yields.

q73_prod_primforest(j2)..
                           sum(kforestry, v73_prod_natveg(j2,"primforest","acx",kforestry))
                           =l=
                           vm_primforest_reduction(j2) * sum(ct, pm_timber_yield(ct,j2,"acx","primforest"));

*' Real harvested area for primary forests is calculated based on the production
*' realized from primary forests divided by the corresponding growing stocks.

q73_hvarea_primforest(j2)..
                          vm_hvarea_primforest(j2)
                           =e=
                          sum(kforestry, v73_prod_natveg(j2,"primforest","acx",kforestry)) / sum(ct, pm_timber_yield(ct,j2,"acx","primforest"));

** Other land
*' Wood-fuel production from other land is calculated by multiplying the area under
*' production with corresponding yields of other land. Wood production from other land
*' is not allowed.


q73_prod_other(j2,ac_sub)..
                          v73_prod_natveg(j2,"other",ac_sub,"woodfuel")
                          =l=
                          vm_other_reduction(j2,ac_sub) * sum(ct, pm_timber_yield(ct,j2,ac_sub,"other"))
                          ;

*' Real harvested area from other land is calculated based on the wood-fuel production
*' realized from such areas divided by the corresponding growing stocks.

q73_hvarea_other(j2,ac_sub)..
                         v73_hvarea_other(j2, ac_sub)
                          =e=
                         v73_prod_natveg(j2,"other",ac_sub,"woodfuel") / sum(ct, pm_timber_yield(ct,j2,ac_sub,"other"));

*** EOF equations.gms ***
