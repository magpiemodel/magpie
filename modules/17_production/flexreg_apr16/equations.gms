*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

q17_prod_reg(i2,k) .. vm_prod_reg(i2,k)
                  =e=
                     sum(cell(i2,j2), vm_prod(j2,k));
