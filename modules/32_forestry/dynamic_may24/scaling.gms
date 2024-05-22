*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

v32_cost_establishment.scale(i) = 10e4;
v32_cost_recur.scale(i) = 10e4;
vm_cost_fore.scale(i) = 10e5;
v32_cost_hvarea.scale(i)$(s32_hvarea = 1 OR s32_hvarea = 2) = 10e4;
vm_cdr_aff.scale(j,ac,aff_effect) = 10e-4;
