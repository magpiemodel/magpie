*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @equations

q17_prod_cell_wood(j2)..
 vm_prod(j2,"wood")
 =n=
 vm_prod_cell_forestry(j2,"wood") + vm_prod_cell_natveg(j2,"wood");

 q17_prod_cell_woodfuel(j2)..
  vm_prod(j2,"woodfuel")
  =n=
  vm_prod_cell_forestry(j2,"woodfuel") + vm_prod_cell_natveg(j2,"woodfuel");

*' The equation above describes regional production of a MAgPIE timber commodity
*' `vm_prod_reg_cell_xx` as the cluster level production for `vm_prod` of the same commodity.

q17_prod_reg(i2,k) ..
vm_prod_reg(i2,k) =e= sum(cell(i2,j2), vm_prod(j2,k));

*' The equation above describes regional production of a MAgPIE plant commodity
*' `vm_prod_reg` as the sum of the cluster level production `vm_prod` of the
*' same commodity.
