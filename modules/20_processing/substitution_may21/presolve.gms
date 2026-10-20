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

*' The fibres balanceflow is removed in regions without a domestic cotton route
*' (`pm_no_cotton_route`, see 21_trade). Fibres are only produced by ginning domestic
*' cotton (`q20_processing_aggregation_cotton`), so the balanceflow cannot count as production there.
i20_processing_balanceflow(ct,i,ksd) = f20_processing_balanceflow(ct,i,ksd);
i20_processing_balanceflow(ct,i,"fibres")$(pm_no_cotton_route(ct,i) = 1) = 0;
