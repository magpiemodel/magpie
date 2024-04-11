*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
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
*' The curves are applied on the original emissions,
*' and reduce them by a certain percentage in exchange for additional costs.
*' The MACCs used in this module are based on the data from @LUCAS200785.
*'
*' @authors Benjamin Leon Bodirsky, Florian Humpenoeder

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%maccs%" == "on_aug22" $include "./modules/57_maccs/on_aug22/realization.gms"
*###################### R SECTION END (MODULETYPES) ############################
