*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

$ifthen "%c42_env_flow_policy%" == "mixed" i42_env_flow_policy(t,i) = sum(t_to_i_to_dev("y1995",i,dev), sum(scen42_to_dev(scen42,dev), f42_env_flow_policy(t,scen42)));
$else i42_env_flow_policy(t,i) = f42_env_flow_policy(t,"%c42_env_flow_policy%");
$endif

i42_wat_req_k(t,j,kve) = f42_wat_req_kve(t,j,kve);
i42_env_flows(t,j) = f42_env_flows(t,j);

i42_wat_req_k(t,j,kli) = f42_wat_req_kli(kli);
