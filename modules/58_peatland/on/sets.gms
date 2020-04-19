*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

sets
 
  man58 Peatland status managed
    / degrad, unused, rewet /
  
  ef58(man58) Peatland ef categories
    / degrad, rewet /

  land_all58(land) Managed land types
    / crop, past, forestry /

  land58(land_all58) Managed land types
    / crop, past /

  stat58 Peatland status
    / intact, 
    degrad_crop, degrad_past, degrad_forestry, 
    unused_crop, unused_past, unused_forestry, 
    rewet_crop, rewet_past, rewet_forestry /

  from58(stat58) Peatland status
    / intact, 
    degrad_crop, degrad_past, degrad_forestry, 
    unused_crop, unused_past, unused_forestry, 
    rewet_crop, rewet_past, rewet_forestry /

  stat_degrad_from58(from58) Peatland status
    / degrad_crop, degrad_past, degrad_forestry /

  to58(stat58) Peatland status
    / intact, 
    degrad_crop, degrad_past, degrad_forestry, 
    unused_crop, unused_past, unused_forestry, 
    rewet_crop, rewet_past, rewet_forestry /

  stat_rewet58(to58) Peatland status
    / rewet_crop, rewet_past, rewet_forestry /

  stat_degrad58(to58) Peatland status
    / degrad_crop, degrad_past, degrad_forestry /

  emis58 Wetland emission types
	/ co2, doc, ch4, n2o /

;
