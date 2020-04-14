*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*** EOF presolve.gms ***

* calculate carbon density

*** YIELDS

* pm_carbon_density_ac_forestry (vegc) is above + below ground carbon density.
* convert from tC/ha to tDM/ha by using carbon fraction of 0.5 tC/tDM
* for wood harvesting we want only above ground biomass. Therefore multiply with
* aboveground_fraction.
* Divide Aboveground tree biomass by BEF to get Stem biomass in tDM/ha

pm_growing_stock(t,j,ac,"forestry","plantations") =
    (
      pm_carbon_density_ac_forestry(t,j,ac,"vegc")
      / i14_carbon_fraction
      * i14_aboveground_fraction("forestry")
      / sum(clcl, pm_climate_class(j,clcl) * f14_ipcc_bce(clcl,"plantations",ac))
     )
*     / (5$(ord(t)=1) + m_yeardiff(t)$(ord(t)>1))
      / (5)
    ;


pm_growing_stock(t,j,ac,land_natveg,"natveg") =
    (
     pm_carbon_density_ac(t,j,ac,"vegc")
     / i14_carbon_fraction
     * i14_aboveground_fraction(land_natveg)
     / sum(clcl, pm_climate_class(j,clcl) * f14_ipcc_bce(clcl,"natveg",ac))
    )
*    / (5$(ord(t)=1) + m_yeardiff(t)$(ord(t)>1))
     / (5)
    ;

**** Hard constraint to always have a positive number in pm_growing_stock
pm_growing_stock(t,j,ac,land_natveg,"natveg") = pm_growing_stock(t,j,ac,land_natveg,"natveg")$(pm_growing_stock(t,j,ac,land_natveg,"natveg")>0)+0.0001$(pm_growing_stock(t,j,ac,land_natveg,"natveg")=0);
