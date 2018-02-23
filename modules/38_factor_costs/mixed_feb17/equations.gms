*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de


 q38_cost_prod_crop(i2,kcr) .. vm_cost_prod(i2,kcr)
                            =e=
                            sum((cell(i2,j2), w), vm_area(j2,kcr,w)*f38_region_yield(i2,kcr)
                                                *vm_tau(i2)/fm_tau1995(i2)
                                                *f38_fac_req(kcr,w));

 
