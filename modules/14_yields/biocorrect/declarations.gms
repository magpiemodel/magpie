*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

parameters
****** Yields
 i14_yields(t,j,kve,w)       Biophysical input yields (excluding technological change) (tDM per ha per yr)
;

positive variables
 vm_yld(j,kve,w)             Yields (variable because of technical change) (tDM per ha per yr)
;

equations
 q14_yield_crop(j,kcr,w)    Crop yields (tDM per ha per yr)
 q14_yield_past(j,w)        Pasture yields (tDM per ha per yr)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_yld(t,j,kve,w,type)          Yields (variable because of technical change) (tDM per ha per yr)
 oq14_yield_crop(t,j,kcr,w,type) Crop yields (tDM per ha per yr)
 oq14_yield_past(t,j,w,type)     Pasture yields (tDM per ha per yr)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
