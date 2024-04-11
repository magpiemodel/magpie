*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description The endo realization stands for endogenous implementation of
*' technological change and land use intensification. The intensification rates
*' are calculated endogenously based on an interplay between land use intensity
*' $\tau$ and technological change costs (as shown schematically in the figure
*' below). This module realization contains the implementation as described
*' in @dietrich_forecasting_2014 with two minor modifications:
*'
*'   * rates of previous investment decisions which still have to be paid are
*'     added to the technological change costs
*'   * the planning horizon for investments is unified over all investments in
*'     the model.
*'
*' ![Implementation of technological change in MAgPIE
*' [@dietrich_forecasting_2014]](tc_schematic.png){ width=60% }
*'
*' Initial land use intensity $\tau$ values for the year 2000 come from
*' @dietrich_measuring_2012 and are shown below.
*'
*' ![$\tau$-factors in world regions & global (GLO) for the year 2000.
*' [@dietrich_measuring_2012]](tau_regional.png){ width=60% }
*'
*' Investments into technological change (TC) trigger land use intensification
*' ($\tau$) which triggers in turn yields increases. How much intensification
*' can be triggered by an investment, depends on the investment-yield ratio,
*' which in turn depends on the current agricultural land use intensity. The
*' higher the current intensity level, the more expensive the additional
*' intensification will become. The interaction between land use intensity and
*' production costs per area as shown in the schematic is not covered by this
*' module and can be found instead in [38_factor_costs].

*' @limitations This module significantly reduces the overall computational
*' performance of the model since these endogenous calculations are highly
*' computational intensive.


*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/13_tc/endo_jan22/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/13_tc/endo_jan22/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/13_tc/endo_jan22/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/13_tc/endo_jan22/equations.gms"
$Ifi "%phase%" == "scaling" $include "./modules/13_tc/endo_jan22/scaling.gms"
$Ifi "%phase%" == "preloop" $include "./modules/13_tc/endo_jan22/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/13_tc/endo_jan22/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/13_tc/endo_jan22/postsolve.gms"
$Ifi "%phase%" == "nl_fix" $include "./modules/13_tc/endo_jan22/nl_fix.gms"
$Ifi "%phase%" == "nl_release" $include "./modules/13_tc/endo_jan22/nl_release.gms"
$Ifi "%phase%" == "nl_relax" $include "./modules/13_tc/endo_jan22/nl_relax.gms"
*######################## R SECTION END (PHASES) ###############################
