*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

i42_wat_req_k(t,j,kve) = f42_wat_req_kve(t,j,kve);
i42_env_flows(t,j) = f42_env_flows(t,j);

i42_wat_req_k(t,j,kli) = f42_wat_req_kli(kli);
