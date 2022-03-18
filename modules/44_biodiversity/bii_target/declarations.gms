*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


parameters
 pc44_bv_weighted(j,landcover44)		        Current range rarity weighted bii (Mha)
 p44_price_bv_loss(t)			                biodiversity value loss price factor (USD per ha of bv loss)
 pc44_price_bv_loss			                    biodiversity value loss price factor (USD per ha of bv loss)
;

positive variables
 v44_bv_glo                                 	blub
 v44_bv_slack								blub
 vm_cost_bv_loss(j)					            biodiversity value loss cost (mio USD)
 vm_bv(j,landcover44,potnatveg)		            biodiversity value for all land cover classes (unweighted) (Mha)
 v44_bv_weighted(j,landcover44) 			    range rarity weighted biodiversity value (Mha)
;

equations
 q44_bv_weighted(j,landcover44)                                 total biodiversity value loss constraint (Mha)
 q44_bv_glo		            					blub
 q44_bv_glo2
 q44_cost_bv_loss			                biodiversity value loss cost constraint (mio USD)
;


*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov44_bv_glo(t,type)                    blub
 ov44_bv_slack(t,type)                  blub
 ov_cost_bv_loss(t,j,type)              biodiversity value loss cost (mio USD)
 ov_bv(t,j,landcover44,potnatveg,type)  biodiversity value for all land cover classes (unweighted) (Mha)
 ov44_bv_weighted(t,j,landcover44,type) range rarity weighted biodiversity value (Mha)
 oq44_bv_weighted(t,j,landcover44,type) total biodiversity value loss constraint (Mha)
 oq44_bv_glo(t,type)                    blub
 oq44_bv_glo2(t,type)                   
 oq44_cost_bv_loss(t,type)              biodiversity value loss cost constraint (mio USD)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################

