*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

* ### nl_solve ###

solve magpie USING nlp MINIMIZING vm_cost_glo;

p80_modelstat(t) = magpie.modelstat;
pm_modelstat = magpie.modelstat;

display "s80_obj_linear";
display s80_obj_linear;
display "vm_cost_glo.l";
display vm_cost_glo.l;
