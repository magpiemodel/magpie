*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

vm_land.l(j,land) = pcm_land(j,land);

*The following bounds should be moved to the respective land modules in the future (different bounds for different realizations)

*' @code Some of the land use transitions are restricted:

*' No afforestation on natveg areas
*v10_lu_transitions.fx(j,"primforest","forestry") = 0;
*v10_lu_transitions.fx(j,"secdforest","forestry") = 0;
*v10_lu_transitions.fx(j,"other","forestry") = 0;

*' Conversions within natveg are not allowed
v10_lu_transitions.fx(j,"primforest","other") = 0;
v10_lu_transitions.fx(j,"secdforest","other") = 0;

*' Forestry can only increase
*v10_lu_transitions.fx(j,"forestry",land_to10) = 0;
*v10_lu_transitions.up(j,"forestry","forestry") = Inf;

*' Primforest can only decrease
v10_lu_transitions.fx(j,land_from10,"primforest") = 0;
v10_lu_transitions.up(j,"primforest","primforest") = Inf;

*' Secdforest can only decrease (during optimization)
*v10_lu_transitions.fx(j,land_from10,"secdforest") = 0;
*v10_lu_transitions.up(j,"secdforest","secdforest") = Inf;

*' Urban land is fixed
v10_lu_transitions.fx(j,land_from10,"urban") = 0;
v10_lu_transitions.fx(j,"urban",land_to10) = 0;
v10_lu_transitions.fx(j,"urban","urban") = pcm_land(j,"urban");

*' @stop
