*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @title Technological change
*'
*' @description The technological change module describes the relation between
*' agricultural land use intensity represented by the $\tau$ factor and the
*' costs which have to be paid for further intensification (technological change
*' costs). Besides cropland expansion ([39_landconversion]) and trade ([21_trade])
*' it describes the third major option of the model to increase regional supply.
*' In order to calculate this relation, the module needs to receive information
*' about the assumed interest rate and assumed investment horizon currently
*' provided by module [12_interest_rate].
*'
*' Calculated $\tau$ factors are then used for yields calculation by [14_yields]
*' and by [38_factor_costs] for the calculation of factor costs.
*'
*' @authors Jan Philipp Dietrich, Christoph Schmitz, Benjamin Bodirsky

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%tc%" == "endo_JUN16" $include "./modules/13_tc/endo_JUN16.gms"
$Ifi "%tc%" == "endo_jun18" $include "./modules/13_tc/endo_jun18.gms"
*###################### R SECTION END (MODULETYPES) ############################
