*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

if(m_year(t) >= s44_bii_start_year,
	if(s44_bii_mode = 0 AND s44_bii_change_annual <> -Inf,
		v44_bii_glo.lo = min(v44_bii_glo.l * (1 + s44_bii_change_annual * m_timestep_length),s44_bii_max_lower_bound);
	elseif s44_bii_mode = 1 AND s44_bii_change_annual <> -Inf,
		v44_bii_reg.lo(i) = min(v44_bii_reg.l(i) * (1 + s44_bii_change_annual * m_timestep_length),s44_bii_max_lower_bound);
	elseif s44_bii_mode = 2 AND s44_bii_change_annual <> -Inf,
		v44_bii_cell.lo(j) = min(v44_bii_cell.l(j) * (1 + s44_bii_change_annual * m_timestep_length),s44_bii_max_lower_bound);
	elseif s44_bii_mode = 3 AND s44_bii_change_annual <> -Inf,
		p44_bii_realm_target(t,realm)$(sum(j, f44_realm(j,realm)) > 0) = min(v44_bii_realm.l(realm) * (1 + s44_bii_change_annual * m_timestep_length),s44_bii_max_lower_bound);
		p44_bii_realm_target(t_all,"PA11") = 0;
		p44_bii_realm_target(t_all,"NA99") = 0;

	);
);

$ontext
if(m_year(t) = s44_bii_start_year,
	p44_bii_realm_target(t_all,realm)$(m_year(t_all) < s44_bii_start_year) = 0;
	p44_bii_realm_target(t_all,realm)$(m_year(t_all) >= s44_bii_start_year AND m_year(t_all) <= s44_bii_target_year AND s44_bii_target_value > v44_bii_realm.l(realm)) = 
	v44_bii_realm.l(realm) + ((m_year(t_all)-s44_bii_start_year) / (s44_bii_target_year-s44_bii_start_year)) * (s44_bii_target_value-v44_bii_realm.l(realm));	
	p44_bii_realm_target(t_all,realm)$(m_year(t_all) > s44_bii_target_year) = max(v44_bii_realm.l(realm),s44_bii_target_value);
);
$offtext



display v44_bii_glo.lo;
display v44_bii_reg.lo;
display v44_bii_cell.lo;
display p44_bii_realm_target;
