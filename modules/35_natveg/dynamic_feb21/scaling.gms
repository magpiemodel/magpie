*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

v35_other_expansion.scale(j) = 10e-3;
v35_other_reduction.scale(j,ac) = 10e-3;
v35_secdforest_expansion.scale(j) = 10e-3;
v35_secdforest_reduction.scale(j,ac) = 10e-3;
v35_hvarea_other.scale(j,ac) = 10e-3;
vm_cost_hvarea_natveg.scale(i)$(s35_hvarea = 1 OR s35_hvarea = 2) = 10e4;
