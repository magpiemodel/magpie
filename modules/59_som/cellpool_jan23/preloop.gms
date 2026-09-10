*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*****************************
*** SOM initialisation    ***
*****************************

i59_subsoilc_density(t_all,j) = fm_carbon_density(t_all,j,"other","soilc") - f59_topsoilc_density(t_all,j);

pc59_som_pool(j,"crop") =
  sum((climate59,kcr),sum(clcl_climate59(clcl,climate59),
      pm_climate_class(j,clcl)) * sum(cell(i,j), f59_cratio_landuse(i,climate59,kcr))
      * f59_topsoilc_density("y1995",j) * sum(w, fm_croparea("y1995",j,w,kcr)));

pc59_som_pool(j,noncropland59) =
  f59_topsoilc_density("y1995",j) * pm_land_start(j,noncropland59);


*****************************
*** cshare calculation    ***
*****************************

*' @code This realization calculates the carbon loss with the assumption
*' of a lossrate of 15% per year resulting in 44% in 5 years, 80% in 10 years
*' and 96% in 20 years. The lossrate for a given timestep is than calculate by

i59_lossrate(t)=1-0.85**m_yeardiff(t);

*' The stock change factors are implemented for cropland subsystems divided by
*' MAgPIE crop types as well as potentially for tillage and input management.
*' So far it just tracks the subsystem component due to missing data for the
*' other categories. They are set to the default values from @ipcc_2019_ch5 
*' IPCC (2019), Table 5.5.
*' Careful when diverging from default values: Rice and perennial crops should
*' not be varied by input and tillage modifiers as they are classified as 
*' unique management systems @ipcc_2019_ch5 (IPCC 2019, Figure 5.1).

i59_tillage_share(i,tillage59)=0;
i59_tillage_share(i,"full_tillage")=1;
i59_input_share(i,inputs59)=0;
i59_input_share(i,"medium_input")=1;

*' The stock change factor in each cell for every crop type also takes into account
*' the climate variability of these factors and is therefor given by:

i59_cratio(j,kcr,w) = sum((cell(i,j),tillage59,inputs59,climate59),
                 sum(clcl_climate59(clcl,climate59),pm_climate_class(j,clcl))
                 * f59_cratio_landuse(i,climate59,kcr)
                 * i59_tillage_share(i,tillage59)
                 * f59_cratio_tillage(climate59,tillage59)
                 * i59_input_share(i,inputs59)
                 * f59_cratio_inputs(climate59,inputs59)
                 * f59_cratio_irrigation(climate59,w,kcr));


*' Fallow management: for dry regions, assume bare fallow and full tillage to save water, 
*' implemented through IPCC F_LU factor for long-term cultivated cropland with full tillage
*' and low inputs @ipcc_2019_ch5 (IPCC 2019, Table 5.5).
*' For moist regions, assume F_LU factor of set-aside.
*' Assumed to have no irrigation, so irrigation multiplier is 1.

i59_cratio_fallow_climate(climate59) = f59_cratio_landuse_fallow(climate59)
                * f59_cratio_tillage(climate59,"full_tillage")
                * f59_cratio_inputs(climate59,"low_input");

i59_cratio_fallow_climate(climate59moist) = f59_cratio_landuse_fallow(climate59moist);

i59_cratio_fallow(j) = sum(climate59,
                sum(clcl_climate59(clcl,climate59),pm_climate_class(j,clcl))
                * i59_cratio_fallow_climate(climate59));

*' For treecover in cropland (e.g. agroforestry areas) we assume natural soil carbon
*' values as target value, and thus set the value to `1`:

i59_cratio_treecover = 1;


*' For dedicated soil carbon management we use the `high_input_nomanure` values from the IPCC guidelines,
*' as the refer to the usage of dedicated SCM measures such as cover crops, improved residue management etc.

i59_cratio_scm(j) = sum(climate59, sum(clcl_climate59(clcl,climate59),
                     pm_climate_class(j,clcl)) *
                       f59_cratio_inputs(climate59,"high_input_nomanure"));

*' @stop

*********************************************
*** fallow and tree cover initialisation  ***
*********************************************

*' @code The cropland pool initialised above only covers the croparea. Fallow
*' land and tree cover carry no croparea, but do enter the cropland target stock
*' `q59_som_target_cropland`. Their soil carbon is therefore initialized here with the
*' same stock change factors the target uses:

pc59_som_pool(j,"crop") = pc59_som_pool(j,"crop")
  + (im_fallow_start(j) * i59_cratio_fallow(j)
     + pm_treecover_start(j) * i59_cratio_treecover)
    * f59_topsoilc_density("y1995",j);

*' @stop

*****************************
*** carbon initialisation ***
****************************

* starting value of carbon stocks 1995 is only an estimate.
* ATTENTION: emissions in 1995 are not meaningful

pcm_carbon_stock(j,"crop","soilc",stockType) =
  pc59_som_pool(j,"crop") + i59_subsoilc_density("y1995",j) * pm_land_start(j,"crop");
vm_carbon_stock.l(j,"crop","soilc",stockType) = pcm_carbon_stock(j,"crop","soilc",stockType);
pcm_carbon_stock(j,noncropland59,"soilc",stockType) =
  fm_carbon_density("y1995",j,noncropland59,"soilc") * pm_land_start(j,noncropland59);
vm_carbon_stock.l(j,noncropland59,"soilc",stockType) = pcm_carbon_stock(j,noncropland59,"soilc",stockType);

** Trajectory for cropland scenarios
* linear or sigmoidal interpolation between start year and target year
if (s59_fader_functional_form = 1,
  m_linear_time_interpol(i59_scm_scenario_fader,s59_scm_scenario_start,s59_scm_scenario_target,0,1);
elseif s59_fader_functional_form = 2,
  m_sigmoid_time_interpol(i59_scm_scenario_fader,s59_scm_scenario_start,s59_scm_scenario_target,0,1);
);

* Country switch to determine countries for which certain policies shall be applied.
* In the default case, the policy affects all countries when activated.
p59_scm_country_switch(iso) = 0;
p59_scm_country_switch(policy_countries59) = 1;
* Because MAgPIE is not run at country-level, but at region level, a region
* share is calculated that translates the countries' influence to regional level.
* Countries are weighted by available cropland area `pm_avl_cropland_iso`
p59_country_weight(i) = sum(i_to_iso(i,iso), p59_scm_country_switch(iso) * 
  pm_avl_cropland_iso(iso)) / sum(i_to_iso(i,iso), pm_avl_cropland_iso(iso));

pc59_land_before(j,land) = pm_land_start(j,land);

p59_carbon_density(t,j,land) = 0;
pc59_carbon_density(j,land) = 0;
pc59_carbon_density(j,land)$(pc59_land_before(j,land) > 1e-10) = pc59_som_pool(j,land) / pc59_land_before(j,land);
