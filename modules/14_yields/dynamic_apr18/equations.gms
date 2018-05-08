*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

***CROP YIELD CALCULATIONS**********************************************
q14_yield_crop(j2,kcr,w) .. vm_yld(j2,kcr,w) =e=
                    sum(ct,i14_yields(ct,j2,kcr,w))*sum(cell(i2,j2),vm_tau(i2)/fm_tau1995(i2));


***PASTURE YIELD CALCULATIONS*******************************************
q14_yield_past(j2,w) .. vm_yld(j2,"pasture",w) =e=
                    pc14_pyld(j2,w) * (s14_pyld_intercept + s14_pyld_slope*sum(cell(i2,j2),v14_incr_graz_ani(i2)) );


                   
*q14_animal_stocks(i2,sys) .. v14_ani_stocks(i2,sys) =e=
*                   sum((sys_to_kli(sys,kli)), vm_prod_reg(i2,kli))/sum(ct,im_livestock_productivity(ct,i2,sys));   

q14_animal_stocks(i2,sys) .. v14_ani_stocks(i2,sys) =e=
                   sum((sys_to_kli(sys,kli)), vm_supply(i2,kli))/sum(ct,im_livestock_productivity(ct,i2,sys));   


q14_grazing_animals(i2) .. v14_graz_ani(i2) =e= v14_ani_stocks(i2,"sys_beef");

   

*q14_grazing_animals(i2) .. v14_graz_ani(i2) =e= v14_ani_stocks(i2,"sys_beef")$(pc14_beef_cattle(i2)-pc14_dairy_cattle(i2)>0)
*						+ v14_ani_stocks(i2,"sys_dairy")$(pc14_dairy_cattle(i2)-pc14_beef_cattle(i2)>0);
*


q14_incr_graz_animals(i2) .. v14_incr_graz_ani(i2)  =e=  
				v14_graz_ani(i2)/pc14_beef_cattle(i2);

