*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
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
