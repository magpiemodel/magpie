*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

sets
 
  land58 Peatland categories
    / intact, crop, past, forestry, peatExtract, unused, rewetted /

  drained58(land58) Drained peatland categories
    / crop, past, forestry, unused /

  manPeat58(land58) Drained and managed peatland categories
    / crop, past, forestry /

  cost58 annunity cost categories
    / drain_intact, drain_rewetted, rewet /

  emis58 Wetland emission types
  / co2, doc, ch4, n2o /

  emisSub58(emis58) Wetland emission types
  / co2, ch4, n2o /

  poll58(pollutants) Wetland emissions that can be taxed
  / co2_c, ch4, n2o_n_direct /
  
  emisSub58_to_poll58(emisSub58,poll58) Mapping
      / co2 .(co2_c)    
        ch4 .(ch4)      
        n2o .(n2o_n_direct) /
  
  clcl58 simple climate classes
  / tropical, temperate, boreal /
           
  clcl_mapping(clcl,clcl58) Mapping between detailed and simple climate classes
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
           Cfc .(boreal) "Subpolar oceanic climate"
           Csa .(temperate) "Hot-summer Mediterranean climate"
           Csb .(temperate) "Warm-summer Mediterranean climate"
           Csc .(temperate) "Cool-summer Mediterranean climate"
           Cwa .(tropical) "Monsoon-influenced humid subtropical climate"
           Cwb .(tropical) "Dry-winter subtropical highland climate"
           Cwc .(boreal) "Dry-winter subpolar oceanic climate"
           Dfa .(temperate) "Hot-summer humid continental climate"
           Dfb .(boreal) "Warm-summer humid continental climate"
           Dfc .(boreal) "Subarctic climate"
           Dfd .(boreal) "Extremely cold subarctic climate"
           Dsa .(temperate) "Hot, dry-summer continental climate"
           Dsb .(boreal) "Warm, dry-summer continental climate"
           Dsc .(boreal) "Dry-summer subarctic climate"
           Dsd .(boreal) "snow summer dry extremely continental"
           Dwa .(temperate) "Monsoon-influenced hot-summer humid continental climate"
           Dwb .(boreal) "Monsoon-influenced warm-summer humid continental climate"
           Dwc .(boreal) "Monsoon-influenced subarctic climate"
           Dwd .(boreal) "Monsoon-influenced extremely cold subarctic climate"
           EF .(boreal) "Ice cap climate"
           ET .(boreal) "Tundra"
           /

;

alias (manPeat58,manPeat58_alias);
