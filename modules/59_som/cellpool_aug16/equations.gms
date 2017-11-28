*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de


q59_som_target_cropland(j2) ..
              v59_som_target(j2,"cropland")
              =e=
              sum((kcr,w), vm_area(j2,kcr,w) * i59_cratio(j2,kcr)) * sum(ct,fm_carbon_density(ct,j2,"other","soilc"))
              ;


q59_som_target_noncropland(j2) ..
              v59_som_target(j2,"noncropland")
              =e=
              sum((noncropland59),vm_land(j2,noncropland59)*sum(ct,fm_carbon_density(ct,j2,noncropland59,"soilc")));

q59_som_transfer_to_cropland(j2) ..
              v59_som_transfer_to_cropland(j2)
              =e=
              sum(ct,
              + vm_landexpansion(j2,"crop") * p59_carbon_density(ct,j2,"noncropland")
              - vm_landreduction(j2,"crop") * p59_carbon_density(ct,j2,"cropland")
              );


q59_som_pool_cropland(j2) ..
             v59_som_pool(j2,"cropland")
              =e=
              sum(ct,
                (1-i59_lossrate(ct)) *  v59_som_target(j2,"cropland") +
                 i59_lossrate(ct) * (p59_som_pool(j2,"cropland") + v59_som_transfer_to_cropland(j2))
              );

q59_som_pool_noncropland(j2) ..
               v59_som_pool(j2,"noncropland")
               =e=
               sum(ct,
                 (1-i59_lossrate(ct)) * v59_som_target(j2,"noncropland") +
                  i59_lossrate(ct) * (p59_som_pool(j2,"noncropland") - v59_som_transfer_to_cropland(j2))
               );

q59_nr_som(j2) ..
           vm_nr_som(j2)
           =e=
           sum(ct,i59_lossrate(ct)) * (
             p59_som_pool(j2,"cropland")
             + v59_som_transfer_to_cropland(j2)
             - v59_som_target(j2,"cropland")
           )/15;