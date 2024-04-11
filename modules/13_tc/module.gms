*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @title Technological change
*'
*' @description The technological change (TC) module describes the relation
*' between agricultural land use intensity represented by the $\tau$ factor and
*' the costs which have to be paid for further intensification (technological
*' change costs). Besides cropland expansion ([39_landconversion]) and trade
*' ([21_trade]), it describes the third major option of the model to increase
*' regional supply. In order to calculate this relation, the module needs to
*' receive information about the assumed interest rate and assumed investment
*' horizon currently provided by module [12_interest_rate].
*'
*' Calculated $\tau$ factors are then used for yields calculation by [14_yields]
*' and by [38_factor_costs] for the calculation of factor costs.
*'
*' @authors Jan Philipp Dietrich, Christoph Schmitz, Benjamin Bodirsky, Florian Humpenoeder, Marcos Alves

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%tc%" == "endo_jan22" $include "./modules/13_tc/endo_jan22/realization.gms"
$Ifi "%tc%" == "exo" $include "./modules/13_tc/exo/realization.gms"
*###################### R SECTION END (MODULETYPES) ############################
