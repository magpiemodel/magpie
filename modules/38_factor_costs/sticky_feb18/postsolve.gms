*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*'@code  Capital update from the last investment
p38_capital_immobile(t+1,j,kcr)$(p38_capital_immobile(t,j,kcr) OR v38_investment_immobile.l(j,kcr)) = (p38_capital_immobile(t,j,kcr) + v38_investment_immobile.l(j,kcr))*(1-s38_depreciation_rate)**(m_year(t+1)-m_year(t));
p38_capital_mobile(t+1,j)$(p38_capital_mobile(t,j) OR v38_investment_mobile.l(j)) = (p38_capital_mobile(t,j) + v38_investment_mobile.l(j))*(1-s38_depreciation_rate)**(m_year(t+1)-m_year(t));

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_cost_prod(t,i,kall,"marginal")            = vm_cost_prod.m(i,kall);
 ov_cost_inv(t,i,"marginal")                  = vm_cost_inv.m(i);
 ov38_investment_immobile(t,j,kcr,"marginal") = v38_investment_immobile.m(j,kcr);
 ov38_investment_mobile(t,j,"marginal")       = v38_investment_mobile.m(j);
 ov38_capital_immobile(t,j,kcr,"marginal")    = v38_capital_immobile.m(j,kcr);
 ov38_capital_mobile(t,j,"marginal")          = v38_capital_mobile.m(j);
 oq38_cost_prod_crop(t,i,kcr,"marginal")      = q38_cost_prod_crop.m(i,kcr);
 oq38_cost_prod_inv(t,i,"marginal")           = q38_cost_prod_inv.m(i);
 oq38_investment_immobile(t,j,kcr,"marginal") = q38_investment_immobile.m(j,kcr);
 oq38_investment_mobile(t,j,"marginal")       = q38_investment_mobile.m(j);
 ov_cost_prod(t,i,kall,"level")               = vm_cost_prod.l(i,kall);
 ov_cost_inv(t,i,"level")                     = vm_cost_inv.l(i);
 ov38_investment_immobile(t,j,kcr,"level")    = v38_investment_immobile.l(j,kcr);
 ov38_investment_mobile(t,j,"level")          = v38_investment_mobile.l(j);
 ov38_capital_immobile(t,j,kcr,"level")       = v38_capital_immobile.l(j,kcr);
 ov38_capital_mobile(t,j,"level")             = v38_capital_mobile.l(j);
 oq38_cost_prod_crop(t,i,kcr,"level")         = q38_cost_prod_crop.l(i,kcr);
 oq38_cost_prod_inv(t,i,"level")              = q38_cost_prod_inv.l(i);
 oq38_investment_immobile(t,j,kcr,"level")    = q38_investment_immobile.l(j,kcr);
 oq38_investment_mobile(t,j,"level")          = q38_investment_mobile.l(j);
 ov_cost_prod(t,i,kall,"upper")               = vm_cost_prod.up(i,kall);
 ov_cost_inv(t,i,"upper")                     = vm_cost_inv.up(i);
 ov38_investment_immobile(t,j,kcr,"upper")    = v38_investment_immobile.up(j,kcr);
 ov38_investment_mobile(t,j,"upper")          = v38_investment_mobile.up(j);
 ov38_capital_immobile(t,j,kcr,"upper")       = v38_capital_immobile.up(j,kcr);
 ov38_capital_mobile(t,j,"upper")             = v38_capital_mobile.up(j);
 oq38_cost_prod_crop(t,i,kcr,"upper")         = q38_cost_prod_crop.up(i,kcr);
 oq38_cost_prod_inv(t,i,"upper")              = q38_cost_prod_inv.up(i);
 oq38_investment_immobile(t,j,kcr,"upper")    = q38_investment_immobile.up(j,kcr);
 oq38_investment_mobile(t,j,"upper")          = q38_investment_mobile.up(j);
 ov_cost_prod(t,i,kall,"lower")               = vm_cost_prod.lo(i,kall);
 ov_cost_inv(t,i,"lower")                     = vm_cost_inv.lo(i);
 ov38_investment_immobile(t,j,kcr,"lower")    = v38_investment_immobile.lo(j,kcr);
 ov38_investment_mobile(t,j,"lower")          = v38_investment_mobile.lo(j);
 ov38_capital_immobile(t,j,kcr,"lower")       = v38_capital_immobile.lo(j,kcr);
 ov38_capital_mobile(t,j,"lower")             = v38_capital_mobile.lo(j);
 oq38_cost_prod_crop(t,i,kcr,"lower")         = q38_cost_prod_crop.lo(i,kcr);
 oq38_cost_prod_inv(t,i,"lower")              = q38_cost_prod_inv.lo(i);
 oq38_investment_immobile(t,j,kcr,"lower")    = q38_investment_immobile.lo(j,kcr);
 oq38_investment_mobile(t,j,"lower")          = q38_investment_mobile.lo(j);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
