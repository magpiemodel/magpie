*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*fix primforest
vm_land.fx(j,"primforest") = pcm_land(j,"primforest");

*fix secdforest
v35_secdforest.fx(j,"new") = 0;
v35_secdforest.fx(j,"grow") = 0;
v35_secdforest.fx(j,"old") = pcm_land(j,"secdforest");
vm_land.fx(j,"secdforest") = sum(land35, v35_secdforest.l(j,land35));

*fix other land
v35_other.fx(j,"new") = 0;
v35_other.fx(j,"grow") = 0;
v35_other.fx(j,"old") = pcm_land(j,"other");
vm_land.fx(j,"other") = sum(land35, v35_other.l(j,land35));

vm_landdiff_natveg.fx = 0;

vm_prod_cell_natveg.fx(j,kforestry) = 0;
