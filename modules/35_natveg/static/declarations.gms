*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
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
