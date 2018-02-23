*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de



i55_manure_recycling_share(i,kli,awms_conf,"nr")=f55_awms_recycling_share(i,kli,awms_conf);
* ASSUMPTION: no leaching or other losses for p and k.
i55_manure_recycling_share(i,kli,awms_conf,"p")=1;
i55_manure_recycling_share(i,kli,awms_conf,"k")=1;
