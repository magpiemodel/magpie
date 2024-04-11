*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

* get the scenario GDP & Populaiton data for iso countries
loop(t_all,
 if(m_year(t_all) <= sm_fix_SSP2,
  i34_urban_area(t_all, j) = f34_urbanland(t_all, j,"SSP2");
else
i34_urban_area(t_all, j) = f34_urbanland(t_all, j,"%c34_urban_scenario%");
 );
);

pcm_land(j,"urban") = i34_urban_area("y1995",j);
