*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @equations

***CROP YIELD CALCULATIONS**********************************************
q14_yield_crop(j2,kcr,w) .. 
 vm_yld(j2,kcr,w) =e= sum(ct,i14_yields(ct,j2,kcr,w))*sum(cell(i2,j2),vm_tau(i2)/fm_tau1995(i2));


***PASTURE YIELD CALCULATIONS*******************************************
*' In contrast to the [biocorrect] realization, pasture yields are not linked to yield increases
*' in the crop sector, but to the increase in the number of grazing animals in this realization.
*' 
*' Pasture yields are calculated using a linear function that depends on the increase of grazing animals: 
q14_yield_past(j2,w) ..
 vm_yld(j2,"pasture",w) =e= sum(  (ct,t2),
                (pc14_pyld(j2,w)$(ord(t2)=1)
                +(pc14_pyld(j2,w)*(s14_pyld_intercept + sum(cell(i2,j2),f14_pyld_slope_reg(i2)
                *v14_incr_graz_ani(i2)**(5/(m_year(t2)-m_year(t2-1))) ))**((m_year(t2)-m_year(t2-1))/5) )$(ord(t2)>1)
                )$sameas(ct,t2) );

*' The increase of grazing animals is derived from the following three equations.
*'
*' (1) Animal stocks are calculated based on the productivity indicators. For the milk and the egg systems,
*' animal numbers refer to producing animals. For the meat systems, animal numbers refer to the respective animal herd: 
q14_animal_stocks(i2,sys) ..
 v14_ani_stocks(i2,sys) =e=
                   sum((sys_to_kli(sys,kli)), vm_supply(i2,kli))/sum(ct,im_livestock_productivity(ct,i2,sys));   
 				   
*' (2) Grazing animals are defined by the cattle stock:
q14_grazing_animals(i2) .. 
 v14_graz_ani(i2) =e= v14_ani_stocks(i2,"sys_beef");

*' (3) The increase of grazing animals is calculated using the previous time step:
q14_incr_graz_animals(i2) ..
 v14_incr_graz_ani(i2)  =e=  
				v14_graz_ani(i2)/pc14_beef_cattle(i2);



    
               
  






