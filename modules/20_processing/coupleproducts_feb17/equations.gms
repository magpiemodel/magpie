*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de


q20_processing_aggregation_nocereals(i2,kpr) ..
        vm_dem_processing(i2,kpr)
        =e=
        sum(no_milling_ginning20,v20_dem_processing(i2,no_milling_ginning20,kpr));

q20_processing_aggregation_cereals(i2,kcereals20) ..
        vm_dem_food(i2,kcereals20)
        =e=
        v20_dem_processing(i2,"milling",kcereals20);

q20_processing_aggregation_cotton(i2) ..
        vm_prod_reg(i2,"cottn_pro")
        =e=
        v20_dem_processing(i2,"ginning","cottn_pro");

q20_processing(i2,kpr,ksd) ..
        sum(processing20,
            v20_dem_processing(i2,processing20,kpr)
            * sum(ct,f20_processing_conversion_factors(ct,processing20,ksd,kpr))
        )
        =e=
       (vm_prod_reg(i2,ksd) - sum(ct,f20_processing_balanceflow(ct,i2,ksd)))
        *sum(ct,f20_processing_shares(ct,i2,ksd,kpr))
        - v20_secondary_substitutes(i2,ksd,kpr)
        + vm_secondary_overproduction(i2,ksd,kpr);

q20_processing_substitution(i2,dm_ge_nr) ..
        sum(kpr, v20_dem_processing(i2,"substitutes",kpr) * fm_attributes(dm_ge_nr,kpr))
        =g=
        sum((ksd,kpr), v20_secondary_substitutes(i2,ksd,kpr) * fm_attributes(dm_ge_nr,ksd) );
