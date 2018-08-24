*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de


*pc14_pyld(j,w) = vm_yld.l(j,"pasture",w); 

pc14_past_mngmnt_factor(i) = v14_past_mngmnt_factor.l(i);

p14_ani_stocks(t,i,sys) = v14_ani_stocks.l(i,sys);
pc14_dairy_cattle(i) = p14_ani_stocks(t,i,"sys_dairy");
pc14_beef_cattle(i) = p14_ani_stocks(t,i,"sys_beef");

pc14_graz_ani(i) = v14_graz_ani.l(i);




*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_yld(t,j,kve,w,"marginal")            = vm_yld.m(j,kve,w);
 ov14_past_mngmnt_factor(t,i,"marginal") = v14_past_mngmnt_factor.m(i);
 ov14_ani_stocks(t,i,sys,"marginal")     = v14_ani_stocks.m(i,sys);
 ov14_graz_ani(t,i,"marginal")           = v14_graz_ani.m(i);
 ov14_incr_graz_ani(t,i,"marginal")      = v14_incr_graz_ani.m(i);
 oq14_yield_crop(t,j,kcr,w,"marginal")   = q14_yield_crop.m(j,kcr,w);
 oq14_past_mngmnt_factor(t,i,"marginal") = q14_past_mngmnt_factor.m(i);
 oq14_yield_past(t,j,w,"marginal")       = q14_yield_past.m(j,w);
 oq14_animal_stocks(t,i,sys,"marginal")  = q14_animal_stocks.m(i,sys);
 oq14_grazing_animals(t,i,"marginal")    = q14_grazing_animals.m(i);
 oq14_incr_graz_animals(t,i,"marginal")  = q14_incr_graz_animals.m(i);
 ov_yld(t,j,kve,w,"level")               = vm_yld.l(j,kve,w);
 ov14_past_mngmnt_factor(t,i,"level")    = v14_past_mngmnt_factor.l(i);
 ov14_ani_stocks(t,i,sys,"level")        = v14_ani_stocks.l(i,sys);
 ov14_graz_ani(t,i,"level")              = v14_graz_ani.l(i);
 ov14_incr_graz_ani(t,i,"level")         = v14_incr_graz_ani.l(i);
 oq14_yield_crop(t,j,kcr,w,"level")      = q14_yield_crop.l(j,kcr,w);
 oq14_past_mngmnt_factor(t,i,"level")    = q14_past_mngmnt_factor.l(i);
 oq14_yield_past(t,j,w,"level")          = q14_yield_past.l(j,w);
 oq14_animal_stocks(t,i,sys,"level")     = q14_animal_stocks.l(i,sys);
 oq14_grazing_animals(t,i,"level")       = q14_grazing_animals.l(i);
 oq14_incr_graz_animals(t,i,"level")     = q14_incr_graz_animals.l(i);
 ov_yld(t,j,kve,w,"upper")               = vm_yld.up(j,kve,w);
 ov14_past_mngmnt_factor(t,i,"upper")    = v14_past_mngmnt_factor.up(i);
 ov14_ani_stocks(t,i,sys,"upper")        = v14_ani_stocks.up(i,sys);
 ov14_graz_ani(t,i,"upper")              = v14_graz_ani.up(i);
 ov14_incr_graz_ani(t,i,"upper")         = v14_incr_graz_ani.up(i);
 oq14_yield_crop(t,j,kcr,w,"upper")      = q14_yield_crop.up(j,kcr,w);
 oq14_past_mngmnt_factor(t,i,"upper")    = q14_past_mngmnt_factor.up(i);
 oq14_yield_past(t,j,w,"upper")          = q14_yield_past.up(j,w);
 oq14_animal_stocks(t,i,sys,"upper")     = q14_animal_stocks.up(i,sys);
 oq14_grazing_animals(t,i,"upper")       = q14_grazing_animals.up(i);
 oq14_incr_graz_animals(t,i,"upper")     = q14_incr_graz_animals.up(i);
 ov_yld(t,j,kve,w,"lower")               = vm_yld.lo(j,kve,w);
 ov14_past_mngmnt_factor(t,i,"lower")    = v14_past_mngmnt_factor.lo(i);
 ov14_ani_stocks(t,i,sys,"lower")        = v14_ani_stocks.lo(i,sys);
 ov14_graz_ani(t,i,"lower")              = v14_graz_ani.lo(i);
 ov14_incr_graz_ani(t,i,"lower")         = v14_incr_graz_ani.lo(i);
 oq14_yield_crop(t,j,kcr,w,"lower")      = q14_yield_crop.lo(j,kcr,w);
 oq14_past_mngmnt_factor(t,i,"lower")    = q14_past_mngmnt_factor.lo(i);
 oq14_yield_past(t,j,w,"lower")          = q14_yield_past.lo(j,w);
 oq14_animal_stocks(t,i,sys,"lower")     = q14_animal_stocks.lo(i,sys);
 oq14_grazing_animals(t,i,"lower")       = q14_grazing_animals.lo(i);
 oq14_incr_graz_animals(t,i,"lower")     = q14_incr_graz_animals.lo(i);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################

