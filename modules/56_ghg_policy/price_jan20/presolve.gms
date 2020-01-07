*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

***Fix C price driven afforestation to zero before 2020
if (m_year(t) <= 2020,
	pc56_c_price_induced_aff = 0;
else 
	pc56_c_price_induced_aff = s56_c_price_induced_aff;
);
