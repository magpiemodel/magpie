*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description The fbask_jan16 realization of the livestock module is based on
*' the methodology as described in @weindl_livestock_2017 and
*' @weindl_livestock_2017-1. An important part of the feed demand calculations
*' is conducted outside of the core MAgPIE-GAMS code. Livestock products
*' (ruminant meat, whole-milk, pork, poultry meat and eggs) are supplied by five
*' animal food systems (beef cattle, dairy cattle, pigs, broilers and laying
*' hens). The parameterization of the livestock sector in the initial year is
*' consistent with FAO statistics regarding livestock production, livestock
*' productivity and concentrate feed use.

*' The fbask_jan16 realization requires regional and product-specific feed
*' baskets that are calculated by a set of preprocessing routines outside of the
*' MAgPIE-GAMS code. Following the methodology of @wirsenius_human_2000, feed
*' conversion (total feed input per product output in dry matter) and feed
*' baskets (demand for different feed types per product output in dry matter)
*' are derived by compiling system-specific feed energy balances. For the
*' establishment of these balances, we apply feed energy requirements per output,
*' as estimated by wirsenius_human_2000 for each animal function and animal food
*' system. These estimates are based on standardized bio-energetic equations and
*' include the minimum energy requirements for maintenance, growth, lactation,
*' reproduction and other basic biological functions of the animals. Moreover,
*' they comprise a general allowance for basic activity and temperature effects.

*' By distributing the available feed at country level to animal food systems
*' according to their feed energy demand and dividing resulting dry matter feed
*' use by the production volume of the respective systems, we obtain both
*' estimates for feed conversion and feed baskets across different animal food
*' systems and countries.

*' To facilitate projections of feed conversion and feed baskets, we create
*' regression models with livestock productivity (annual production per animal
*' [ton fresh matter/animal/year]) as predictor, which permit the construction
*' of livestock feeding scenarios. Currently, feeding scenarios are derived
*' based on exogenous livestock productivity scenarios consistent with the
*' storylines of the Shared Socioeconomic Pathways (SSPs). For beef cattle, pigs
*' and broilers, livestock productivity is defined as meat production per
*' animals in stock (e.g. total cattle herd) and for dairy cattle and laying hen
*' as milk or egg production per producing animals (e.g. milk cows).

*' A power function is used to describe the functional relation between feed
*' conversion and livestock productivity:

*' ![Relationship between feed conversion and livestock productivity
*' [@weindl_livestock_2017].](feed_conv.jpg){ width=100% }

*' In the case of feed composition, we use an additional proxy parameter in our
*' analysis. What type of biomass is used to feed animals is to a certain extent
*' influenced by universal aspects (e.g. the need for more energy-rich feed at
*' higher productivity levels), whereas other aspects are strongly influenced by
*' geographical location (e.g. availability and costs of permanent pasture
*' compared to cropland feed, agro-ecological and climatic conditions that
*' favour selected feed items; socio-cultural determinants etc.). For cattle
*' systems the proxy (climate-zone specific factor) was determined by
*' calculating the share of the national population living in arid and cold
*' climate zones.

*' ![Relationship between the share of crop residues, occasional feed and grazed
*' biomass in feed baskets and livestock productivity for beef cattle systems
*' [@weindl_livestock_2017].](feed_comp_beef.jpg){ width=60% }

*' ![Relationship between the share of crop residues, occasional feed and grazed
*' biomass in feed baskets and livestock productivity for diary cattle systems
*' [@weindl_livestock_2017].](feed_comp_dairy.jpg){ width=60% }

*' These relationships between feed baskets and livestock productivity are used 
*' to construct feeding scenarios that reflect the narratives of the SSPs. The 
*' resulting feed baskets enter the MAgPIE model as scenario-dependent input data
*' and are crucial for the feed demand calculations in the livestock module.

*' @limitations Intensification of livestock production and related changes in
*' livestock feeding are modelled exogenously. Therefore, the livestock sector
*' does not endogenously respond to demand and climate shocks and policies, e.g.
*' targeting climate protection.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/70_livestock/fbask_jan16/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/70_livestock/fbask_jan16/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/70_livestock/fbask_jan16/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/70_livestock/fbask_jan16/equations.gms"
$Ifi "%phase%" == "preloop" $include "./modules/70_livestock/fbask_jan16/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/70_livestock/fbask_jan16/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/70_livestock/fbask_jan16/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
