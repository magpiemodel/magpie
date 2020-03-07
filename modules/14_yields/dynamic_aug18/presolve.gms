*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*** EOF presolve.gms ***

* calculate carbon density

*** YIELDS


pm_growing_stock(t,j,ac_sub,"forestry") =
    (
      pm_carbon_density_ac_forestry(t,j,ac_sub,"vegc") * i14_root_to_shoot_ratio("forestry")
      /
      (sum(clcl, pm_climate_class(j,clcl) * f14_ipcc_bce(clcl,"plantations",ac_sub))
        * i14_carbon_fraction
      )
     )
     / (5$(ord(t)=1) + m_yeardiff(t)$(ord(t)>1))
    ;


pm_growing_stock(t,j,ac_sub,land_natveg) =
    (
      pm_carbon_density_ac(t,j,ac_sub,"vegc") * i14_root_to_shoot_ratio(land_natveg)
      /
      (sum(clcl, pm_climate_class(j,clcl) * f14_ipcc_bce(clcl,"natveg",ac_sub))
        * i14_carbon_fraction
      )
     )
     / (5$(ord(t)=1) + m_yeardiff(t)$(ord(t)>1))
    ;

**** Hard constraint to always have a positive number in pm_growing_stock
pm_growing_stock(t,j,ac_sub,land_natveg) = pm_growing_stock(t,j,ac_sub,land_natveg)$(pm_growing_stock(t,j,ac_sub,land_natveg)>0)+0.0001$(pm_growing_stock(t,j,ac_sub,land_natveg)=0);
