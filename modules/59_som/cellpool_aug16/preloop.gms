*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de


*assumption of lossrate of 15% per year, resulting in 44% in 5 years, 80% in 10 years and 96% in 20 years
i59_lossrate(t)=0.85**m_yeardiff(t);

i59_tillage_share(i,tillage59)=0;
i59_tillage_share(i,"full_tillage")=1;
i59_input_share(i,inputs59)=0;
i59_input_share(i,"medium_input")=1;

i59_cratio(j,kcr) = sum((cell(i,j),tillage59,inputs59,climate59),
                 sum(clcl_climate59(clcl,climate59),pm_climate_class(j,clcl))
                 * f59_cratio_landuse(climate59,kcr)
                 * i59_tillage_share(i,tillage59)
                 * f59_cratio_tillage(climate59,tillage59)
                 * i59_input_share(i,inputs59)
                 * f59_cratio_inputs(climate59,inputs59));

* p59_som_pool(j,pools59) = f59_som_initialisation_pools(startyear,j,pools59);
* attention: the following is a quickfix until f59_som_initialisation_pools can be calculated by moinput
p59_som_pool(j,"cropland") = sum(si, pcm_land(j,"crop",si)) * i59_cratio(j,"tece") * sum(ct,fm_carbon_density(ct,j,"crop","soilc"));
p59_som_pool(j,"noncropland") =   sum((noncropland59,si),pcm_land(j,noncropland59,si)*sum(ct,fm_carbon_density(ct,j,noncropland59,"soilc")));

p59_carbon_density(t,j,pools59)=0;