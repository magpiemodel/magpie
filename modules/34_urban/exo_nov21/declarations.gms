*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

parameters
 i34_urban_area(t_all, j)  Cellular urban area
;

positive variables
 vm_cost_urban(j)          Technical adjustment costs
 v34_cost1(j)              Technical adjustment costs
 v34_cost2(j)              Technical adjustment costs
;

equations
 q34_urban_cell(j)         Constraint for urban land
 q34_urban_land(i)         Prescribe total regional urban land
 q34_urban_cost1(j)        Technical punishment equation
 q34_urban_cost2(j)        Technical punishment equation
 q34_bv_urban(j,potnatveg) Biodiversity value for urban land (Mha)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_cost_urban(t,j,type)           Technical adjustment costs
 ov34_cost1(t,j,type)              Technical adjustment costs
 ov34_cost2(t,j,type)              Technical adjustment costs
 oq34_urban_cell(t,j,type)         Constraint for urban land
 oq34_urban_land(t,i,type)         Prescribe total regional urban land
 oq34_urban_cost1(t,j,type)        Technical punishment equation
 oq34_urban_cost2(t,j,type)        Technical punishment equation
 oq34_bv_urban(t,j,potnatveg,type) Biodiversity value for urban land (Mha)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
