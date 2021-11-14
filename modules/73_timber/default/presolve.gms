*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

** zero cost for balance variable in historic time steps in case of s73_timber_demand_switch = 0
i73_free_prod_costs(t)$(sum(sameas(t_past,t),1) = 1 AND s73_timber_demand_switch = 0) = 0;

** Current demand for establishment until 2020, after 2020 depending on s73_foresight
** s73_foresight=1 forward looking (establishment based on future demand),
** s73_foresight=0 myopic (establishment based on current demand)

if(m_year(t) <= sm_fix_SSP2,
*    pm_demand_forestry_future(i,kforestry)    = pm_demand_ext("y2010",i,kforestry)*1.5;
    pm_demand_forestry_future(i,kforestry)    = pm_demand_ext(t,i,kforestry);
else
 if(s73_foresight=1,
    pm_demand_forestry_future(i,kforestry)    = sum(t_ext$(t_ext.pos =  t.pos + pm_representative_rotation(t,i)),pm_demand_ext(t_ext,i,kforestry));
 else
 	pm_demand_forestry_future(i,kforestry)    = pm_demand_ext(t,i,kforestry);
 );
);
