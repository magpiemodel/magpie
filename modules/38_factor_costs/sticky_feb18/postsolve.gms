*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' Capital update from the last investment
p38_capital_immobile(t+1,j,kcr) = p38_capital_immobile(t,j,kcr) + v38_investment_immobile.l(j,kcr);
p38_capital_mobile(t+1,j) = p38_capital_mobile(t,j) + v38_investment_mobile.l(j);


*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_cost_prod_crop(t,i,factors,"marginal")    = vm_cost_prod_crop.m(i,factors);
 ov38_investment_immobile(t,j,kcr,"marginal") = v38_investment_immobile.m(j,kcr);
 ov38_investment_mobile(t,j,"marginal")       = v38_investment_mobile.m(j);
 oq38_cost_prod_labor(t,i,"marginal")         = q38_cost_prod_labor.m(i);
 oq38_cost_prod_capital(t,i,"marginal")       = q38_cost_prod_capital.m(i);
 oq38_investment_immobile(t,j,kcr,"marginal") = q38_investment_immobile.m(j,kcr);
 oq38_investment_mobile(t,j,"marginal")       = q38_investment_mobile.m(j);
 ov_cost_prod_crop(t,i,factors,"level")       = vm_cost_prod_crop.l(i,factors);
 ov38_investment_immobile(t,j,kcr,"level")    = v38_investment_immobile.l(j,kcr);
 ov38_investment_mobile(t,j,"level")          = v38_investment_mobile.l(j);
 oq38_cost_prod_labor(t,i,"level")            = q38_cost_prod_labor.l(i);
 oq38_cost_prod_capital(t,i,"level")          = q38_cost_prod_capital.l(i);
 oq38_investment_immobile(t,j,kcr,"level")    = q38_investment_immobile.l(j,kcr);
 oq38_investment_mobile(t,j,"level")          = q38_investment_mobile.l(j);
 ov_cost_prod_crop(t,i,factors,"upper")       = vm_cost_prod_crop.up(i,factors);
 ov38_investment_immobile(t,j,kcr,"upper")    = v38_investment_immobile.up(j,kcr);
 ov38_investment_mobile(t,j,"upper")          = v38_investment_mobile.up(j);
 oq38_cost_prod_labor(t,i,"upper")            = q38_cost_prod_labor.up(i);
 oq38_cost_prod_capital(t,i,"upper")          = q38_cost_prod_capital.up(i);
 oq38_investment_immobile(t,j,kcr,"upper")    = q38_investment_immobile.up(j,kcr);
 oq38_investment_mobile(t,j,"upper")          = q38_investment_mobile.up(j);
 ov_cost_prod_crop(t,i,factors,"lower")       = vm_cost_prod_crop.lo(i,factors);
 ov38_investment_immobile(t,j,kcr,"lower")    = v38_investment_immobile.lo(j,kcr);
 ov38_investment_mobile(t,j,"lower")          = v38_investment_mobile.lo(j);
 oq38_cost_prod_labor(t,i,"lower")            = q38_cost_prod_labor.lo(i);
 oq38_cost_prod_capital(t,i,"lower")          = q38_cost_prod_capital.lo(i);
 oq38_investment_immobile(t,j,kcr,"lower")    = q38_investment_immobile.lo(j,kcr);
 oq38_investment_mobile(t,j,"lower")          = q38_investment_mobile.lo(j);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
