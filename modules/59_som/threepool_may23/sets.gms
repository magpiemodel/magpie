*** |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

sets

sPools59 soil pools
/ active, slow, passive /

noncropland59(land) Soil carbon conserving landuse types
/ past, forestry, primforest, secdforest, other, urban /

tillage59 Tillage categories of IPCC
/ fulltill, reducedtill, notill /

lutypes59 Land-use types 
/ crop, natveg /

kcr_tillage59(kcr,tillage59) Climate classification types
           /
           begr      .(reducedtill) "reduced tillage"
           betr      .(reducedtill) "reduced tillage"
           cassav_sp .(fulltill) "full tillage"
           cottn_pro .(fulltill) "full tillage"
           foddr     .(fulltill) "full tillage"
           groundnut .(fulltill) "full tillage"
           maiz      .(fulltill) "full tillage"
           oilpalm   .(reducedtill) "reduced tillage"
           others    .(reducedtill) "reduced tillage"
           potato    .(fulltill) "full tillage"
           puls_pro  .(fulltill) "full tillage"
           rapeseed  .(fulltill) "full tillage"
           rice_pro  .(fulltill) "full tillage"
           soybean   .(fulltill) "full tillage"
           sugr_beet .(fulltill) "full tillage"
           sugr_cane .(reducedtill) "reduced tillage"
           sunflower .(fulltill) "full tillage"
           tece      .(fulltill) "full tillage"
           trce      .(fulltill) "full tillage"
           /

lutypes59_land(land,lutypes59) Mapping land to soil model land classes
           /
           crop       .(crop)   "cropland"
           past       .(natveg) "potential natural vegetation"
           forestry   .(natveg) "potential natural vegetation"
           primforest .(natveg) "potential natural vegetation"
           secdforest .(natveg) "potential natural vegetation"
           other      .(natveg) "potential natural vegetation"
           urban      .(natveg) "potential natural vegetation"
           / 
;

alias(noncropland59,noncropland59_2);
alias(land,land2);
alias(lutypes59_land,lutypes59_land2);
alias(kcr,kcr2);
