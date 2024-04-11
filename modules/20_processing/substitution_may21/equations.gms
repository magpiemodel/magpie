*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations
*' The series of equations below show the aggregation of secondary products
*' from non-cereals (through alcohol fermentation, single cell protein breeding,
*' oil extracting, sugar refining or ethanol distilling processes),
*' cereals (through milling process), and cotton (through ginning process).
*' The need to have such multiple equations (i.e., separate equations for each process)
*' is meant to replicate the structure of Commodity Balance Sheets in @FAOSTAT.
*'
*' In the first equation, the demand for processing use is calculated
*' by aggregating the demand for secondary (processed) products use by process type
*' (other than milling and ginning in this equation case).
*' The equation also calculates secondary products from non-cereals crops
*' such as bio-energy crops and oil crops.

q20_processing_aggregation_nocereals(i2,kpr) ..
 vm_dem_processing(i2,kpr) =e=
  sum(no_milling_ginning20,v20_dem_processing(i2,no_milling_ginning20,kpr));

*' In the second equation, the demand for processed products by process type of milling
*' of cereal crops is calculated. The equation applies only to secondary products from cereal crops which, among others,
*' include maize, tropical and temperate cereals.
*' Nevertheless, as in Commodity Balance Sheets of  @FAOSTAT, cereal milling here is
*' not counted as processing but derived from food use of cereals.

q20_processing_aggregation_cereals(i2,kcereals20) ..
 vm_dem_food(i2,kcereals20) =e= v20_dem_processing(i2,"milling",kcereals20);

*' In the third equation, the demand for processing by process type `v20_dem_processing` of ginning of cotton is calculated.
*' Likewise, the Commodity Balance Sheets in @FAOSTAT do not account for processing of "seed cotton"
*' into "cotton seed" and "cotton lint". As MAgPIE only includes the product "cotton seed" and not "seed cotton",
*' the "cotton lint" is bound to the production of "cotton seed".

q20_processing_aggregation_cotton(i2) ..
 vm_prod_reg(i2,"cottn_pro") =e= v20_dem_processing(i2,"ginning","cottn_pro");


*' The fourth equation below describes the transformation of primary products into secondary products.
*' The processing conversion factors (`i20_processing_conversion_factors_cf`) indicate how much secondary products
*' can be derived from one unit of a specific primary product. The conversion factors are globally
*' equal to avoid path-dependencies in future outlooks based on historical patterns.
*' Historical differences in conversion efficiencies are instead considered using
*' a static balanceflow.
*' To avoid perfect substitutability between different primary commodities being transformed into the same
*' secondary product (e.g. oil from sunflower or oil palm), we use share factor coefficients, `i20_processing_shares`,
*' which indicate how much of the secondary products comes from which primary products.
*' The parameter `f20_processing_balanceflow` accounts for differences in conversion efficiency among various countries
*' whereas the conversion factors remain global. The `v20_secondary_substitutes` are used to avoid overproduction of couple products: for each couple product,
*' there is one secondary product (usually the cheaper one) which can be substituted by other commodities
*' (see also equations below). The secondary product overproduction `vm_secondary_overproduction` is used to move overproduction
*' of secondary products into the waste category such that the demand balance is maintained (see also [16_demand]).

q20_processing(i2,kpr,ksd) ..
  sum(processing20, v20_dem_processing(i2,processing20,kpr)
         * sum(ct,i20_processing_conversion_factors(ct,processing20,ksd,kpr)))  =e=
 (vm_prod_reg(i2,ksd) - sum(ct,f20_processing_balanceflow(ct,i2,ksd)))
         * sum(ct,i20_processing_shares(ct,i2,ksd,kpr))
         - v20_secondary_substitutes(i2,ksd,kpr)
         + vm_secondary_overproduction(i2,ksd,kpr);

*' Oils from one crop can be substituted by different types of oils.
q20_processing_substitution_oils(i2) ..
  v20_dem_processing(i2,"substitutes","oils") =g=
  sum((kpr), v20_secondary_substitutes(i2,"oils",kpr) );

*' Molasses can be substituted by sugar,
q20_processing_substitution_sugar(i2) ..
   v20_dem_processing(i2,"substitutes","sugar") =g=
    sum((kpr), v20_secondary_substitutes(i2,"molasses",kpr) );

*' Different types of primary oilcrops or oilcakes from different origins
*' as well as distillers grains can be substituted for oilcakes and distillers
*' grains based on their protein content.

q20_processing_substitution_protein(i2) ..
    sum(oilcake_substitutes20,
      v20_dem_processing(i2,"substitutes",oilcake_substitutes20)
      * fm_attributes("nr",oilcake_substitutes20)
    ) =g=
    sum(kpr,
      (v20_secondary_substitutes(i2,"distillers_grain",kpr)
      + v20_secondary_substitutes(i2,"oilcakes",kpr) )
      * fm_attributes("nr",kpr));

*' Brans can be substituted by cereals of the same protein value.

q20_processing_substitution_brans(i2) ..
   sum(kcereals20, v20_dem_processing(i2,"substitutes",kcereals20)
             * fm_attributes("nr",kcereals20))  =g=
   sum((kcereals20), v20_secondary_substitutes(i2,"brans",kcereals20)
            * fm_attributes("nr","brans"));

*' The seventh equation in this realization calculates the costs of processing (or converting)
*' primary products to secondary products.
*' As shown in the equation, the costs of processing (converting from primary to secondary products)
*' depend on the type of the primary product (e.g. maize, sugar cane, cotton),
*' the type of the process (e.g. milling, refining, ginning),
*' and the type of secondary product (e.g. brans, sugar, fiber) product.
*' The unit costs of processing, `i20_processing_unitcosts`,
*' are specific for the different conversion routes and are collected, interpolated,
*' and extrapolated from the related literature (e.g. @adanacioglu_profitability_2011, @pikaar_decoupling_2018, @valco_thecost_2016)
*' complemented with best educated guess by the module authors.
*' Costs for single-cell protein production (scp) are handled differently because 
*' scp production with hydrogen as substrate has no land requirements, and thus 
*' would have no cost.
*' All other scp production routes (mixed, methane, sugar and cellulose) have land requirements 
*' mapped to specific crops (`f20_scp_processing_shares`). 

q20_processing_costs(i2) ..
 vm_cost_processing(i2) =e=
sum((ksd,processing20,kpr), v20_dem_processing(i2,processing20,kpr)
         *sum(ct,i20_processing_conversion_factors(ct,processing20,ksd,kpr))
         * i20_processing_unitcosts(ksd,kpr))
         + (vm_prod_reg(i2,"scp") * sum(scptype, sum(ct, f20_scp_type_shr(scptype,"%c20_scp_type%")) * f20_scp_unitcosts(scptype)));
         ;

*' Finally, we assume that any substitution of one product by another,
*' diverging from our initial demand estimates, comes at a loss of utility.
*' We assume a loss of utility in the magnitude of 200 USD to strongly
*' disincentivize substitution.
*' Moreover, to account for heterogeneity of different types of oil which
*' are traded based on the assumption of homogeneity, we include a cost term
*' for quality differences which make low-quality oils like palm oil more
*' expensive and high quality oils cheaper. The magnitude of the quality
*' adjustment is based on current price differences between different
*' types of oils, standardized on the price of soybean oil.

q20_substitution_utility_loss(i2) ..
      vm_processing_substitution_cost(i2) =e=
      sum(kpr,
        v20_dem_processing(i2,"substitutes",kpr)
        * 200
      ) +
      sum((ksd,processing20,kpr), v20_dem_processing(i2,processing20,kpr)
        * sum(ct,i20_processing_conversion_factors(ct,processing20,ksd,kpr))
        * f20_quality_cost(ksd,kpr));
