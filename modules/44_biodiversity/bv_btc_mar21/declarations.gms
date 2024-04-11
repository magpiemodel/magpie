*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

parameters
 p44_price_bv_loss(t_all)                 Price (subsidy) for biodiversity stock loss (gain) (USD per ha)
;

variables
 v44_bv_loss(j)                                 Change in biodiversity stock (Mha per year)
 vm_cost_bv_loss(j)                     Biodiversity cost (mio USD)
;

positive variables
 vm_bv(j,landcover44,potnatveg)               Biodiversity stock for all land cover classes (Mha)
 v44_bv_weighted(j)                 Range-rarity weighted biodiversity stock (Mha)
;

equations
 q44_bv_loss(j)                                 Change in biodiversity stock (Mha per year)
 q44_bv_weighted(j)                     Range-rarity weighted biodiversity stock (Mha)
 q44_cost_bv_loss(j)                      Cost of biodiversity loss (mio USD)
;


*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov44_bv_loss(t,j,type)                Change in biodiversity stock (Mha per year)
 ov_cost_bv_loss(t,j,type)             Biodiversity cost (mio USD)
 ov_bv(t,j,landcover44,potnatveg,type) Biodiversity stock for all land cover classes (Mha)
 ov44_bv_weighted(t,j,type)            Range-rarity weighted biodiversity stock (Mha)
 oq44_bv_loss(t,j,type)                Change in biodiversity stock (Mha per year)
 oq44_bv_weighted(t,j,type)            Range-rarity weighted biodiversity stock (Mha)
 oq44_cost_bv_loss(t,j,type)           Cost of biodiversity loss (mio USD)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################

