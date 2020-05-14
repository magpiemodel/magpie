*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

* postsolve costs

p38_ovcosts(t,i,kcr)   = vm_cost_prod.l(i,kcr)-p38_past_annuity(i,kcr);
p38_accum_ann(t,i,kcr) = p38_past_annuity(i,kcr)+v38_investment_annuity.l(i,kcr);
p38_past_annuity(i,kcr)= p38_past_annuity(i,kcr)+v38_investment_annuity.l(i,kcr);

*Capital update from the last investment
p38_capital(t+1,j,kcr,mobil38) = v38_capital.l(j,kcr,mobil38) + v38_investment.l(j,kcr,mobil38);

* Timestep length matters unfortunately.
* The model can make larger changes if larger parts of the capital stock are depreciated.
*p38_croparea_preexisting_capital(t,j,kcr) = p38_croparea_preexisting_capital(t,j,kcr) * (1-s38_depreciation_rate)**m_yeardiff(t+1);

* An option to avoid this is to assume that capital stocks are restocked in the timesteps which were not considered
* and just to simulate a yearly timestep or a smaller timestep instead.
* Here we assume a five year timestep, assuming farmers can delay investments by s38_investment_flexibility years.
p38_capital(t+1,j,kcr,mobil38) = p38_capital(t+1,j,kcr,mobil38) * (1-s38_depreciation_rate)**s38_investment_flexibility;
p38_capital_intensity(t+1,j,kcr) = p38_capital(t+1,j,kcr,"immobile") /(vm_prod.l(j,kcr)+0.00001);

* to keep track of areas
p38_past_area(j,kcr)=sum(w,vm_area.l(j,kcr,w));


*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_cost_prod(t,i,kall,"marginal")            = vm_cost_prod.m(i,kall);
 ov38_investment(t,j,kcr,mobil38,"marginal")  = v38_investment.m(j,kcr,mobil38);
 ov38_investment_annuity(t,i,kcr,"marginal")  = v38_investment_annuity.m(i,kcr);
 ov38_mi(t,i,"marginal")                      = v38_mi.m(i);
 ov38_capital(t,j,kcr,mobil38,"marginal")     = v38_capital.m(j,kcr,mobil38);
 ov38_crop_change(t,j,kcr,"marginal")         = v38_crop_change.m(j,kcr);
 oq38_cost_prod_crop(t,i,kcr,"marginal")      = q38_cost_prod_crop.m(i,kcr);
 oq38_investment(t,j,kcr,mobil38,"marginal")  = q38_investment.m(j,kcr,mobil38);
 oq38_investment_immobile(t,j,kcr,"marginal") = q38_investment_immobile.m(j,kcr);
 oq38_investment_annuity(t,i,kcr,"marginal")  = q38_investment_annuity.m(i,kcr);
 oq38_capital_relocation(t,j,"marginal")      = q38_capital_relocation.m(j);
 oq38_capital_sunk(t,j,kcr,"marginal")        = q38_capital_sunk.m(j,kcr);
 oq38_crop_change(t,j,kcr,"marginal")         = q38_crop_change.m(j,kcr);
 ov_cost_prod(t,i,kall,"level")               = vm_cost_prod.l(i,kall);
 ov38_investment(t,j,kcr,mobil38,"level")     = v38_investment.l(j,kcr,mobil38);
 ov38_investment_annuity(t,i,kcr,"level")     = v38_investment_annuity.l(i,kcr);
 ov38_mi(t,i,"level")                         = v38_mi.l(i);
 ov38_capital(t,j,kcr,mobil38,"level")        = v38_capital.l(j,kcr,mobil38);
 ov38_crop_change(t,j,kcr,"level")            = v38_crop_change.l(j,kcr);
 oq38_cost_prod_crop(t,i,kcr,"level")         = q38_cost_prod_crop.l(i,kcr);
 oq38_investment(t,j,kcr,mobil38,"level")     = q38_investment.l(j,kcr,mobil38);
 oq38_investment_immobile(t,j,kcr,"level")    = q38_investment_immobile.l(j,kcr);
 oq38_investment_annuity(t,i,kcr,"level")     = q38_investment_annuity.l(i,kcr);
 oq38_capital_relocation(t,j,"level")         = q38_capital_relocation.l(j);
 oq38_capital_sunk(t,j,kcr,"level")           = q38_capital_sunk.l(j,kcr);
 oq38_crop_change(t,j,kcr,"level")            = q38_crop_change.l(j,kcr);
 ov_cost_prod(t,i,kall,"upper")               = vm_cost_prod.up(i,kall);
 ov38_investment(t,j,kcr,mobil38,"upper")     = v38_investment.up(j,kcr,mobil38);
 ov38_investment_annuity(t,i,kcr,"upper")     = v38_investment_annuity.up(i,kcr);
 ov38_mi(t,i,"upper")                         = v38_mi.up(i);
 ov38_capital(t,j,kcr,mobil38,"upper")        = v38_capital.up(j,kcr,mobil38);
 ov38_crop_change(t,j,kcr,"upper")            = v38_crop_change.up(j,kcr);
 oq38_cost_prod_crop(t,i,kcr,"upper")         = q38_cost_prod_crop.up(i,kcr);
 oq38_investment(t,j,kcr,mobil38,"upper")     = q38_investment.up(j,kcr,mobil38);
 oq38_investment_immobile(t,j,kcr,"upper")    = q38_investment_immobile.up(j,kcr);
 oq38_investment_annuity(t,i,kcr,"upper")     = q38_investment_annuity.up(i,kcr);
 oq38_capital_relocation(t,j,"upper")         = q38_capital_relocation.up(j);
 oq38_capital_sunk(t,j,kcr,"upper")           = q38_capital_sunk.up(j,kcr);
 oq38_crop_change(t,j,kcr,"upper")            = q38_crop_change.up(j,kcr);
 ov_cost_prod(t,i,kall,"lower")               = vm_cost_prod.lo(i,kall);
 ov38_investment(t,j,kcr,mobil38,"lower")     = v38_investment.lo(j,kcr,mobil38);
 ov38_investment_annuity(t,i,kcr,"lower")     = v38_investment_annuity.lo(i,kcr);
 ov38_mi(t,i,"lower")                         = v38_mi.lo(i);
 ov38_capital(t,j,kcr,mobil38,"lower")        = v38_capital.lo(j,kcr,mobil38);
 ov38_crop_change(t,j,kcr,"lower")            = v38_crop_change.lo(j,kcr);
 oq38_cost_prod_crop(t,i,kcr,"lower")         = q38_cost_prod_crop.lo(i,kcr);
 oq38_investment(t,j,kcr,mobil38,"lower")     = q38_investment.lo(j,kcr,mobil38);
 oq38_investment_immobile(t,j,kcr,"lower")    = q38_investment_immobile.lo(j,kcr);
 oq38_investment_annuity(t,i,kcr,"lower")     = q38_investment_annuity.lo(i,kcr);
 oq38_capital_relocation(t,j,"lower")         = q38_capital_relocation.lo(j);
 oq38_capital_sunk(t,j,kcr,"lower")           = q38_capital_sunk.lo(j,kcr);
 oq38_crop_change(t,j,kcr,"lower")            = q38_crop_change.lo(j,kcr);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
