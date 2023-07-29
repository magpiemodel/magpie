*** |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

sets

cSource59 carbon input pools
/ residues, litter /
* / set.kcr /
* later / set.kcr, set.kli, litter59/

* litter59 pools
* / litter_leaf, litter_wood/

soilPools59 soil pools
/active, slow, passive/

noncropland59(land) Soil carbon conserving landuse types
/past, forestry, primforest, secdforest, other, urban/

tillage59 Tillage categories of IPCC
/full_tillage, reduced_tillage, no_tillage/

kcr_tillage59(kcr,tillage59) Climate classification types
           /
           begr      .(reduced_tillage) "reduced tillage"
           betr      .(reduced_tillage) "reduced tillage"
           cassav_sp .(full_tillage) "full tillage"
           cottn_pro .(full_tillage) "full tillage"
           foddr     .(full_tillage) "full tillage"
           groundnut .(full_tillage) "full tillage"
           maiz      .(full_tillage) "full tillage"
           oilpalm   .(reduced_tillage) "reduced tillage"
           others    .(reduced_tillage) "reduced tillage"
           potato    .(full_tillage) "full tillage"
           puls_pro  .(full_tillage) "full tillage"
           rapeseed  .(full_tillage) "full tillage"
           rice_pro  .(full_tillage) "full tillage"
           soybean   .(full_tillage) "full tillage"
           sugr_beet .(full_tillage) "full tillage"
           sugr_cane .(reduced_tillage) "reduced tillage"
           sunflower .(full_tillage) "full tillage"
           tece      .(full_tillage) "full tillage"
           trce      .(full_tillage) "full tillage"
           /
;

alias(noncropland59,noncropland59_2);
