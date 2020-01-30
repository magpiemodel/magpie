*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @code

sets
   clcl climate classification types
           /
             BWh  "arid desert hot arid"
             As   "equatorial summer dry"
             BSh  "arid steppe hot arid"
             Aw   "equatorial winter dry"
             Am   "equatorial monsoonal"
             Af   "equatorial fully humid"
             BWk  "arid desert cold arid"
             BSk  "arid steppe cold arid"
             Cwb  "warm temperate winter dry warm summer"
             Cwa  "warm temperate winter dry hot summer"
             Csb  "warm temperate summer dry warm summer"
             Csa  "warm temperate summer dry hot summer"
             Cfa  "warm temperate fully humid hot summer"
             Cfb  "warm temperate fully humid warm summer"
             ET   "polar polar tundra"
             Dfc  "snow fully humid cool summer"
             Dfb  "snow fully humid warm summer"
             Dwb  "snow winter dry warm summer"
             Dwc  "snow winter dry cool summer"
             Dfa  "snow fully humid hot summer"
             Cwc  "warm temperate winter dry cool summer"
             Dwa  "snow winter dry hot summer"
             EF   "polar polar frost"
             Cfc  "warm temperate fully humid cool summer"
             Dsb  "snow summer dry warm summer"
             Dsa  "snow summer dry hot summer"
             Dsc  "snow summer dry cool summer"
             Dfd  "snow fully humid extremely continental"
             Dwd  "snow winter dry extremely continental"
             Dsd  "snow summer dry extremely continental"
             Csc  "warm temperate summer dry cool summer"
           /

  ipcc32 ipcc climate regions
  /
  tropical, temperate, boreal
  /

  clcl_ipcc32(clcl,ipcc32) Climate classification types
            /
            Af .(tropical) "equatorial fully humid"
            Am .(tropical) "equatorial monsoonal"
            As .(tropical) "equatorial summer dry"
            Aw .(tropical) "equatorial winter dry"
            BSh .(tropical) "arid steppe hot arid"
            BSk .(temperate) "arid steppe cold arid"
            BWh .(tropical) "arid desert hot arid"
            BWk .(temperate) "arid desert cold arid"
            Cfa .(temperate) "warm temperate fully humid hot summer"
            Cfb .(temperate) "warm temperate fully humid warm summer"
            Cfc .(temperate) "warm temperate fully humid cool summer"
            Csa .(temperate) "warm temperate summer dry hot summer"
            Csb .(temperate) "warm temperate summer dry warm summer"
            Csc .(temperate) "warm temperate summer dry cool summer"
            Cwa .(temperate) "warm temperate winter dry hot summer"
            Cwb .(temperate) "warm temperate winter dry warm summer"
            Cwc .(temperate) "warm temperate winter dry cool summer"
            Dfa .(temperate) "snow fully humid hot summer"
            Dfb .(temperate) "snow fully humid warm summer"
            Dfc .(boreal) "snow fully humid cool summer"
            Dfd .(temperate) "snow fully humid extremely continental"
            Dsa .(boreal) "snow summer dry hot summer"
            Dsb .(boreal) "snow summer dry warm summer"
            Dsc .(boreal) "snow summer dry cool summer"
            Dsd .(boreal) "snow summer dry extremely continental"
            Dwa .(boreal) "snow winter dry hot summer"
            Dwb .(boreal) "snow winter dry warm summer"
            Dwc .(boreal) "snow winter dry cool summer"
            Dwd .(boreal) "snow winter dry extremely continental"
            EF .(boreal) "polar polar frost"
            ET .(boreal) "polar polar tundra"
            /         

;

*' @stop

*** EOF sets.gms ***
