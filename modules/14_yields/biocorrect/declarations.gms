*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

parameters
****** Yields
 i14_yields(t,j,kve,w)           biophysical input yields (excluding technological change) (ton DM per ha)
;

positive variables
 vm_yld(j,kve,w)                           yields (variable because of technical change) (ton DM per ha)
;

equations
 q14_yield(j,kve,w)              yields
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_yld(t,j,kve,w,type)     yields (variable because of technical change) (ton DM per ha)
 oq14_yield(t,j,kve,w,type) yields
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
