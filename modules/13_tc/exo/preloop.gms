*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

loop(t,
 if(m_year(t) <= sm_fix_SSP2,
  i13_tc_factor(t) = f13_tc_factor(t,"medium");
  i13_tc_exponent(t) = f13_tc_exponent(t,"medium");
 else
  i13_tc_factor(t) = f13_tc_factor(t,"%c13_tccost%");
  i13_tc_exponent(t) = f13_tc_exponent(t,"%c13_tccost%");
 );
);

pcm_tau(h,"crop") = fm_tau1995(h);
pcm_tau(h,"pastr") = fm_pastr_tau_hist("y1995",h);
