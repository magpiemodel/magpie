*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description The fbask_jan16_sticky realization of the livestock module is based on
*' the fbask_jan16 realization, and only differs from it by implementing capital stocks 
*' as introduced in the `sticky_feb18` factor cost module realization.
*'
*' The methodology of fbask_jan16 is described in @weindl_livestock_2017 and
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

*'
*' In this realization the capital share of livestock production cost does not have 
*' to be paid every timestep, but is fulfilled by having a corresponding capital stock,
*' which mostly persists across timesteps. (See `s70_depreciation_rate`)
*' This means that the production becomes cheaper in regions with
*' higher capital shares and existing corresponding capital stocks,
*' which makes the livestock production "stick" to some degree to existing levels. 
*' Another effect is that production increases are more likely to occur in regions
*' of more capital intensive livestock systems with already established stocks.
*'
*' The realization is based on the `sticky_feb18` factor cost realization, but
*' also differs from it in some ways. At the creation time the main differences were: 
*' 1. capital stocks are on the regional level not on cluster level
*' 2. no differentiation of mobile and immobile capital - all capital stocks are immobile
*'  
*' @limitations Intensification of livestock production and related changes in
*' livestock feeding are modelled exogenously. Therefore, the livestock sector
*' does not endogenously respond to demand and climate shocks and policies, e.g.
*' targeting climate protection.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/70_livestock/fbask_jan16_sticky/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/70_livestock/fbask_jan16_sticky/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/70_livestock/fbask_jan16_sticky/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/70_livestock/fbask_jan16_sticky/equations.gms"
$Ifi "%phase%" == "preloop" $include "./modules/70_livestock/fbask_jan16_sticky/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/70_livestock/fbask_jan16_sticky/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/70_livestock/fbask_jan16_sticky/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
