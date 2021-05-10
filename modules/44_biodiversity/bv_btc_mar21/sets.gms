*** (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

sets

	landcover44 land cover classes used in bii calculation
		/ crop_ann, crop_per, manpast, rangeland, urban, aff_ndc, aff_co2p, primforest, secdforest, other, plant /

	bii_class44 bii coefficent land cover classes
		/ crop_ann, crop_per, manpast, rangeland, urban, primary, secd_mature, secd_young, timber /

	bii_secd(bii_class44) bii coefficent land cover classes secondary vegetation
		/ secd_mature, secd_young /

	ac_to_bii_secd(ac,bii_secd) Mapping between forest ageclasses and bii coefficent land cover classes 
	/ (ac0,ac5,ac10,ac15,ac20,ac25,ac30)    . (secd_young)
	  (ac35,ac40,ac45,ac50,ac55,ac60,
  	   ac65,ac70,ac75,ac80,ac85,ac90,
	   ac95,ac100,ac105,ac110,ac115,
	   ac120,ac125,ac130,ac135,ac140,
	   ac145,ac150,ac155,acx)   			. (secd_mature) /
  
	price_biodiv44	price paths biodiv loss
		/ p0,p1,p1_p10,p10,p10_p100,p1_p1000,p10_p10000 /

;
