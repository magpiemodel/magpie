*** |  (C) 2008-2022 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations

*' Natural land conservation
*' Total natural land cannot be smaller than total natural land conservation target

 q22_natveg_conservation(j2) ..
            sum(land_natveg, vm_land(j2,land_natveg))
            =g=
            sum((ct,land_natveg,consv_type), pm_land_conservation(ct,j2,land_natveg,consv_type));

*' NPI/NDC land protection policies are implemented as minium forest land and other land stock.

 q22_min_forest(j2) .. vm_land(j2,"primforest") + vm_land(j2,"secdforest")
                       =g=
                       sum(ct, p22_min_forest(ct,j2));

 q22_min_other(j2) .. vm_land(j2,"other") =g= sum(ct, p22_min_other(ct,j2));



