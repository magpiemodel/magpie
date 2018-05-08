*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

* ### nl_fix ###

vm_yld.fx(j,kcr,w) = sum(ct,i14_yields(ct,j,kcr,w))*sum(cell(i,j),vm_tau.l(i)/fm_tau1995(i));



*v14_ani_stocks.fx(i,sys) = sum((sys_to_kli(sys,kli)), vm_prod_reg.l(i,kli))/sum(ct,im_livestock_productivity(ct,i,sys));      

*v14_graz_ani.fx(i) = v14_ani_stocks.l(i,"sys_dairy") + v14_ani_stocks.l(i,"sys_beef");

*v14_incr_graz_ani.fx(i) = v14_graz_ani.l(i)/pc14_graz_ani(i);



vm_yld.fx(j,"pasture",w) = pc14_pyld(j,w) * (s14_pyld_intercept + s14_pyld_slope*1.1 );


                   


