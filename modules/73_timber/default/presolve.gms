*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' Sticky natveg harvest-capacity cost (see input.gms / equations.gms).

*' Map the per-source intensity switches into a land_natveg-indexed parameter (config can only set
*' scalars). Higher intensity = stronger temporal damping of that source's harvest ramps.
p73_hvcapital_intensity("primforest") = s73_hvint_primf;
p73_hvcapital_intensity("secdforest") = s73_hvint_secdf;
p73_hvcapital_intensity("other")      = s73_hvint_other;

*' Capital required per unit of natveg timber production: the natveg per-tDM harvest cost,
*' scaled by the per-source intensity and capitalized by dividing by (interest + depreciation),
*' analogously to the sticky cost in module 38.
p73_hvcapital_need(t,i,land_natveg) = p73_hvcapital_intensity(land_natveg) * i73_timber_prod_cost_natveg(i,"wood")
                          / (pm_interest(t,i) + s73_hvcapital_depreciation);

*' Active from the second timestep (ord(t)>1) when on; no sm_fix_SSP2 gate (a scenario-invariant cost feature,
*' like the sticky cost in module 38). The ord(t)=1 step seeds the capital via the postsolve warm-start.
p73_sticky_active(t) = s73_sticky_harvest$(ord(t) > 1);

*' Depreciate the capital stock carried from the previous timestep (the stock at ord(t)=1 is zero).
if (ord(t) > 1,
  p73_hvcapital(t,j,land_natveg) = p73_hvcapital(t,j,land_natveg)
                                   * (1-s73_hvcapital_depreciation)**(m_timestep_length);
);
