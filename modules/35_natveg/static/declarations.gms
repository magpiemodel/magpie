*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

positive variables
  v35_secdforest(j,land35) Secdforest (mio. ha)
  v35_other(j,land35)      Other land (mio. ha)
  vm_landdiff_natveg       Aggregated difference in other land compared to previous timestep (mio. ha)
  vm_cost_natveg(i)                           Regional natveg timber production costs (mio. USD)
  vm_prod_cell_natveg(j,kforestry)           xx
;


*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov35_secdforest(t,j,land35,type)        Secdforest (mio. ha)
 ov35_other(t,j,land35,type)             Other land (mio. ha)
 ov_landdiff_natveg(t,type)              Aggregated difference in other land compared to previous timestep (mio. ha)
 ov_cost_natveg(t,i,type)                Regional natveg timber production costs (mio. USD)
 ov_prod_cell_natveg(t,j,kforestry,type) xx
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
