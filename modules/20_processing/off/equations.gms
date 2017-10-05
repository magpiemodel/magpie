*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

* add high costs for the production of all processing products to disincentivize overproduction
q20_processing_costs(i2) ..
        vm_cost_processing(i2)
        =e=
        sum(ksd, vm_prod_reg(i2,ksd) * 5000);