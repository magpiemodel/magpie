*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @equations
*' The equations below show the aggregation of secondary products from non-cereal(through fermentation, breeding, distilling)
*' , cereals (through milling process), and cotton (through ginning process).
*'  The need to have multiple equations(or separate equations for each process) 
*' in this regard is meant to replicate the structure of FAOSTAT. 

q20_processing_aggregation_nocereals(i2,kpr) ..
        vm_dem_processing(i2,kpr)
	                        	  =e= 
		sum(no_milling_ginning20,v20_dem_processing(i2,no_milling_ginning20,kpr));

*' The demand for processing use`vm_dem_processing` is calculated
*' by aggregating the demand for processing use by process `v20_dem_processing`.
*' This equation calculates secondary products from non-cereals crops
*' ,for example, as bio-energy crops and oil crops.

q20_processing_aggregation_cereals(i2,kcereals20) ..
        vm_dem_food(i2,kcereals20) =e= v20_dem_processing(i2,"milling",kcereals20);

*' The demand for processing by process `v20_dem_processing` of milling
*' of cereal crops. The equation is applies to only byproducts from cereal crops which, among others,
*' include maize, tropical and temperate cereals. As in FAOSTAT, cereal milling here is
*' also not counted as processing but derived from food use of cereals.

q20_processing_aggregation_cotton(i2) ..
        vm_prod_reg(i2,"cottn_pro") =e= v20_dem_processing(i2,"ginning","cottn_pro");


*' The demand for processing by process `v20_dem_processing` of ginning of cotton.
*' The FAOSTAT Commodity Balance Sheets do also not account for processing of "seed cotton"
*' into "cotton seed" and "cotton lint". As MAgPIE only includes the product "cotton seed" and not "seed cotton", 
*' the "cotton lint" is bound to the production of "cotton seed". 

q20_processing(i2,kpr,ksd) ..
    sum(processing20, v20_dem_processing(i2,processing20,kpr) 
	 * sum(ct,f20_processing_conversion_factors(ct,processing20,ksd,kpr)))
        =e= 
	(vm_prod_reg(i2,ksd) - sum(ct,f20_processing_balanceflow(ct,i2,ksd)))
    *sum(ct,f20_processing_shares(ct,i2,ksd,kpr))
    - v20_secondary_substitutes(i2,ksd,kpr)
    + vm_secondary_overproduction(i2,ksd,kpr);

*' This equation handles the transformation of primary into secondary products. The processing conversion factors
*' indicate how many secondary products can be derived from one unit of primary product.
*' To avoid perfect substitutability between different primary commodities being transformed into the same
*' secondary product (e.g. oil from sunflower or oilpalm), we use the coefficient `f20_processing_shares`,
*' indicating how much of the secondary products comes from which primary product.
*' The `f20_balanceflow` accounts for differences in conversion efficiency among various countries, 
*' whereas the conversion factors remain global.
*' The `v20_secondary_substitutes` are used to avoid overproduction of couple products; for each couple product,
*' there is one secondary product (usually the cheaper one) which can be substituted by other commodities 
*' (see also equations below). The secondary overproduction is used to move overproduction 
*' into the waste category, such that the demand balance remains in equality (see [16_demand]).

*' The equation below replaces the couple products bran oils and germoil by other oils.

q20_processing_substitution_oils(i2) ..

v20_dem_processing(i2,"substitutes","oils") =g= sum((kcereals20), v20_secondary_substitutes(i2,"oils",kcereals20) );

*'

*' The equation below replaces brans by cereals of same protein value.
q20_processing_substitution_brans(i2) ..
   sum(kcereals20, v20_dem_processing(i2,"substitutes",kcereals20) * fm_attributes("nr",kcereals20)) 
   =g=
   sum((kcereals20), v20_secondary_substitutes(i2,"brans",kcereals20) * fm_attributes("nr","brans"));

*' The last equation in this realization is meant to compute costs of processing (or converting) 
*' to produce secondary (or by) products.

q20_processing_costs(i2) ..
    vm_cost_processing(i2)
                                  =e=
    sum((ksd,processing20,kpr), v20_dem_processing(i2,processing20,kpr)
                                * sum(ct,f20_processing_conversion_factors(ct,processing20,ksd,kpr))
                                * f20_processing_unitcosts(ksd,kpr)
        );


*' As show in the equation, the costs of processing (converting from primary to secondary products)
*' depend on the type of the primary product (e.g. maize, sugar cane, cotton),
*' type of the process (e.g. milling, refining, ginning), 
*' and the secondary (e.g. brans, sugar, fiber) product.
*' The unit costs of processing `f20_processing_unitcosts`
*' are primary-process-secondary specific collected, interpolated,
*' and extrapolated from the related literature complemented with best educated guess by the module authors.