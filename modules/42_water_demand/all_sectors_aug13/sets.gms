*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

sets
   watdem_exo(wat_dem) Exogenous water demand
   / industry, electricity, domestic, ecosystem /

   watdem_ineldo(wat_dem) Exogenous water demand subset covering humanly induced demands
   / industry, electricity, domestic /

   scen_watdem_nonagr Scenarios for non agricultural water demand
   / A2 , B1 , SSP2 /

	scen42 Environmental Flow Policy (EFP)
  		/ off, on /

	scen42_to_dev(scen42,dev) Mapping between EFP and economic development status
      /	off		. (lic, mic)
       	on		. (hic) /

;
