*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

p16_volumetric_conversion("wood") = 632.5;
p16_volumetric_conversion("woodfuel") = 307.1;

fm_forestry_demand(t_all,i,"wood") =
										sum(i_to_iso(i,iso),
										m_yeardiff(t_all)
                  * f16_forestry_demand_iso(t_all,iso,"wood")
									* 1000/p16_volumetric_conversion("wood"));

fm_forestry_demand(t_all,i,"woodfuel") =
										sum(i_to_iso(i,iso),
					 					m_yeardiff(t_all)
                  * f16_forestry_demand_iso(t_all,iso,"woodfuel")
				 					* 1000/p16_volumetric_conversion("woodfuel")) * 0.50;

* Setting MEA demand to 10% of calculated demand for testing purposes
fm_forestry_demand(t_all,"MEA",kforestry) = fm_forestry_demand(t_all,"MEA",kforestry) * 0.10 ;
