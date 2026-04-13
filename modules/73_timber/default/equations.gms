*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations

*' Timber production cost has four components:
*' 1. Base production cost: all timber (plantation + natveg) pays `im_timber_prod_cost(i)`
*'    per tDM, regionalized via wood density (source: 89/44 USD17MER/m3 for wood/woodfuel).
*' 2. Natveg cost premium: natveg timber pays an additional `s73_natveg_cost_premium` (15%)
*'    on top of the base cost. This reflects higher processing costs for heterogeneous
*'    natural forest timber. When premium is zero, the term vanishes.
*' 3. Residue removal cost: `s73_residue_removal_cost` (2.7 USD17MER/tDM) for
*'    collecting logging residues (branches, tops) from the harvest site.
*' 4. Slack variable cost: `s73_free_prod_cost` (1e6 USD17MER/tDM) — prohibitively
*'    high cost for the slack variable `v73_prod_heaven_timber`, used only as a last
*'    resort to ensure technical feasibility when timber demand cannot be met from
*'    available forest resources.

q73_cost_timber(i2)..
                    vm_cost_timber(i2)
                    =e=
                      sum((cell(i2,j2),kforestry), vm_prod(j2,kforestry) * im_timber_prod_cost(i2,kforestry))
                    + sum((cell(i2,j2),land_natveg,kforestry), vm_prod_natveg(j2,land_natveg,kforestry)
                        * (i73_timber_prod_cost_natveg(i2,kforestry) - im_timber_prod_cost(i2,kforestry)))
                    + sum(cell(i2,j2), v73_prod_residues(j2)) * s73_residue_removal_cost
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
*' of total timber harvest is assumed to be recoverable as harvest residues
*' (branches, tops, bark). The theoretical potential of logging residues is 27%
*' of stem harvest [@oswalt2019forest]. The average technical recovery rate is
*' 52% [@thiffault2015recovery], giving 0.27 * 0.52 = 0.14 ~ 0.15.
*' Independently, [@difulvio2016logging] report technically recoverable logging
*' residues at 13.5% of roundwood volume for the EU28.
*' Residues are generated from all real harvest sources (forestry plantations and
*' natural vegetation) for both products. The slack variable `v73_prod_heaven_timber`
*' is excluded (no real harvest = no residues). `v73_prod_residues` itself is also
*' excluded to avoid circularity.

q73_prod_residues(j2)..
  v73_prod_residues(j2)
  =l=
  (sum(kforestry, vm_prod_forestry(j2,kforestry))
  + sum((land_natveg,kforestry), vm_prod_natveg(j2,land_natveg,kforestry)))
  * s73_residue_ratio
  ;

*** EOF equations.gms ***
