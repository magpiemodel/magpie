*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


vm_dem_processing.fx(i,knpr)=0;

vm_secondary_overproduction.fx(i2,kall,kpr)=0;
vm_secondary_overproduction.up(i2,ksd,kpr)=Inf;

v20_secondary_substitutes.fx(i2,ksd,kpr)=0;
v20_secondary_substitutes.up(i2,"oils",kpr)=Inf;
v20_secondary_substitutes.up(i2,"molasses",kpr)=Inf;
v20_secondary_substitutes.up(i2,"distillers_grain",kpr)=Inf;
v20_secondary_substitutes.up(i2,"oilcakes",kpr)=Inf;
v20_secondary_substitutes.up(i2,"brans",kcereals20)=Inf;


*' Interaction with 21_trade: fibres can only be produced from domestic cotton (ginning).
*' In some cases, the reported fibre production differs from what can be obtained from
*' processing the reported domestic cotton. The processing balanceflow covers this difference
*' for consistency.
*' If however a (super)region reports no cotton production at all, its self-sufficiency
*' ratio is 0 in the trade realization `selfsuff_reduced`. All cotton then has to be imported,
*' i.e. domestic cotton production is forced to zero, and therefore no fibres can be produced
*' domestically either. The trade module therefore also sets the fibres self-sufficiency ratio
*' to 0 in this case, so that all fibres are imported. The processing balanceflow represents
*' domestic fibre production, so it is set to 0 for these regions as well for consistency.

i20_processing_balanceflow(ct,i,ksd) = f20_processing_balanceflow(ct,i,ksd);
i20_processing_balanceflow(ct,i,"fibres")$(pm_no_cotton_route(ct,i) = 1) = 0;
