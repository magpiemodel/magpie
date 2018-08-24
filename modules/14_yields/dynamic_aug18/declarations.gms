*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

parameters
 i14_yields(t,j,kve,w)               Biophysical input yields (excluding technological change) (tDM per ha per yr)
 p14_ani_stocks(t,i,sys)             Animal numbers for all time steps (stock for meat systems or producing animals for egg and dairy systems) (mio. animals per yr)
 p14_yields_LPJ_reg(t,i)             Regional average input yields aggregated from clusters with initial pasture area as weights (tDM per ha per yr)
 p14_pyield_corr(t,i)                Regional pasture management corection for historical time steps (1)
 pc14_past_mngmnt_factor(i)          Regional pasture management factor of previous time step (1)
 pc14_graz_ani(i)                    Grazing animals of previous time step (mio. animals per yr)
 pc14_dairy_cattle(i)                Dairy cattle of previous time step (mio. animals per yr)
 pc14_beef_cattle(i)                 Animal numbers based on the productivity of beef systems (mio. animals per yr)
;

positive variables
 vm_yld(j,kve,w)                     Yields (variable because of technical change) (tDM per ha per yr)
 v14_past_mngmnt_factor(i)           Pasture management factor (1)
 v14_ani_stocks(i,sys)               Animal numbers (stock for meat systems or producing animals for egg and dairy systems) (mio. animals per yr)
 v14_graz_ani(i)                     Grazing animals (mio. animals per yr)
 v14_incr_graz_ani(i)                Increase in grazing animals (1)
;

equations
 q14_yield_crop(j,kcr,w)             Crop yields (tDM per ha per yr)
 q14_past_mngmnt_factor(i)           Regional pasture management factor (1)
 q14_yield_past(j,w)                 Pasture yields (tDM per ha per yr)
 q14_animal_stocks(i,sys)            Regional animal numbers (mio. animals per yr)
 q14_grazing_animals(i)              Regional grazing animals (mio. animals per yr)
 q14_incr_graz_animals(i)            Regional increase in grazing animals (1)

;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_yld(t,j,kve,w,type)            Yields (variable because of technical change) (tDM per ha per yr)
 ov14_past_mngmnt_factor(t,i,type) Pasture management factor (1)
 ov14_ani_stocks(t,i,sys,type)     Animal numbers (stock for meat systems or producing animals for egg and dairy systems) (mio. animals per yr)
 ov14_graz_ani(t,i,type)           Grazing animals (mio. animals per yr)
 ov14_incr_graz_ani(t,i,type)      Increase in grazing animals (1)
 oq14_yield_crop(t,j,kcr,w,type)   Crop yields (tDM per ha per yr)
 oq14_past_mngmnt_factor(t,i,type) Regional pasture management factor (1)
 oq14_yield_past(t,j,w,type)       Pasture yields (tDM per ha per yr)
 oq14_animal_stocks(t,i,sys,type)  Regional animal numbers (mio. animals per yr)
 oq14_grazing_animals(t,i,type)    Regional grazing animals (mio. animals per yr)
 oq14_incr_graz_animals(t,i,type)  Regional increase in grazing animals (1)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
