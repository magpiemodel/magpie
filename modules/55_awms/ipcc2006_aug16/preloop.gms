*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de



i55_manure_recycling_share(i,kli,awms_conf,"nr")=f55_awms_recycling_share(i,kli,awms_conf);
* ASSUMPTION: no leaching or other losses for p and k.
i55_manure_recycling_share(i,kli,awms_conf,"p")=1;
i55_manure_recycling_share(i,kli,awms_conf,"k")=1;
