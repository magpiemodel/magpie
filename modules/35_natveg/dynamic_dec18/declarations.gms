*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

scalars
 s35_shift number of 5-year age-classes corresponding to current time step length (1)
;

parameters
 i35_secdforest(j,ac)							   Inital secdforest (mio. ha)
 i35_other(j,ac)								   Inital other land (mio. ha)
 p35_secdforest(t,j,ac)  	Secdforest per age class before and after optimization (mio. ha)
 p35_other(t,j,ac)   	  	Other land per age class before and after optimization (mio. ha)
 pc35_secdforest(j,ac)    	Secdforest per aggregated age class (mio. ha)
 pc35_other(j,ac)   	  	Other land per aggregated age class (mio. ha)
 p35_protect_shr(t,j,prot_type) Protection share for primforest secdforest and other land (1)
 p35_save_primforest(t,j) 		Primforest protection (mio. ha)
 p35_save_secdforest(t,j)		Secdforest protection (mio. ha)
 p35_save_other(t,j)			Other land protection (mio. ha)
 p35_recovered_forest(t,j,ac) 	Recovered forest (mio. ha)
 p35_min_forest(t,j) 			Minimum forest stock [land protection policies] (Mha)
 p35_min_other(t,j)      		Minimum other land stock [land protection policies] (Mha)

 p35_yield_natveg(t,j,ac)   Yield of natural vegetation (m3 per ha per yr)
 p35_yield_primforest(t,j)  Yield of primary vegetation (m3 per ha per yr)

 i35_ageclass_area_secdf(j,ac)  Age class distribution from poulter et al (1)
 i35_ageclass_shr_grow(j,ac)    Age class share distribution (1)
;

equations
 q35_land_secdforest(j)       		   Secdforest land pool calculation (mio. ha)
 q35_land_other(j)       		       Other land pool calculation (mio. ha)
 q35_carbon_primforest(j,c_pools)      Primforest carbon stock calculation (mio tC)
 q35_carbon_secdforest(j,c_pools)      Secdforest carbon stock calculation (mio tC)
 q35_carbon_other(j,c_pools)      	   Other land carbon stock calculation (mio tC)
 q35_landdiff              			   Difference in natveg land (mio. ha)
 q35_other_expansion(j,ac)		   Other land expansion (mio. ha)
 q35_other_reduction(j,ac)		   Other land reduction (mio. ha)
 q35_secdforest_reduction(j,ac)    Secdforest reduction (mio. ha)
 q35_primforest_reduction(j)   	       Primforest reduction (mio. ha)
 q35_min_forest(j)					   Minimum forest land constraint (mio. ha)
 q35_min_other(j)              		   Minimum other land constraint (mio. ha)

 q35_cost_harvest(i)              Cost of harvesting natveg (mio. USD)
 q35_prod_secdforest_wood(j)      Wood production from secondary forest (mio. m3)
 q35_prod_secdforest_woodfuel(j)  Woodfuel production from secondary forest (mio. m3)
 q35_prod_primforest_wood(j)      Wood production from primary forest (mio. m3)
 q35_prod_primforest_woodfuel(j)  Woodfuel production from primary forest (mio. m3)
 q35_prod_other(j)                Woodfuel production from other land (mio. m3)
 q35_hvarea_secdforest(j,ac_sub)  Area harvested from secondary forests (mio. ha)
 q35_hvarea_primforest(j)         Area harvested from primary forests (mio. ha)
 q35_hvarea_other(j,ac_sub)       Area harvested from other land (mio. ha)
 q35_secdforest_conversion(j)     Conversion of secondary forest (mio.ha)
 q35_production_timber(j,kforestry)         Timber production from natural vegetation (mio. USD)
 q35_cost_total(i)                Natveg realted production costs (mio. USD)
;

positive variables
  v35_secdforest(j,ac) Detailed stock of secdforest (mio. ha)
  v35_other(j,ac)      Detailed stock of other land (mio. ha)
  vm_landdiff_natveg       Aggregated difference in natveg land compared to previous timestep (mio. ha)
  v35_other_expansion(j,ac) Other land expansion compared to previous timestep (mio. ha)
  v35_other_reduction(j,ac) Other land reduction compared to previous timestep (mio. ha)
  v35_secdforest_reduction(j,ac) Secdforest reduction compared to previous timestep (mio. ha)
  v35_primforest_reduction(j) Primforest reduction compared to previous timestep (mio. ha)

  v35_cost_harvest(i)                         Cost of harvesting natveg (mio. USD)
  v35_hvarea_secdforest(j,kforestry,ac_sub)   Harvested area of secondary forest (mio. ha)
  v35_hvarea_other(j,kforestry,ac_sub)        Harvested area of other land (mio. ha)
  v35_hvarea_primforest(j,kforestry)          Harvested area of primary forest (mio. ha)
  v35_prod(j,land_natveg,kforestry)          Timber production coming from natveg (mio. m3)
  v35_prod_external(i,kforestry)            Production balanceflow (mio. m3)
  vm_cost_natveg(i)                           Regional natveg timber production costs (mio. USD)
  vm_prod_natveg(j,kforestry)                  xx
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov35_secdforest(t,j,ac,type)                      Detailed stock of secdforest (mio. ha)
 ov35_other(t,j,ac,type)                           Detailed stock of other land (mio. ha)
 ov_landdiff_natveg(t,type)                        Aggregated difference in natveg land compared to previous timestep (mio. ha)
 ov35_other_expansion(t,j,ac,type)                 Other land expansion compared to previous timestep (mio. ha)
 ov35_other_reduction(t,j,ac,type)                 Other land reduction compared to previous timestep (mio. ha)
 ov35_secdforest_reduction(t,j,ac,type)            Secdforest reduction compared to previous timestep (mio. ha)
 ov35_primforest_reduction(t,j,type)               Primforest reduction compared to previous timestep (mio. ha)
 ov35_cost_harvest(t,i,type)                       Cost of harvesting natveg (mio. USD)
 ov35_hvarea_secdforest(t,j,kforestry,ac_sub,type) Harvested area of secondary forest (mio. ha)
 ov35_hvarea_other(t,j,kforestry,ac_sub,type)      Harvested area of other land (mio. ha)
 ov35_hvarea_primforest(t,j,kforestry,type)        Harvested area of primary forest (mio. ha)
 ov35_prod(t,j,land_natveg,kforestry,type)         Timber production coming from natveg (mio. m3)
 ov35_prod_external(t,i,kforestry,type)            Production balanceflow (mio. m3)
 ov_cost_natveg(t,i,type)                          Regional natveg timber production costs (mio. USD)
 ov_prod_natveg(t,j,kforestry,type)                xx
 oq35_land_secdforest(t,j,type)                    Secdforest land pool calculation (mio. ha)
 oq35_land_other(t,j,type)                         Other land pool calculation (mio. ha)
 oq35_carbon_primforest(t,j,c_pools,type)          Primforest carbon stock calculation (mio tC)
 oq35_carbon_secdforest(t,j,c_pools,type)          Secdforest carbon stock calculation (mio tC)
 oq35_carbon_other(t,j,c_pools,type)               Other land carbon stock calculation (mio tC)
 oq35_landdiff(t,type)                             Difference in natveg land (mio. ha)
 oq35_other_expansion(t,j,ac,type)                 Other land expansion (mio. ha)
 oq35_other_reduction(t,j,ac,type)                 Other land reduction (mio. ha)
 oq35_secdforest_reduction(t,j,ac,type)            Secdforest reduction (mio. ha)
 oq35_primforest_reduction(t,j,type)               Primforest reduction (mio. ha)
 oq35_min_forest(t,j,type)                         Minimum forest land constraint (mio. ha)
 oq35_min_other(t,j,type)                          Minimum other land constraint (mio. ha)
 oq35_cost_harvest(t,i,type)                       Cost of harvesting natveg (mio. USD)
 oq35_prod_secdforest_wood(t,j,type)               Wood production from secondary forest (mio. m3)
 oq35_prod_secdforest_woodfuel(t,j,type)           Woodfuel production from secondary forest (mio. m3)
 oq35_prod_primforest_wood(t,j,type)               Wood production from primary forest (mio. m3)
 oq35_prod_primforest_woodfuel(t,j,type)           Woodfuel production from primary forest (mio. m3)
 oq35_prod_other(t,j,type)                         Woodfuel production from other land (mio. m3)
 oq35_hvarea_secdforest(t,j,ac_sub,type)           Area harvested from secondary forests (mio. ha)
 oq35_hvarea_primforest(t,j,type)                  Area harvested from primary forests (mio. ha)
 oq35_hvarea_other(t,j,ac_sub,type)                Area harvested from other land (mio. ha)
 oq35_secdforest_conversion(t,j,type)              Conversion of secondary forest (mio.ha)
 oq35_production_timber(t,j,kforestry,type)        Timber production from natural vegetation (mio. USD)
 oq35_cost_total(t,i,type)                         Natveg realted production costs (mio. USD)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
