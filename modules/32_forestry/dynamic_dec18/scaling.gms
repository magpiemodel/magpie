*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

vm_cost_fore.scale(i) = 10e6;
v32_yield_forestry_ac.scale(j,ac_sub) = 10e3;
v32_management_incr_cost.scale(i) = 10e12;
v32_cost_establishment.scale(i) = 10e6;
v32_hvarea_forestry.scale(j,kforestry,ac_sub) = 10e-3;
v32_management_incr_cost.scale(i) = 10e6;
v35_hvarea_secdforest.scale(j,kforestry,ac_sub) = 10e-3;
vm_cost_trade_forestry_ff.scale(i) = 10e3;               
vm_landdiff_forestry.scale = 10e3;                       
vm_landdiff_natveg.scale = 10e4;                        
