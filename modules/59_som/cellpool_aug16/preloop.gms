*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de


*assumption of lossrate of 15% per year, resulting in 44% in 5 years, 80% in 10 years and 96% in 20 years
i59_lossrate(t)=0.85**m_yeardiff(t);

i59_tillage_share(i,tillage59)=0;
i59_tillage_share(i,"full")=1;
i59_input_share(i,inputs59)=0;
i59_input_share(i,"medium")=1;

p59_som_pool(j,pools59) = f59_som_initialisation_pools(startyear,j,pools59);

i59_cratio(j,kcr) = sum((cell(i,j),tillage59,inputs59,climate59),
                 sum(koeppen_to_climate(clcl,climate59),fm_koeppengeiger(j,clcl))
                 * f45_cratio_landuse(climate59,kcr)
                 * i45_tillage_share(i,tillage59)
                 * f45_cratio_tillage(climate59,tillage59)
                 * i45_input_share(i,inputs59)
                 * f45_cratio_inputs(climate59,inputs59));
