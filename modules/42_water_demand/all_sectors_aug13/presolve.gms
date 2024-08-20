*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

* Agricultural water demand
ic42_wat_req_k(j,k) = i42_wat_req_k(t,j,k);

* Irrigation efficiency
if (m_year(t) <= sm_fix_SSP2,
 v42_irrig_eff.fx(j) = 1 / (1 + 2.718282**((-22160-sum(cell(i,j),im_gdp_pc_mer("y1995",i)))/37767));
else
 if ((s42_irrig_eff_scenario = 1),
  v42_irrig_eff.fx(j) = s42_irrigation_efficiency;
 Elseif (s42_irrig_eff_scenario = 2),
  v42_irrig_eff.fx(j) = 1 / (1 + 2.718282**((-22160-sum(cell(i,j),im_gdp_pc_mer("y1995",i)))/37767));
 Elseif (s42_irrig_eff_scenario = 3),
  v42_irrig_eff.fx(j) = 1 / (1 + 2.718282**((-22160-sum(cell(i,j),im_gdp_pc_mer(t,i)))/37767));
 );
);


* Pumping cost in the current time step
ic42_pumping_cost(i) = 0;

* Pumping cost settings will be only executed when s42_pumping is set to 1
if ((s42_pumping = 1),
 ic42_pumping_cost(i) = f42_pumping_cost(t,i);
* Pumping cost sensitivity test implmentation
  if(m_year(t) > s42_multiplier_startyear,
   ic42_pumping_cost(i) = f42_pumping_cost(t,i) * s42_multiplier;
  );
);


* Water withdrawals in manufacturing, electricity, domestic, ecosystem
* depend on the socioeconomic scenario
if (m_year(t) <= sm_fix_SSP2,
  vm_watdem.fx(watdem_ineldo,j) = f42_watdem_ineldo(t,j,"ssp2",watdem_ineldo,"withdrawal");
  i42_watdem_total(t,j,watdem_ineldo,wtype) = f42_watdem_ineldo_total(t,j,"ssp2",watdem_ineldo,wtype);
else
  if ((s42_watdem_nonagr_scenario = 1),
    vm_watdem.fx(watdem_ineldo,j) = f42_watdem_ineldo(t,j,"ssp1",watdem_ineldo,"withdrawal");
    i42_watdem_total(t,j,watdem_ineldo,wtype) = f42_watdem_ineldo_total(t,j,"ssp1",watdem_ineldo,wtype);
  Elseif (s42_watdem_nonagr_scenario = 2),
    vm_watdem.fx(watdem_ineldo,j) = f42_watdem_ineldo(t,j,"ssp2",watdem_ineldo,"withdrawal");
    i42_watdem_total(t,j,watdem_ineldo,wtype) = f42_watdem_ineldo_total(t,j,"ssp2",watdem_ineldo,wtype);
  Elseif (s42_watdem_nonagr_scenario = 3),
    vm_watdem.fx(watdem_ineldo,j) = f42_watdem_ineldo(t,j,"ssp3",watdem_ineldo,"withdrawal");
    i42_watdem_total(t,j,watdem_ineldo,wtype) = f42_watdem_ineldo_total(t,j,"ssp3",watdem_ineldo,wtype);
  );
);


* Environmental flow scenarios depending on the switch s42_env_flow_scenario
i42_env_flows_base(t,j) = s42_env_flow_base_fraction * sum(wat_src, im_wat_avail(t,wat_src,j));

if ((s42_env_flow_scenario = 0),
  i42_env_flows_base(t,j) = 0;
  i42_env_flows(t,j) = 0;
Elseif (s42_env_flow_scenario = 1),
  i42_env_flows(t,j) = s42_env_flow_fraction * sum(wat_src, im_wat_avail(t,wat_src,j));
);

* Country switch to determine countries for which EFP holds.
* In the default case, the EFP affects all countries when activated.
p42_country_dummy(iso) = 0;
p42_country_dummy(EFP_countries) = 1;
* Because MAgPIE is not run at country-level, but at region level, a region
* share is calculated that translates the countries' influence to regional level.
* Countries are weighted by their population size.
p42_EFP_region_shr(t_all,i) = sum(i_to_iso(i,iso), p42_country_dummy(iso) * im_pop_iso(t_all,iso)) / sum(i_to_iso(i,iso), im_pop_iso(t_all,iso));

* Environmental policy switch:
$ifthen "%c42_env_flow_policy%" == "mixed"
  i42_env_flow_policy(t,i) = (im_development_state(t,i) * p42_efp(t,"on")) * p42_EFP_region_shr(t,i)
                       + p42_efp(t,"off") * (1-p42_EFP_region_shr(t,i));
$else
  i42_env_flow_policy(t,i) = p42_efp(t,"%c42_env_flow_policy%") * p42_EFP_region_shr(t,i)
                       + p42_efp(t,"off") * (1-p42_EFP_region_shr(t,i));
$endif

ic42_env_flow_policy(i) = i42_env_flow_policy(t,i);

vm_watdem.fx("ecosystem",j) = sum(cell(i,j), i42_env_flows_base(t,j) * (1 - ic42_env_flow_policy(i)) +
                                             i42_env_flows(t,j) * ic42_env_flow_policy(i));
