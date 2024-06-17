*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*The following bounds should be moved to the respective land modules in the future (different bounds for different realizations)

*' @code Some of the land use transitions are restricted:

*' No planted forest on natveg areas
vm_lu_transitions.fx(j,"primforest","forestry") = 0;

*' Conversions within natveg are not allowed
vm_lu_transitions.fx(j,"primforest","other") = 0;
vm_lu_transitions.fx(j,"secdforest","other") = 0;

*' Primforest can only decrease
vm_lu_transitions.fx(j,land_from,"primforest") = 0;
vm_lu_transitions.up(j,"primforest","primforest") = Inf;

*' @stop

m_boundfix(vm_land,(j,land),up,1e-6);
