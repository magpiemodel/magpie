*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

v21_self_suff.fx(i,k_trade) = f21_self_suff(t,i,k_trade);
if(m_year(t) <= 2020,
 v21_self_suff.fx(i,"wood") = f21_self_suff(t,i,"wood");
 v21_self_suff.fx(i,"woodfuel") = f21_self_suff(t,i,"woodfuel");
else 
 v21_self_suff.up(i,"wood") = f21_self_suff(t,i,"wood");
 v21_self_suff.l(i,"wood") = f21_self_suff(t,i,"wood");
 v21_self_suff.lo(i,"wood") = 0;
 v21_self_suff.up(i,"woodfuel") = f21_self_suff(t,i,"woodfuel");
 v21_self_suff.l(i,"woodfuel") = f21_self_suff(t,i,"woodfuel");
 v21_self_suff.lo(i,"woodfuel") = 0;
);