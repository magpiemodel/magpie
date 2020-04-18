*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @code

sets
   clcl climate classification types
           /
           Af "Tropical rainforest climate"
           Am "Tropical monsoon climate"
           As "Tropical dry savanna climate"
           Aw "Tropical savanna, wet"
           BSh "Hot semi-arid (steppe) climate"
           BSk "Cold semi-arid (steppe) climate"
           BWh "Hot deserts climate"
           BWk "Cold desert climate"
           Cfa "Humid subtropical climate"
           Cfb "Temperate oceanic climate"
           Cfc "Subpolar oceanic climate"
           Csa "Hot-summer Mediterranean climate"
           Csb "Warm-summer Mediterranean climate"
           Csc "Cool-summer Mediterranean climate"
           Cwa "Monsoon-influenced humid subtropical climate"
           Cwb "Dry-winter subtropical highland climate"
           Cwc "Dry-winter subpolar oceanic climate"
           Dfa "Hot-summer humid continental climate"
           Dfb "Warm-summer humid continental climate"
           Dfc "Subarctic climate"
           Dfd "Extremely cold subarctic climate"
           Dsa "Hot, dry-summer continental climate"
           Dsb "Warm, dry-summer continental climate"
           Dsc "Dry-summer subarctic climate"
           Dsd "snow summer dry extremely continental"
           Dwa "Monsoon-influenced hot-summer humid continental climate"
           Dwb "Monsoon-influenced warm-summer humid continental climate"
           Dwc "Monsoon-influenced subarctic climate"
           Dwd "Monsoon-influenced extremely cold subarctic climate"
           EF "Ice cap climate"
           ET "Tundra"
           /

  clcl_simple simple climate classes
	/ tropical, temperate, boreal /

           
    clcl_mapping(clcl,clcl_simple) Mapping between detailed and simple climate classes
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

*' @stop

*** EOF sets.gms ***
