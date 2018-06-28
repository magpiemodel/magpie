*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @title Marginal Abatement Cost Curves 
*'
*' @description This module describes technical mitigation of GHG emissions.
*' It allows to reduce GHG emissions by undertaking mitigation
*' measures in exchange for additional mitigation costs.
*' The technical mitigation measures include, for example, better spreader maintenance,
*' feed additives or investments in animal waste management facilities.
*' Please note that technical mitigation is possible only in the "on" module realization below.
*' For simplicity, we considered only the effects of mitigation measure costs and emissions.
*' Their direct consequences on biophysical values like yields or water requirements is ignored at the moment.
*'
*' Mitigation costs are estimated using marginal abatement cost curves (MACCs).
*' The curves allow to reduce emissions before technical mitigation (btm)
*' by a certain percentage in exchange for additional costs.
*' The MACCs used in this module are based on the data from @LUCAS200785.
*' Despite we have reservations on its data quality, we stick on it as we are aware of no other better data.
*'
*' @authors Benjamin Leon Bodirsky

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%maccs%" == "off_jul16" $include "./modules/57_maccs/off_jul16.gms"
$Ifi "%maccs%" == "on_sep16" $include "./modules/57_maccs/on_sep16.gms"
*###################### R SECTION END (MODULETYPES) ############################
