*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

sets
   watdem_ineldo(wat_dem) water demands for subset / industry, electricity, domestic /
   watdem_exo(wat_dem) exogenous water demands / industry, electricity, domestic, ecosystem /
   scen_watdem_nonagr	available scenarios for non agricultural water demand / A2 , B1 , SSP2 /

	scen42 EFP policy
  		/ off, on /

	scen42_to_dev(scen42,dev)
      /	off		. (lic, mic)
       	on		. (hic) /

;
