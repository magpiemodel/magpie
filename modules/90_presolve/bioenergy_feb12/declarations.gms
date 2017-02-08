*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

scalars
 sm_use_bioenergy           switch to deactivate bioenergy use (needed for presolve module) / 1 /
;

parameters
 o90_cost_glo(t)                      total cost of production [magpie_pre] (mio. US$)
 o90_cost_reg(t,i)                    regional cost of production [magpie_pre] (mio. US$)
 o90_emissions_reg(t,i,emis_source,pollutants)    regional emissions (Tg N2O-N CH4 and CO2-C)
 p90_modelstat(t)                     model status of presolve  (-)
 o90_tech_cost(t,i)            price for technological change [magpie_pre] (mio. US$)
 o90_cost_prod(t,i,k)          factor costs [magpie_pre] (mio. US$)
 o90_cost_transp(t,j,k)        transportation costs [magpie_pre] (mio. US$)
 o90_cost_landcon(t,j,land)    landconversion costs [magpie_pre] (mio. US$)
 o90_maccs_costs(t,i)          macc mitigation costs [magpie_pre] (mio US$)
 o90_emission_costs(t,i)       Costs for emission pollution rights [magpie_pre] (mio. US$)
 o90_land(t,j,land,si)         Areas of the different land types [magpie_pre] (mio.ha)
;

scalars
  s90_counter                  counter (1))
;


model magpie_pre /all/ ;

magpie_pre.optfile   = 0 ;
magpie_pre.scaleopt  = 1 ;
magpie_pre.solprint  = 2 ;
magpie_pre.holdfixed = 1 ;


*** EOF declarations.gms ***