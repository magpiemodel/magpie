*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

vm_carbon_stock.fx(j,"urban",ag_pools,stockType) = 0;

if(ord(t) = 1,
  vm_land.fx(j,"urban") = i34_urban_area(t,j);
else
  vm_land.lo(j,"urban") = 0;
  vm_land.l(j,"urban") = i34_urban_area(t,j);
  vm_land.up(j,"urban") = Inf;
);
