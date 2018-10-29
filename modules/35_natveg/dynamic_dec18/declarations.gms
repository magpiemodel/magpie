*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

scalars
 s35_shift number of 5-year age-classes corresponding to current time step length (1)
;

parameters
 p35_carbon_density_secdforest(t,j,land35,c_pools) Carbon density secdforest (tC per ha)
 p35_carbon_density_other(t,j,land35,c_pools) 	   Carbon density other land (tC per ha)
 i35_secdforest(j,ac)							   Inital secdforest (mio. ha)
 i35_other(j,ac)								   Inital other land (mio. ha)
 p35_secdforest(t,j,ac,when)  	Secdforest per age class before and after optimization (mio. ha)
 p35_other(t,j,ac,when)   	  	Other land per age class before and after optimization (mio. ha)
 pc35_secdforest(j,land35)    	Secdforest per aggregated age class (mio. ha)
 pc35_other(j,land35)   	  	Other land per aggregated age class (mio. ha)
 p35_protect_shr(t,j,prot_type) Protection share for primforest secdforest and other land (1)
 p35_save_primforest(t,j) 		Primforest protection (mio. ha)
 p35_save_secdforest(t,j)		Secdforest protection (mio. ha)
 p35_save_other(t,j)			Other land protection (mio. ha)
 p35_recovered_forest(t,j,ac) 	Recovered forest (mio. ha)
 p35_min_forest(t,j) 			Minimum forest stock [land protection policies] (Mha)
 p35_min_other(t,j)      		Minimum other land stock [land protection policies] (Mha)
;

equations
 q35_land_secdforest(j)       		   Secdforest land pool calculation (mio. ha)
 q35_land_other(j)       		       Other land pool calculation (mio. ha)
 q35_carbon_primforest(j,c_pools)      Primforest carbon stock calculation (mio tC)
 q35_carbon_secdforest(j,c_pools)      Secdforest carbon stock calculation (mio tC)
 q35_carbon_other(j,c_pools)      	   Other land carbon stock calculation (mio tC)
 q35_landdiff              			   Difference in natveg land (mio. ha)
 q35_other_expansion(j,land35)		   Other land expansion (mio. ha)
 q35_other_reduction(j,land35)		   Other land reduction (mio. ha)
 q35_secdforest_reduction(j,land35)    Secdforest reduction (mio. ha)
 q35_primforest_reduction(j)   	       Primforest reduction (mio. ha)
 q35_min_forest(j)					   Minimum forest land constraint (mio. ha)
 q35_min_other(j)              		   Minimum other land constraint (mio. ha)
;

positive variables
  v35_secdforest(j,land35) Detailed stock of secdforest (mio. ha)
  v35_other(j,land35)      Detailed stock of other land (mio. ha)
  vm_landdiff_natveg       Aggregated difference in natveg land compared to previous timestep (mio. ha)
  v35_other_expansion(j,land35) Other land expansion compared to previous timestep (mio. ha)
  v35_other_reduction(j,land35) Other land reduction compared to previous timestep (mio. ha)
  v35_secdforest_reduction(j,land35) Secdforest reduction compared to previous timestep (mio. ha)
  v35_primforest_reduction(j) Primforest reduction compared to previous timestep (mio. ha)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov35_secdforest(t,j,land35,type)           Detailed stock of secdforest (mio. ha)
 ov35_other(t,j,land35,type)                Detailed stock of other land (mio. ha)
 ov_landdiff_natveg(t,type)                 Aggregated difference in natveg land compared to previous timestep (mio. ha)
 ov35_other_expansion(t,j,land35,type)      Other land expansion compared to previous timestep (mio. ha)
 ov35_other_reduction(t,j,land35,type)      Other land reduction compared to previous timestep (mio. ha)
 ov35_secdforest_reduction(t,j,land35,type) Secdforest reduction compared to previous timestep (mio. ha)
 ov35_primforest_reduction(t,j,type)        Primforest reduction compared to previous timestep (mio. ha)
 oq35_land_secdforest(t,j,type)             Secdforest land pool calculation (mio. ha)
 oq35_land_other(t,j,type)                  Other land pool calculation (mio. ha)
 oq35_carbon_primforest(t,j,c_pools,type)   Primforest carbon stock calculation (mio tC)
 oq35_carbon_secdforest(t,j,c_pools,type)   Secdforest carbon stock calculation (mio tC)
 oq35_carbon_other(t,j,c_pools,type)        Other land carbon stock calculation (mio tC)
 oq35_landdiff(t,type)                      Difference in natveg land (mio. ha)
 oq35_other_expansion(t,j,land35,type)      Other land expansion (mio. ha)
 oq35_other_reduction(t,j,land35,type)      Other land reduction (mio. ha)
 oq35_secdforest_reduction(t,j,land35,type) Secdforest reduction (mio. ha)
 oq35_primforest_reduction(t,j,type)        Primforest reduction (mio. ha)
 oq35_min_forest(t,j,type)                  Minimum forest land constraint (mio. ha)
 oq35_min_other(t,j,type)                   Minimum other land constraint (mio. ha)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
