*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations

*' Timber production cost covering cost of harvest as well as the cost incurred by
*' utilizing free variable with a very high cost. Ideally this free variable is only
*' used when there is no other way to meet timber demand. To make sure that timber plantations
*' are harvested at rotation age, the economically optimal point in time, we assume zero
*' costs for production from timber plantations, and higher costs for for production from
*' natural vegetation.

q73_cost_timber(i2)..
                    vm_cost_timber(i2)
                    =e=
                    v73_cost_hvarea(i2)
                    + sum((cell(i2,j2),land_natveg,ac,kforestry), v73_prod_natveg(j2,land_natveg,ac,kforestry) * s73_timber_harvest_cost)
                    + sum((cell(i2,j2),kforestry), v73_prod_heaven_timber(j2,kforestry) * s73_free_prod_cost)
                    ;

*' Harvested cost is defined as the cost incurred while removing biomass from forests.
*' Harvestig natural vegetation is made less attractive to the model by providing higher
*' harvesting costs. This is to mimic the difficulties in accessing primary and secondary
*' forests.

q73_cost_hvarea(i2)..
                    v73_cost_hvarea(i2)
                    =e=
                    sum((ct,cell(i2,j2),ac_sub), vm_hvarea_forestry(j2,ac_sub)   * s73_timber_harvest_cost)
                  + sum((ct,cell(i2,j2),ac_sub), vm_hvarea_secdforest(j2,ac_sub) * s73_timber_harvest_cost * p73_cost_multiplier("secdforest"))
                  + sum((ct,cell(i2,j2),ac_sub), vm_hvarea_other(j2, ac_sub)     * s73_timber_harvest_cost * p73_cost_multiplier("other"))
                  + sum((ct,cell(i2,j2)),        vm_hvarea_primforest(j2)        * s73_timber_harvest_cost * p73_cost_multiplier("primforest"))
                    ;

*' The following equation describes cellular level production (in dry matter) of
*' woody biomass `vm_prod_reg` as the sum of the cluster level production of
*' timber coming from 'v73_prod_forestry' and 'v73_prod_natveg'.

q73_prod_timber(j2,kforestry)..
  vm_prod(j2,kforestry)
  =e=
  sum(ac_sub, v73_prod_forestry(j2,ac_sub,kforestry))
  +
  sum((land_natveg,ac_sub),v73_prod_natveg(j2,land_natveg,ac_sub,kforestry))
  +
  v73_prod_heaven_timber(j2,kforestry);

** Timber plantation
*' Woody biomass production from timber plantations is calculated by multiplying the
*' area under production with corresponding yields of plantation forests, divided by the timestep length.

q73_prod_forestry(j2,ac_sub)..
                         sum(kforestry, v73_prod_forestry(j2,ac_sub,kforestry))
                         =e=
                         vm_hvarea_forestry(j2,ac_sub) * sum(ct, pm_timber_yield(ct,j2,ac_sub,"forestry")) / m_timestep_length_forestry;

** Secondary forest
*' Woody biomass production from secondary forests is calculated by multiplying the
*' area under production with corresponding yields of secondary forests, divided by the timestep length.

q73_prod_secdforest(j2,ac_sub)..
                           sum(kforestry, v73_prod_natveg(j2,"secdforest",ac_sub,kforestry))
                           =e=
						    vm_hvarea_secdforest(j2,ac_sub) * sum(ct,pm_timber_yield(ct,j2,ac_sub,"secdforest")) / m_timestep_length_forestry;

** Primary forest
*' Woody biomass production from primary forests is calculated by multiplying the
*' area under production with corresponding yields of primary forests, divided by the timestep length.

q73_prod_primforest(j2)..
                           sum(kforestry, v73_prod_natveg(j2,"primforest","acx",kforestry))
                           =e=
                           vm_hvarea_primforest(j2) * sum(ct, pm_timber_yield(ct,j2,"acx","primforest")) / m_timestep_length_forestry;

** Other land
*' Wood-fuel production from other land is calculated by multiplying the area under
*' production with corresponding yields of other land, divided by the timestep length.
*' Wood production from other landis not allowed.

q73_prod_other(j2,ac_sub)..
                          v73_prod_natveg(j2,"other",ac_sub,"woodfuel")
                          =e=
                          vm_hvarea_other(j2,ac_sub) * sum(ct, pm_timber_yield(ct,j2,ac_sub,"other")) / m_timestep_length_forestry
                          ;

*** EOF equations.gms ***
