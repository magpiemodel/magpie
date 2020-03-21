*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de



$ifthen "%c42_env_flow_policy%" == "mixed" i42_env_flow_policy(t,i) = im_development_state(t,i) * f42_env_flow_policy(t,"on");
$else i42_env_flow_policy(t,i) = f42_env_flow_policy(t,"%c42_env_flow_policy%");
$endif



* Agricultural water demand
ic42_wat_req_k(j,k) = i42_wat_req_k(t,j,k);
ic42_env_flow_policy(i) = i42_env_flow_policy(t,i);

* water consumption in industry, sanitation, ecosystem
* (assign s42_reserved_fraction to industry for simplicity)
vm_watdem.fx("industry",j) = sum(wat_src, im_wat_avail(t,wat_src,j)) * s42_reserved_fraction;
vm_watdem.fx("electricity",j) = 0;
vm_watdem.fx("domestic",j) = 0;

*Environmental flow scenarios depending on the switch s42_env_flow_scenario
i42_env_flows_base(t,j) = s42_env_flow_base_fraction * sum(wat_src, im_wat_avail(t,wat_src,j));

if((s42_env_flow_scenario=0),
 i42_env_flows_base(t,j) = 0;
 i42_env_flows(t,j) = 0;
Elseif(s42_env_flow_scenario=1),
  i42_env_flows(t,j) = s42_env_flow_fraction * sum(wat_src, im_wat_avail(t,wat_src,j));
);

vm_watdem.fx("ecosystem",j) = sum(cell(i,j), i42_env_flows_base(t,j) * (1-ic42_env_flow_policy(i)) +
                                                          i42_env_flows(t,j) * ic42_env_flow_policy(i));


* irrigation efficiency
if(m_year(t) <= sm_fix_SSP2,
 v42_irrig_eff.fx(j) = s42_irrigation_efficiency;
else 
 if((s42_irrig_eff_scenario = 1),
 	v42_irrig_eff.fx(j) = s42_irrigation_efficiency;
 Elseif (s42_irrig_eff_scenario=2),
 	v42_irrig_eff.fx(j) = 1/(1+2.718282**((-22160-sum(cell(i,j),im_gdp_pc_mer("y1995",i)))/37767));
 Elseif (s42_irrig_eff_scenario=3),
	v42_irrig_eff.fx(j) = 1/(1+2.718282**((-22160-sum(cell(i,j),im_gdp_pc_mer(t,i)))/37767));
 );
);
