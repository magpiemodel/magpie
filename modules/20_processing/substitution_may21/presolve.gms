*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
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
