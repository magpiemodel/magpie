*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


i31_cost_grass_trans("range","pastr") = s31_cost_range_pastr;
i31_cost_grass_trans("pastr","range") = s31_cost_pastr_range;
i31_cost_grass_trans("pastr","pastr") = 0;
i31_cost_grass_trans("range","range") = 0;
