*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de


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

*replacing branoils and germoil by other oils
q20_processing_substitution_oils(i2) ..
        v20_dem_processing(i2,"substitutes","oils")
        =g=
        sum((kcereals20), v20_secondary_substitutes(i2,"oils",kcereals20) );

*replacing brans by cereals of same protein value
q20_processing_substitution_brans(i2) ..
        sum(kcereals20, v20_dem_processing(i2,"substitutes",kcereals20) * fm_attributes("nr",kcereals20))
        =g=
        sum((kcereals20), v20_secondary_substitutes(i2,"brans",kcereals20) * fm_attributes("nr","brans"));

q20_processing_costs(i2) ..
        vm_cost_processing(i2)
        =e=
        sum((ksd,processing20,kpr),
            v20_dem_processing(i2,processing20,kpr)
            * sum(ct,f20_processing_conversion_factors(ct,processing20,ksd,kpr))
            * f20_processing_unitcosts(ksd,kpr)
        );
