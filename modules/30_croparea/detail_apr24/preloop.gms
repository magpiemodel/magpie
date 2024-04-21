*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

** Trajectory for cropland scenarios
* sigmoidal interpolation between start year and target year
m_sigmoid_time_interpol(p30_rotation_scenario_fader,s30_rotation_scenario_start,s30_rotation_scenario_target,0,1);

** create crop rotation scenario
i30_rotation_rules(t_all,rota30) =
  f30_rotation_rules(rota30,"default") * (1-p30_rotation_scenario_fader(t_all)) +
  f30_rotation_rules(rota30,"%c30_rotation_rules%") * (p30_rotation_scenario_fader(t_all));

** create crop rotation scenario
i30_rotation_incentives(t_all,rota30) =
  f30_rotation_incentives(rota30,"default") * (1-p30_rotation_scenario_fader(t_all)) +
  f30_rotation_incentives(rota30,"%c30_rotation_incentives%") * (p30_rotation_scenario_fader(t_all));


*due to some rounding errors the input data currently may contain in some cases
*very small, negative numbers. These numbers have to be set to 0 as area
*cannot be smaller than 0!
fm_croparea(t_past,j,w,kcr)$(fm_croparea(t_past,j,w,kcr)<0) = 0;

if(s30_implementation = 1,
  v30_penalty.fx(j,rota30) = 0;
);
