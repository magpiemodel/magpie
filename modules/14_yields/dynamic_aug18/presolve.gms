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

p14_growing_stock(t,j,ac,"forestry","plantations") =
    (
      pm_carbon_density_ac_forestry(t,j,ac,"vegc")
      / i14_carbon_fraction
      * i14_aboveground_fraction("forestry")
      / sum(clcl, pm_climate_class(j,clcl) * f14_ipcc_bce(clcl,"plantations"))
     )
    ;

p14_growing_stock(t,j,ac,land_natveg,"natveg") =
    (
     pm_carbon_density_ac(t,j,ac,"vegc")
     / i14_carbon_fraction
     * i14_aboveground_fraction(land_natveg)
     / sum(clcl, pm_climate_class(j,clcl) * f14_ipcc_bce(clcl,"natveg"))
    )
    ;

**** Hard constraint to always have a positive number in p14_growing_stock
p14_growing_stock(t,j,ac,land_natveg,"natveg") = p14_growing_stock(t,j,ac,land_natveg,"natveg")$(p14_growing_stock(t,j,ac,land_natveg,"natveg")>0)+0.0001$(p14_growing_stock(t,j,ac,land_natveg,"natveg")=0);
p14_growing_stock(t,j,ac,"forestry","plantations") = p14_growing_stock(t,j,ac,"forestry","plantations")$(p14_growing_stock(t,j,ac,"forestry","plantations")>0)+0.0001$(p14_growing_stock(t,j,ac,"forestry","plantations")=0);

** Used in equations -- Annual value hence division by timestep
***************************************************************
** If the plantation yield switch is on, forestry yields are treated are plantation yields
pm_timber_yield(t,j,ac,"forestry")$(s14_timber_plantation_yield = 1) = p14_growing_stock(t,j,ac,"forestry","plantations") ;
** Natveg yields are unchanged and doesn't depend on plantation yield switch
pm_timber_yield(t,j,ac,land_natveg) = p14_growing_stock(t,j,ac,land_natveg,"natveg");
** If the plantation yield switch is off, then the forestry yields are given the same values as secdforest yields,
pm_timber_yield(t,j,ac,"forestry")$(s14_timber_plantation_yield = 0) = pm_timber_yield(t,j,ac,"secdforest");

** Used in reporting in magpie4 library
p14_growing_stock_report(t,j,ac,"forestry")$(s14_timber_plantation_yield = 1) = p14_growing_stock(t,j,ac,"forestry","plantations");
p14_growing_stock_report(t,j,ac,land_natveg) = p14_growing_stock(t,j,ac,land_natveg,"natveg");
p14_growing_stock_report(t,j,ac,"forestry")$(s14_timber_plantation_yield = 0) = p14_growing_stock_report(t,j,ac,"secdforest");
