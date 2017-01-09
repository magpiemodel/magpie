*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

vm_cost_glo.scale = 10e6;
vm_cost_reg.scale(i) = 10e5;
vm_tech_cost.scale(i) = 10e4;
vm_cost_prod.scale(i,k) = 10e4;
vm_cost_transp.scale(j,k) = 10e3;
vm_watdem.scale(wat_dem,j) = 10e4;
vm_nr_inorg_fert_costs.scale(i) = 10e4;
vm_carbon_stock.scale(j,land,c_pools) = 10e3;
vm_cost_fore.scale(i) = 10e4;
vm_emission_costs.scale(i) = 10e4;
vm_maccs_costs.scale(i) = 10e4;
