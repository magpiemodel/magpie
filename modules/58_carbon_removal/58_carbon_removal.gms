*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @title Carbon removal
*'
*' @description The carbon removal module intends to calculate the amount of terrestrial/land-based
*' carbon dioxide removal (CDR) and the associated costs to represent mechanisms 
*' such as the UN REDD Programme. The economic incentive for CDR is 
*' a reward (carbon price) for negative carbon emissions. These negative carbon emissions 
*' would be multiplied by the carbon price, resulting in economic incentive to reduce emissions.
*' Because the objective function of MAgPIE is the minimization of total global costs, 
*' the negative price on carbon emissions serves as incentive for the deployment of CDRs. 
*'
*' @authors Florian Humpenöder, Jan Philipp Dietrich.

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%carbon_removal%" == "off_sep16" $include "./modules/58_carbon_removal/off_sep16.gms"
*###################### R SECTION END (MODULETYPES) ############################
