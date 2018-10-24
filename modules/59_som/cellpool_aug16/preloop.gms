*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

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

i59_cratio(j,kcr) = sum((cell(i,j),tillage59,inputs59,climate59),
                 sum(clcl_climate59(clcl,climate59),pm_climate_class(j,clcl))
                 * f59_cratio_landuse(climate59,kcr)
                 * i59_tillage_share(i,tillage59)
                 * f59_cratio_tillage(climate59,tillage59)
                 * i59_input_share(i,inputs59)
                 * f59_cratio_inputs(climate59,inputs59));

*' @stop

p59_som_pool(j,pools59) = f59_som_initialisation_pools("y1995",j, pools59);

p59_carbon_density(t,j,pools59)=0;
