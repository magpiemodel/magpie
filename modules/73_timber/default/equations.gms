*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations

*' Timber production cost include the cost for producing wood, woodfuel and residues,
*' and technical costs for a slack variable ('v73_prod_heaven_timber').
*' The slack variable (high costs) 
*' is only used as a last resort when there is no other way to meet the timber
*' demand. The purpose of the slack variable is to assure technically feasibility
*' of the model under all conditions and to indicate shortage of wood supply, if any.

q73_cost_timber(i2)..
                    vm_cost_timber(i2)
                    =e=
                      sum((cell(i2,j2),kforestry), vm_prod(j2,kforestry) * im_timber_prod_cost(kforestry))
                    + sum(cell(i2,j2), v73_prod_residues(j2)) * s73_reisdue_removal_cost
                    + sum((cell(i2,j2),kforestry), v73_prod_heaven_timber(j2,kforestry) * s73_free_prod_cost)
                    ;

*' The following equations describes cellular level production (in dry matter) of
*' woody biomass `vm_prod` as the sum of the cluster level production of
*' timber coming from 'vm_prod_forestry' and 'vm_prod_natveg'. When production
*' capabilities are exhausted, the model can produce roundwood without using any
*' land resources but by paying a very high cost ('s73_free_prod_cost').
*' Timber production equation is split in two parts, one each for industrial roundwood
*' and wood fuel production. Woodfuel production, in addition to usual production
*' channels, can also use residues left from industrial roundwood harvest for meeting
*' overall wood fuel production targets.

q73_prod_wood(j2)..
  vm_prod(j2,"wood")
  =e=
  vm_prod_forestry(j2,"wood")
  +
  sum((land_natveg),vm_prod_natveg(j2,land_natveg,"wood"))
  +
  v73_prod_heaven_timber(j2,"wood");

q73_prod_woodfuel(j2)..
  vm_prod(j2,"woodfuel")
  =e=
  vm_prod_forestry(j2,"woodfuel")
  +
  sum((land_natveg),vm_prod_natveg(j2,land_natveg,"woodfuel"))
  +
  v73_prod_residues(j2)
  +
  v73_prod_heaven_timber(j2,"woodfuel");

*' Production of residues is calculated based on `s73_residue_ratio`. This fraction
*' of industrial roundwood production is assumed to be lost during harvesting processes.
*' USDA reports that ca. 30% of roundwood harvested are residues (@oswalt2019forest).
*' Not all of this residue is recovered from forest and we assume 50% of residue
*' removal based on @pokharel2017factors. These numbers (residue levels and residude
*' removals vary strongly among different studies, the numbers used here are from
*' a USDA report on state of forests in USA which has consistent reporting over years)

q73_prod_residues(j2)..
  v73_prod_residues(j2)
  =l=
  vm_prod(j2,"wood") * s73_residue_ratio
  ;

*** EOF equations.gms ***
