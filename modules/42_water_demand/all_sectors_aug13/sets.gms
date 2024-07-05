*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

sets
   watdem_exo(wat_dem) Exogenous water demand
   / domestic, manufacturing, electricity, ecosystem /

   watdem_ineldo(wat_dem) Exogenous water demand subset covering humanly induced demands
   / domestic, manufacturing, electricity /

   scen_watdem_nonagr Scenarios for non agricultural water demand
   / ISIMIP, ssp1, ssp2, ssp3 /

  scen42 Environmental Flow Policy (EFP)
      / off, on /

  scen42_to_dev(scen42,dev) Mapping between EFP and economic development status
      / off   . (lic, mic)
        on    . (hic) /

  wtype Water abstraction type 
     / consumption, withdrawal /
;
