*** |  (C) 2008-2022 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

* vm_land.lo(j,"past") = pm_land_conservation(t,j,"past","protect");
vm_land.lo(j,"past") = sum(consv_type, pm_land_conservation(t,j,"past",consv_type));
