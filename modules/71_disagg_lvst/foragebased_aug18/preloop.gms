*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

i71_urban_area_share(j) =
       pm_land_start(j,"urban")/sum(cell(i,j),sum(cell2(i,j3),pm_land_start(j3,"urban"))) 
	   ;

s71_lp_fix = 0;