*** (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

parameters
 pc44_bv_weighted(j,bii_class44)		        current range rarity weighted bii (Mha)
 p44_price_bv_loss(t)			                biodiversity value loss price factor (US$ per ha of bv loss)
 pc44_price_bv_loss			                    biodiversity value loss price factor (US$ per ha of bv loss)
;

variables
 v44_bv_loss(j,bii_class44)	 		            biodiversity value loss (Mha per time step)
 vm_cost_bv_loss(j)					            biodiversity value loss cost (mio US$)
;

positive variables
 vm_bv(j,landcover44,potnatveg)		            biodiversity value for all land cover classes (unweighted) (Mha)
 v44_bv_weighted(j,bii_class44) 			    range rarity weighted biodiversity value (Mha)
;

equations
 q44_bv_loss(j,bii_class44)			            biodiversity value loss constraint
 q44_bv_weighted(j,bii_class44)		            biodiversity value stock constraint
 q44_cost_bv_loss(j)			                biodiversity value loss cost constraint
;


*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov44_bv_loss(t,j,bii_class44,type)     biodiversity value loss (Mha per time step)
 ov_cost_bv_loss(t,j,type)              biodiversity value loss cost (mio US$)
 ov_bv(t,j,landcover44,potnatveg,type)  biodiversity value for all land cover classes (unweighted) (Mha)
 ov44_bv_weighted(t,j,bii_class44,type) range rarity weighted biodiversity value (Mha)
 oq44_bv_loss(t,j,bii_class44,type)     biodiversity value loss constraint
 oq44_bv_weighted(t,j,bii_class44,type) biodiversity value stock constraint
 oq44_cost_bv_loss(t,j,type)            biodiversity value loss cost constraint
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################

