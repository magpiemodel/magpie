*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de


 q38_cost_prod_crop(i2,kcr) ..
  vm_cost_prod(i2,kcr) =e= vm_prod_reg(i2,kcr)*f38_fac_req_per_ton(kcr)*0.66
                            + v38_croparea_investment_annuity(i2,kcr)
                            ;

 q38_croparea_investment(j2,kcr) ..
   v38_croparea_investment(j2,kcr) =g= sum((w,cell(i2,j2)), vm_area(j2,kcr,w) * i38_capital_requirement(i2,kcr) * vm_tau(i2))
                                       - sum(ct, p38_croparea_preexisting_capital(ct,j2,kcr))
                            ;

 q38_croparea_investment_annuity(i2,kcr) ..
   v38_croparea_investment_annuity(i2,kcr) =e= sum((cell(i2,j2)), v38_croparea_investment(j2,kcr)
                          )*pm_interest(i2)/(1+pm_interest(i2))
                          ;
