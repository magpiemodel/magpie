*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations
*' Cellular level land is prescribed via a very strong incentive not to deviate
*' from cellular input data. v34_cost1 and v34_cost2 are the cost variables that
*' implement this, for when vm_land(j2,"urban") is less than and greater than the input data
*'  i.e. when reducing or establishing more urban land than in input. This safeguards against infeasible outcomes,
*'  where urban land should expand but can not due to NPI or other protected land constraints. In this case it incurs the cost and shifts the land elsewhere in the region.



q34_urban_cost1(j2) ..
            v34_cost1(j2) =g= sum(ct, i34_urban_area(ct, j2)) - vm_land(j2,"urban");

q34_urban_cost2(j2) ..
            v34_cost2(j2) =g= vm_land(j2,"urban") - sum(ct, i34_urban_area(ct, j2));

*' Sum up cost terms with high punishment

q34_urban_cell(j2) ..
            vm_cost_urban(j2) =e= (v34_cost1(j2) + v34_cost2(j2)) *  s34_urban_deviation_cost;

*' Regional level urban land must match

q34_urban_land(i2) ..
            sum(cell(i2,j2), vm_land(j2,"urban")) =e= sum((ct,cell(i2,j2)), i34_urban_area(ct,j2));

*' Biodiversity value (BV)
 q34_bv_urban(j2,potnatveg) .. 
 vm_bv(j2,"urban", potnatveg) =e= vm_land(j2,"urban") * fm_bii_coeff("urban",potnatveg) * fm_luh2_side_layers(j2,potnatveg);
