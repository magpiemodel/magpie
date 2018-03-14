*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de


p38_croparea_investment(j,kcr) = v38_croparea_investment.l(j,kcr);


*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_cost_prod(t,i,kall,"marginal")                    = vm_cost_prod.m(i,kall);
 ov38_croparea_investment(t,j,kcr,"marginal")         = v38_croparea_investment.m(j,kcr);
 ov38_croparea_investment_annuity(t,i,kcr,"marginal") = v38_croparea_investment_annuity.m(i,kcr);
 oq38_cost_prod_crop(t,i,kcr,"marginal")              = q38_cost_prod_crop.m(i,kcr);
 oq38_croparea_investment(t,j,kcr,"marginal")         = q38_croparea_investment.m(j,kcr);
 oq38_croparea_investment_annuity(t,i,kcr,"marginal") = q38_croparea_investment_annuity.m(i,kcr);
 ov_cost_prod(t,i,kall,"level")                       = vm_cost_prod.l(i,kall);
 ov38_croparea_investment(t,j,kcr,"level")            = v38_croparea_investment.l(j,kcr);
 ov38_croparea_investment_annuity(t,i,kcr,"level")    = v38_croparea_investment_annuity.l(i,kcr);
 oq38_cost_prod_crop(t,i,kcr,"level")                 = q38_cost_prod_crop.l(i,kcr);
 oq38_croparea_investment(t,j,kcr,"level")            = q38_croparea_investment.l(j,kcr);
 oq38_croparea_investment_annuity(t,i,kcr,"level")    = q38_croparea_investment_annuity.l(i,kcr);
 ov_cost_prod(t,i,kall,"upper")                       = vm_cost_prod.up(i,kall);
 ov38_croparea_investment(t,j,kcr,"upper")            = v38_croparea_investment.up(j,kcr);
 ov38_croparea_investment_annuity(t,i,kcr,"upper")    = v38_croparea_investment_annuity.up(i,kcr);
 oq38_cost_prod_crop(t,i,kcr,"upper")                 = q38_cost_prod_crop.up(i,kcr);
 oq38_croparea_investment(t,j,kcr,"upper")            = q38_croparea_investment.up(j,kcr);
 oq38_croparea_investment_annuity(t,i,kcr,"upper")    = q38_croparea_investment_annuity.up(i,kcr);
 ov_cost_prod(t,i,kall,"lower")                       = vm_cost_prod.lo(i,kall);
 ov38_croparea_investment(t,j,kcr,"lower")            = v38_croparea_investment.lo(j,kcr);
 ov38_croparea_investment_annuity(t,i,kcr,"lower")    = v38_croparea_investment_annuity.lo(i,kcr);
 oq38_cost_prod_crop(t,i,kcr,"lower")                 = q38_cost_prod_crop.lo(i,kcr);
 oq38_croparea_investment(t,j,kcr,"lower")            = q38_croparea_investment.lo(j,kcr);
 oq38_croparea_investment_annuity(t,i,kcr,"lower")    = q38_croparea_investment_annuity.lo(i,kcr);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
