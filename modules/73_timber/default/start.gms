*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

** "PR" from SI of Galina's paper
p73_dem_scen("BAU")  = 0.005;
p73_dem_scen("10pc") = 0.1;
p73_dem_scen("50pc") = 0.5;
p73_dem_scen("90pc") = 0.9;

p73_urban_share(t_all,i) = 0;
p73_urban_share("y2010","CAZ") = 0.681;
p73_urban_share("y2010","CHA") = 0.448;
p73_urban_share("y2010","EUR") = 0.729;
p73_urban_share("y2010","IND") = 0.448;
p73_urban_share("y2010","JPN") = 0.448;
p73_urban_share("y2010","LAM") = 0.786;
p73_urban_share("y2010","MEA") = 0.448;
p73_urban_share("y2010","NEU") = 0.729;
p73_urban_share("y2010","OAS") = 0.448;
p73_urban_share("y2010","REF") = 0.448;
p73_urban_share("y2010","SSA") = 0.389;
p73_urban_share("y2010","USA") = 0.808;

loop (t_all$(m_year(t_all)<2010),
 p73_urban_share(t_all,i) = p73_urban_share("y2010",i) ;
);

loop (t_all,
 p73_urban_share(t_all+1,i) = p73_urban_share(t_all,i) + 0.02
);

** Crudely calculate MtDM/yr demand for 2020-2050 from Galina et al 2020
** After harvest löss accounting, buildings will create an additiona demand
** of
** BAU 0.002867864
** 10pc 0.057357277
** 50pc 0.286786385
** 90pc 0.516215493
** in GtC/yr. (See fig.4 and SI table 10 col 8 (or4?))
** GtC is converted to MtDM by multiplying with 2 (C to DM) and 1000 (Gt to Mt)
** These values can be added to already calculated wood demand
** for 2050-2100 time, we can keep this demand 1.5 times higher

*p73_crude_build_demand("BAU")  = 6;
*p73_crude_build_demand("10pc") = 115;
*p73_crude_build_demand("50pc") = 575;
*p73_crude_build_demand("90pc") = 1035;

** Demand increase over 35 years total
p73_crude_build_demand("BAU")  = 200;
p73_crude_build_demand("10pc") = 4015;
p73_crude_build_demand("50pc") = 20000;
p73_crude_build_demand("90pc") = 36135;

** Multiply with 2 assuming needed demand in 2020-2050 is repreated in 2050-2100
p73_crude_build_demand(build_scen) = p73_crude_build_demand(build_scen) * 2;
