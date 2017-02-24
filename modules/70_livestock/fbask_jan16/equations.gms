*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de



 q70_feed(i2,kap,kall) .. vm_dem_feed(i2,kap,kall)
                   =e=
                   vm_prod_reg(i2,kap)*sum(ct,f70_feed_baskets(ct,i2,kap,kall))
                   + sum(ct,f70_feed_balanceflow(ct,i2,kap,kall))
                   ;


* to be done: new productivity indicator required.
 q70_cost_prod_liv(i2,kli) ..  vm_cost_prod(i2,kli)
                            =e=
                            vm_prod_reg(i2,kli)*(
                               f70_cost_regr(kli,"cost_regr_a")
                               + f70_cost_regr(kli,"cost_regr_b") * sum(ct,f70_livestock_productivity(ct,i2,kli))
                            );