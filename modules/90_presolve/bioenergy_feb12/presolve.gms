*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de


**************************** MAGPIE PRE ****************************************
*Setting bioenergy demand to 0 for pre-solve
sm_use_bioenergy = 0;

*Loading gdx-files (sm_use_gdx>0)
if((sm_use_gdx > 0),
$if exist "magpie_y1995.gdx"  if(sameas(t,"y1995"), Execute_Loadpoint "magpie_y1995.gdx"; );
);

if((sm_use_gdx = 2),
$if exist "magpie_y2000.gdx"  if(sameas(t,"y2000"), Execute_Loadpoint "magpie_y2000.gdx"; );
$if exist "magpie_y2005.gdx"  if(sameas(t,"y2005"), Execute_Loadpoint "magpie_y2005.gdx"; );
$if exist "magpie_y2010.gdx"  if(sameas(t,"y2010"), Execute_Loadpoint "magpie_y2010.gdx"; );
$if exist "magpie_y2015.gdx"  if(sameas(t,"y2015"), Execute_Loadpoint "magpie_y2015.gdx"; );
$if exist "magpie_y2020.gdx"  if(sameas(t,"y2020"), Execute_Loadpoint "magpie_y2020.gdx"; );
$if exist "magpie_y2025.gdx"  if(sameas(t,"y2025"), Execute_Loadpoint "magpie_y2025.gdx"; );
$if exist "magpie_y2030.gdx"  if(sameas(t,"y2030"), Execute_Loadpoint "magpie_y2030.gdx"; );
$if exist "magpie_y2035.gdx"  if(sameas(t,"y2035"), Execute_Loadpoint "magpie_y2035.gdx"; );
$if exist "magpie_y2040.gdx"  if(sameas(t,"y2040"), Execute_Loadpoint "magpie_y2040.gdx"; );
$if exist "magpie_y2045.gdx"  if(sameas(t,"y2045"), Execute_Loadpoint "magpie_y2045.gdx"; );
$if exist "magpie_y2050.gdx"  if(sameas(t,"y2050"), Execute_Loadpoint "magpie_y2050.gdx"; );
$if exist "magpie_y2055.gdx"  if(sameas(t,"y2055"), Execute_Loadpoint "magpie_y2055.gdx"; );
$if exist "magpie_y2060.gdx"  if(sameas(t,"y2060"), Execute_Loadpoint "magpie_y2060.gdx"; );
$if exist "magpie_y2065.gdx"  if(sameas(t,"y2065"), Execute_Loadpoint "magpie_y2065.gdx"; );
$if exist "magpie_y2070.gdx"  if(sameas(t,"y2070"), Execute_Loadpoint "magpie_y2070.gdx"; );
$if exist "magpie_y2075.gdx"  if(sameas(t,"y2075"), Execute_Loadpoint "magpie_y2075.gdx"; );
$if exist "magpie_y2080.gdx"  if(sameas(t,"y2080"), Execute_Loadpoint "magpie_y2080.gdx"; );
$if exist "magpie_y2085.gdx"  if(sameas(t,"y2085"), Execute_Loadpoint "magpie_y2085.gdx"; );
$if exist "magpie_y2090.gdx"  if(sameas(t,"y2090"), Execute_Loadpoint "magpie_y2090.gdx"; );
$if exist "magpie_y2095.gdx"  if(sameas(t,"y2095"), Execute_Loadpoint "magpie_y2095.gdx"; );
$if exist "magpie_y2100.gdx"  if(sameas(t,"y2100"), Execute_Loadpoint "magpie_y2100.gdx"; );
$if exist "magpie_y2105.gdx"  if(sameas(t,"y2105"), Execute_Loadpoint "magpie_y2105.gdx"; );
$if exist "magpie_y2110.gdx"  if(sameas(t,"y2110"), Execute_Loadpoint "magpie_y2110.gdx"; );
$if exist "magpie_y2115.gdx"  if(sameas(t,"y2115"), Execute_Loadpoint "magpie_y2115.gdx"; );
$if exist "magpie_y2120.gdx"  if(sameas(t,"y2120"), Execute_Loadpoint "magpie_y2120.gdx"; );
$if exist "magpie_y2125.gdx"  if(sameas(t,"y2125"), Execute_Loadpoint "magpie_y2125.gdx"; );
$if exist "magpie_y2130.gdx"  if(sameas(t,"y2130"), Execute_Loadpoint "magpie_y2130.gdx"; );
$if exist "magpie_y2135.gdx"  if(sameas(t,"y2135"), Execute_Loadpoint "magpie_y2135.gdx"; );
$if exist "magpie_y2140.gdx"  if(sameas(t,"y2140"), Execute_Loadpoint "magpie_y2140.gdx"; );
$if exist "magpie_y2145.gdx"  if(sameas(t,"y2145"), Execute_Loadpoint "magpie_y2145.gdx"; );
$if exist "magpie_y2150.gdx"  if(sameas(t,"y2150"), Execute_Loadpoint "magpie_y2150.gdx"; );
);

*************************** SOLVE STATEMENT ************************************
p90_modelstat(t) = 3;
s90_counter = 0;
while((s90_counter < sm_maxiter),
  solve magpie_pre USING nlp MINIMIZING vm_cost_glo;
  p90_modelstat(t) = magpie_pre.modelstat;
  if((p90_modelstat(t) < 3),s90_counter = 1000);
  s90_counter = s90_counter + 1;
);

if((magpie_pre.modelstat > 2 and magpie_pre.modelstat ne 7),
  Execute_Unload "fulldata.gdx";
  abort "no feasible solution found in presolve",magpie_pre.modelstat;
);

********************************************************************************

o90_cost_glo(t)            = vm_cost_glo.l;
o90_cost_reg(t,i)          = vm_cost_reg.l(i);
o90_emissions_reg(t,i,emis_source,pollutants) = vm_emissions_reg.l(i,emis_source,pollutants);
o90_tech_cost(t,i)         = vm_tech_cost.l(i);
o90_cost_prod(t,i,k)       = vm_cost_prod.l(i,k);
o90_cost_transp(t,j,k)     = vm_cost_transp.l(j,k);
o90_cost_landcon(t,j,land) = vm_cost_landcon.l(j,land);
o90_maccs_costs(t,i)       = vm_maccs_costs.l(i);
o90_emission_costs(t,i)    = vm_emission_costs.l(i);
o90_land(t,j,land,si)            = vm_land.l(j,land,si);

*Set bioenergy demands back to origin
sm_use_bioenergy = 1;
********************************************************************************

$if exist "magpie_p.gdx"  if((ord(t)>1),  Execute_Loadpoint "magpie_p.gdx"; );


*** EOF solve.gms ***