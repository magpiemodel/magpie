*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

sets
 
  man58 Peatland status managed
    / degrad, rewet /
  
  ef58(man58) Peatland ef categories
    / degrad, rewet /

  land58(land) Managed land types
    / crop, past, forestry /

  stat58 Peatland status
    / intact, 
    degrad_crop, degrad_past, degrad_forestry, 
    rewet_crop, rewet_past, rewet_forestry /

  from58(stat58) Peatland status
    / intact, 
    degrad_crop, degrad_past, degrad_forestry, 
    rewet_crop, rewet_past, rewet_forestry /

  stat_degrad_from58(from58) Peatland status
    / degrad_crop, degrad_past, degrad_forestry /

  to58(stat58) Peatland status
    / intact, 
    degrad_crop, degrad_past, degrad_forestry, 
    rewet_crop, rewet_past, rewet_forestry /

  stat_rewet58(to58) Peatland status
    / rewet_crop, rewet_past, rewet_forestry /

  stat_degrad58(to58) Peatland status
    / degrad_crop, degrad_past, degrad_forestry /

  climate58 Climate classes
	/ tropical, temperate, boreal /

  emis58 Wetland emission types
	/ co2, doc, ch4, n2o /

  clcl_climate58(clcl,climate58) Climate classification types
           /
           Af .(tropical) "Tropical rainforest climate"
           Am .(tropical) "Tropical monsoon climate"
           As .(tropical) "Tropical dry savanna climate"
           Aw .(tropical) "Tropical savanna, wet"
           BSh .(tropical) "Hot semi-arid (steppe) climate"
           BSk .(tropical) "Cold semi-arid (steppe) climate"
           BWh .(tropical) "Hot deserts climate"
           BWk .(tropical) "Cold desert climate"
           Cfa .(tropical) "Humid subtropical climate"
           Cfb .(temperate) "Temperate oceanic climate"
           Cfc .(temperate) "Subpolar oceanic climate"
           Csa .(temperate) "Hot-summer Mediterranean climate"
           Csb .(temperate) "Warm-summer Mediterranean climate"
           Csc .(temperate) "Cool-summer Mediterranean climate"
           Cwa .(tropical) "Monsoon-influenced humid subtropical climate"
           Cwb .(tropical) "Subtropical highland climate or temperate oceanic climate with dry winters"
           Cwc .(temperate) "Cold subtropical highland climate or subpolar oceanic climate with dry winters"
           Dfa .(boreal) "Hot-summer humid continental climate"
           Dfb .(boreal) "Warm-summer humid continental climate"
           Dfc .(boreal) "Subarctic climate"
           Dfd .(boreal) "Extremely cold subarctic climate"
           Dsa .(boreal) "Hot, dry-summer continental climate"
           Dsb .(boreal) "Warm, dry-summer continental climate"
           Dsc .(boreal) "Dry-summer subarctic climate"
           Dsd .(boreal) "snow summer dry extremely continental"
           Dwa .(boreal) "Monsoon-influenced hot-summer humid continental climate"
           Dwb .(boreal) "Monsoon-influenced warm-summer humid continental climate"
           Dwc .(boreal) "Monsoon-influenced subarctic climate"
           Dwd .(boreal) "Monsoon-influenced extremely cold subarctic climate"
           EF .(boreal) "Ice cap climate"
           ET .(boreal) "Tundra"
           /

;
