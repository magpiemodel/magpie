*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

sets

	land33 forest land types 
	  /ifft, modnat/

	scen33 forest protection scenario
	  /low, medium, high/
  
  	scen33_to_dev(scen33,dev)
      /	low		. (lic)
       	medium	. (mic)
       	high	. (hic) /

;

*** EOF sets.gms ***
