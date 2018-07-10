*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

i71_share_in_feedmix_reg(t_all,i,kli,kall,dm_ge_nr) =
			 	 im_feed_baskets(t_all,i,kli,kall)*fm_attributes(dm_ge_nr,kall)/ 
	    sum(kall2,im_feed_baskets(t_all,i,kli,kall2)*fm_attributes(dm_ge_nr,kall2))
	   ;
	
i71_share_in_feedmix(t_all,j,kli,kall,dm_ge_nr) =	   
	   sum(cell(i,j),i71_share_in_feedmix_reg(t_all,i,kli,kall,dm_ge_nr))
	   ;
	
i71_urban_area_share(j) =
       pm_land_start(j,"urban")/sum(cell(i,j),sum(cell2(i,j3),pm_land_start(j3,"urban"))) 
	   ;