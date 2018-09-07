*** (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

pc71_area_share(j,"pasture") =
       pcm_land(j,"past")/(sum(cell(i,j),sum(cell2(i,j3),pcm_land(j3,"past")))+10**(-6)) 
	   ;
	   
pc71_area_share(j,"foddr") =
       pcm_area(j,"foddr")/(sum(cell(i,j),sum(cell2(i,j3),pcm_area(j,"foddr")))+10**(-6)) 
	   ;