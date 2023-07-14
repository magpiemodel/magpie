*** |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de



*define bound for peatland area
if (m_year(t) <= s58_fix_peatland,  
  v58_peatland.fx(j,land58) = pc58_peatland(j,land58);
  i58_cost_rewet_recur(t) = 0;
  i58_cost_rewet_onetime(t) = 0;
  i58_cost_degrad_recur(t) = 0;
  i58_cost_degrad_onetime(t) = 0;
else
  v58_peatland.lo(j,land58) = 0;
  v58_peatland.l(j,land58) = pc58_peatland(j,land58);
  v58_peatland.up(j,landMan58) = Inf;
  v58_peatland.up(j,"unused") = Inf;
  v58_peatland.up(j,"rewetted") = s58_rewetting_switch;
  v58_peatland.up(j,"intact") = pc58_peatland(j,"intact");
  v58_peatland.fx(j,"peatExtract") = pc58_peatland(j,"peatExtract");
  i58_cost_rewet_recur(t) = s58_cost_rewet_recur;
  i58_cost_rewet_onetime(t) = s58_cost_rewet_onetime;
  i58_cost_degrad_recur(t) = s58_cost_degrad_recur;
  i58_cost_degrad_onetime(t) = s58_cost_degrad_onetime;
);
