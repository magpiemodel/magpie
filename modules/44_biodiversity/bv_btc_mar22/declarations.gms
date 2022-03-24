*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

parameters
 pc44_bii_weighted(j)		        Current range rarity weighted bii (Mha)
 p44_price_bv_loss(t)			                biodiversity value loss price factor (USD per ha of bv loss)
 pc44_price_bv_loss			                    biodiversity value loss price factor (USD per ha of bv loss)
;

variables
 v44_bii_weighted_ratio(j)	 		difference of biodiversity value per land class (Mha per time step)
 vm_cost_bv_loss(j)					            biodiversity value loss cost (mio USD)
;

positive variables
 vm_bv(j,landcover44,potnatveg)		            bii coefficent times land area (Mha)
 v44_bii(j) 			    					area-weighted bii (1)
 v44_bii_weighted(j) 			    			area- and range-rarity weighted bii (1)
;

equations
 q44_bii_weighted_loss(j)                                 total biodiversity value loss constraint (Mha)
 q44_bii_weighted(j)			biodiversity value loss constraint per land class (Mha)
 q44_bii(j)		            biodiversity value stock constraint (Mha)
 q44_cost_bv_loss(j)			                biodiversity value loss cost constraint (mio USD)
;


*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov44_bii_weighted_ratio(t,j,type)     difference of biodiversity value per land class (Mha per time step)
 ov_cost_bv_loss(t,j,type)             biodiversity value loss cost (mio USD)
 ov_bv(t,j,landcover44,potnatveg,type) bii coefficent times land area (Mha)
 ov44_bii(t,j,type)                    area-weighted bii (1)
 ov44_bii_weighted(t,j,type)           area- and range-rarity weighted bii (1)
 oq44_bii_weighted_loss(t,j,type)      total biodiversity value loss constraint (Mha)
 oq44_bii_weighted(t,j,type)           biodiversity value loss constraint per land class (Mha)
 oq44_bii(t,j,type)                    biodiversity value stock constraint (Mha)
 oq44_cost_bv_loss(t,j,type)           biodiversity value loss cost constraint (mio USD)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################

