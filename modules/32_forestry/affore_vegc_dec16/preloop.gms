*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

* Select afforestation policy depending on `c32_aff_policy`.
p32_aff_pol(t,j) = f32_aff_pol(t,j,"%c32_aff_policy%");


*initialize parameter
p32_land(t,j,ac,when) = 0;
