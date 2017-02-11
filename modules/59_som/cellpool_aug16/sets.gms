*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

sets
noncropland59(land)
/past, forestry, forest, urban, other/

pools59
/cropland,noncropland/

tillage59
/full,reduced,notill/

inputs59
/low,medium,high_nomanue,high_manure/

climate59 climate classes of IPCC 2006
/temperate_dry,temperate_moist,tropical_dry,tropical_moist,tropical_montaine/

clcl climate classification types
           / BWh  .(tropical_dry) "arid desert hot arid"
             As   .() "equatorial summer dry"
             BSh  .() "arid steppe hot arid"
             Aw   .(tropical_moist) "equatorial winter dry"
             Am   .(tropical_moist) "equatorial monsoonal"
             Af   .(tropical_moist) "equatorial fully humid"
             BWk  .(temperate_dry) "arid desert cold arid"
             BSk  .(temperate_dry) "arid steppe cold arid"
             Cwb  .() "warm temperate winter dry warm summer"
             Cwa  .() "warm temperate winter dry hot summer"
             Csb  .() "warm temperate summer dry warm summer"
             Csa  .() "warm temperate summer dry hot summer"
             Cfa  .() "warm temperate fully humid hot summer"
             Cfb  .() "warm temperate fully humid warm summer"
             ET   .() "polar polar tundra"
             Dfc  .() "snow fully humid cool summer"
             Dfb  .() "snow fully humid warm summer"
             Dwb  .() "snow winter dry warm summer"
             Dwc  .() "snow winter dry cool summer"
             Dfa  .() "snow fully humid hot summer"
             Cwc  .() "warm temperate winter dry cool summer"
             Dwa  .() "snow winter dry hot summer"
             EF   .() "polar polar frost"
             Cfc  .() "warm temperate fully humid cool summer"
             Dsb  .() "snow summer dry warm summer"
             Dsa  .() "snow summer dry hot summer"
             Dsc  .() "snow summer dry cool summer"
             Dfd  .() "snow fully humid extremely continental"
             Dwd  .() "snow winter dry extremely continental"
             Dsd  .() "snow summer dry extremely continental"
             Csc  .() "warm temperate summer dry cool summer"
           /
;