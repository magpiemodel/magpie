*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*****************************
*** SOM initialisation    ***
*****************************

i59_subsoilc_density(t_all,j) = fm_carbon_density(t_all,j,"secdforest","soilc") - f59_topsoilc_density(t_all,j);

pc59_som_pool(j,"crop") =
  sum((climate59,kcr),sum(clcl_climate59(clcl,climate59),
      pm_climate_class(j,clcl)) * sum(cell(i,j), f59_cratio_landuse(i,climate59,kcr))
      * f59_topsoilc_density("y1995",j) * sum(w, fm_croparea("y1995",j,w,kcr)));

pc59_som_pool(j,noncropland59) =
  f59_topsoilc_density("y1995",j) * pm_land_start(j,noncropland59);


*****************************
*** carbon initialisation ***
****************************

* starting value of carbon stocks 1995 is only an estimate.
* ATTENTION: emissions in 1995 are not meaningful

vm_carbon_stock.l(j,"crop","soilc",stockType) =
  pc59_som_pool(j,"crop") + i59_subsoilc_density("y1995",j) * pm_land_start(j,"crop");
vm_carbon_stock.l(j,noncropland59,"soilc",stockType) =
  fm_carbon_density("y1995",j,noncropland59,"soilc") * pm_land_start(j,noncropland59);

*****************************
*** cshare calculation    ***
*****************************

*' @code The cellpool_aug16 calculates the carbon loss with the assumption
*' of a lossrate of 15% per year resulting in 44% in 5 years, 80% in 10 years
*' and 96% in 20 years. The lossrate for a given timestep is than calculate by

i59_lossrate(t)=1-0.85**m_yeardiff(t);

*' The stock change factors are implemented for cropland subsystems divided by
*' MAgPIE crop types as well as potentially for tillage and input management.
*' So far it just tracks the subsystem component due to missing data for the
*' other categories. They are set to the following default values:

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

*' For fallow we assume annual crops with bare fallow - therefor low input -
*' and reduced tillage. Assumed to have no irrigation, so irrigation multiplier
*' is 1.

i59_cratio_fallow(j) = sum((cell(i,j),climate59),
                sum(clcl_climate59(clcl,climate59),pm_climate_class(j,clcl))
                * f59_cratio_landuse(i,climate59,"maiz")
                * f59_cratio_tillage(climate59,"reduced_tillage")
                * f59_cratio_inputs(climate59,"low_input"));

i59_cratio_treecover = 1;

*' @stop

pc59_land_before(j,land) = pm_land_start(j,land);

p59_carbon_density(t,j,land) = 0;
pc59_carbon_density(j,land) = 0;
pc59_carbon_density(j,land)$(pc59_land_before(j,land) > 1e-10) = pc59_som_pool(j,land) / pc59_land_before(j,land);
