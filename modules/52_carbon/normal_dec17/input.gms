*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

$setglobal c52_carbon_scenario  cc
*   options:  cc        (climate change)
*             nocc      (no climate change)
*             nocc_hist (no climate change after year defined by sm_fix_cc)

$setglobal c52_land_carbon_sink_rcp  RCPBU
*   options:  RCP19, RCP26, RCP34, RCP45, RCP60, RCPBU

table fm_carbon_density(t_all,j,land,c_pools) LPJmL carbon density for land and carbon pools (tC per ha)
$ondelim
$include "./modules/52_carbon/input/lpj_carbon_stocks.cs3"
$offdelim
;

$if "%c52_carbon_scenario%" == "nocc" fm_carbon_density(t_all,j,land,c_pools) = fm_carbon_density("y1995",j,land,c_pools);
$if "%c52_carbon_scenario%" == "nocc_hist" fm_carbon_density(t_all,j,land,c_pools)$(m_year(t_all) > sm_fix_cc) = fm_carbon_density(t_all,j,land,c_pools)$(m_year(t_all) = sm_fix_cc);
m_fillmissingyears(fm_carbon_density,"j,land,c_pools");

* Where no forest carbon density is reported, because the potential
* forest area is zero, use the carbon density of other land instead.
* This affects areas, where the land use intialisation reports some
* forest, although the forest potential is zero. Forest expansion in
* these cells is constrained by f35_pot_forest_area.
fm_carbon_density(t_all,j,land_forest,c_pools)$(fm_carbon_density(t_all,j,land_forest,c_pools) = 0) = fm_carbon_density(t_all,j,"other",c_pools);

* Fix urban area soilc to natural land soilc as long as preprocessed
* fm_carbon_density does not provide meaningful numbers for urban.
fm_carbon_density(t_all,j,"urban","soilc") = fm_carbon_density(t_all,j,"other","soilc")

parameter f52_growth_par(clcl,chap_par,forest_type) Parameters for chapman-richards equation (1)
/
$ondelim
$include "./modules/52_carbon/input/f52_growth_par.csv"
$offdelim
/
;

* Note: Land carbon sink adjustment factors from Grassie et al 2021 (DOI 10.1038/s41558-021-01033-6)
* are needed in the post-processing in https://github.com/pik-piam/magpie4/blob/master/R/reportEmissions.R
* To facilitate the choice of the corresponding RCP, the adjustment factors are read-in here and
* stored in i52_land_carbon_sink for use in the R post-processing.
* Land carbon sink adjustment factors are NOT used within MAgPIE.
$onEmpty
table f52_land_carbon_sink(t_all,i,rcp52) Land carbon sink adjustment factors from Grassi et al 2021 (GtCO2 per year)
$ondelim
$if exist "./modules/52_carbon/input/f52_land_carbon_sink_adjust_grassi.cs3" $include "./modules/52_carbon/input/f52_land_carbon_sink_adjust_grassi.cs3"
$offdelim
;
$offEmpty

$ifthen "%c52_land_carbon_sink_rcp%" == "nocc"
  i52_land_carbon_sink(t_all,i) = f52_land_carbon_sink("y1995",i,"RCPBU");
$elseif "%c52_land_carbon_sink_rcp%" == "nocc_hist"
  i52_land_carbon_sink(t_all,i) = f52_land_carbon_sink(t_all,i,"RCPBU");
  i52_land_carbon_sink(t_all,i)$(m_year(t_all) > sm_fix_cc) = f52_land_carbon_sink(t_all,i,"RCPBU")$(m_year(t_all) = sm_fix_cc);
$else
  i52_land_carbon_sink(t_all,i) = f52_land_carbon_sink(t_all,i,"%c52_land_carbon_sink_rcp%");
  i52_land_carbon_sink(t_all,i)$(m_year(t_all) <= sm_fix_cc) = f52_land_carbon_sink(t_all,i,"RCPBU")$(m_year(t_all) <= sm_fix_cc);
$endif
