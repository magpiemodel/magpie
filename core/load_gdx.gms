*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

if((s_use_gdx > 0),
$if exist "magpie_y1995.gdx"  if(sameas(t,"y1995"), Execute_Loadpoint "magpie_y1995.gdx"; );
);

if((s_use_gdx = 2),
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
