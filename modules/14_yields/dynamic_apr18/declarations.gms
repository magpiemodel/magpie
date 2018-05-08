*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

parameters
****** Yields
 i14_yields(t,j,kve,w)            biophysical input yields (excluding technological change) (ton DM per ha)
 pc14_pyld(j,w)                   pasture yields of previous time step (ton DM per ha)
 pc14_graz_ani(i)                 grazing animals of previous time step (million animals)
 p14_ani_stocks(t,i,sys)            animal numbers for all time steps (stock for meat systems or producing animals for egg and dairy systems) (million animals)
 pc14_dairy_cattle(i)             dairy cattle of previous time step (million animals)
 pc14_beef_cattle(i)              animal numbers based on the productivity of beef systems (million animals)
;

positive variables
 vm_yld(j,kve,w)                  yields (variable because of technical change) (ton DM per ha)
 v14_ani_stocks(i,sys)            animal numbers (stock for meat systems or producing animals for egg and dairy systems) (million animals)
 v14_graz_ani(i)                  grazing animals (million animals)
 v14_incr_graz_ani(i)             increase in grazing animals (1)
;

equations
 q14_yield_crop(j,kcr,w)          crop yields
 q14_yield_past(j,w)              pasture yields
 q14_animal_stocks(i,sys)         regional animal numbers
 q14_grazing_animals(i)           regional grazing animals
 q14_incr_graz_animals(i)         regional increase in grazing animals (1)

;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_yld(t,j,kve,w,type)           yields (variable because of technical change) (ton DM per ha)
 ov14_ani_stocks(t,i,sys,type)    animal numbers (stock for meat systems or producing animals for egg and dairy systems) (million animals)
 ov14_graz_ani(t,i,type)          grazing animals (million animals)
 ov14_incr_graz_ani(t,i,type)     increase in grazing animals (1)
 oq14_yield_crop(t,j,kcr,w,type)  crop yields
 oq14_yield_past(t,j,w,type)      pasture yields
 oq14_animal_stocks(t,i,sys,type) regional animal numbers
 oq14_grazing_animals(t,i,type)   regional grazing animals
 oq14_incr_graz_animals(t,i,type) regional increase in grazing animals (1)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
