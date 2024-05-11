*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description As official global statistics exist only for crop production and not for crop
*' residue production, the biomass of residues is obtained in MAgPIE by using
*' crop-type specific plant growth functions based on crop production and area harvested.
*' Plant biomass is divided into three components: the harvested organ as listed
*' in FAO, the aboveground (AG) and the belowground (BG) residues.
*'
*' @ipcc_2006_2006 offers one of the few consistent datasets to estimate
*' both AG and BG residues. Also, by providing crop-growth functions (CGF, `f18_cgf`)
*' instead of fixed harvest indices, it can be used to depict current
*' international differences of harvest indices and their development in the future.
*' The methodology is thus well eligible for global long-term modelling.
*' @ipcc_2006_2006 provides linear CGFs with positive slope and intercept
*' for cereals, leguminous crops, potatoes and grasses. As no values are
*' available for the oilcrops rapeseed, sunflower, oilpalms as well as
*' sugar crops, tropical roots, cotton and others, we use fixed harvest-indices
*' (positive slope without intercept) for these crops based
*' on @wirsenius_human_2000, @lal_world_2005 and @feller_dungung_2007. If different CGFs are available
*' for crops within a crop group, we build a weighted average based on the
*' production in 1995.
*' 
*' This realization enforces cluster-level agricultural residue production, based on agricultural production
*' at the same level. However, other uses such as burning and recycling are allowed to be balanced at the 
*' regional level, in order to reduce computational complexity.


*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/18_residues/flexcluster_jul23/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/18_residues/flexcluster_jul23/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/18_residues/flexcluster_jul23/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/18_residues/flexcluster_jul23/equations.gms"
$Ifi "%phase%" == "scaling" $include "./modules/18_residues/flexcluster_jul23/scaling.gms"
$Ifi "%phase%" == "preloop" $include "./modules/18_residues/flexcluster_jul23/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/18_residues/flexcluster_jul23/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/18_residues/flexcluster_jul23/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
