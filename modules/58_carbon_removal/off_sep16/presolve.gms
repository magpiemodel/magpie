*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

*fix BECCS emissions to 0
vm_btm_reg.fx(i,"beccs",pollutants) = 0;

*fix CDR costs to 0
vm_cost_cdr.fx(i) = 0;