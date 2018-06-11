*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

scalars
 s35_shift number of 5-year age-classes corresponding to current time step length
;

parameters
 p35_carbon_density_secdforest(t,j,land35,c_pools) carbon density secdforest (tC per ha)
 p35_carbon_density_other(t,j,land35,c_pools) 	   carbon density other land (tC per ha)
 i35_secdforest(j,ac)							   inital secdforest (mio. ha)
 i35_other(j,ac)								   inital other land (mio. ha)
 p35_secdforest(t,j,ac,when)  secdforest per age class before and after optimization (mio. ha)
 p35_other(t,j,ac,when)   	  other land per age class before and after optimization (mio. ha)
 pc35_secdforest(j,land35)    secdforest per aggregated age class (mio. ha)
 pc35_other(j,land35)   	  other land per aggregated age class (mio. ha)
 pc35_natveg_old(j) 		  natveg area in highest age class (mio. ha)
 p35_protect_shr(t,j,prot_type) protection share for primforest secdforest and other land (1)
 p35_save_primforest(t,j) 		primforest protection (mio. ha)
 p35_save_secdforest(t,j)		secdforest protection (mio. ha)
 p35_save_other(t,j)			other land protection (mio. ha)
 p35_recovered_forest(t,j,ac) 	recovered forest (mio. ha)
 p35_min_forest(t,j) 			minimum forest stock in npi and ndc policies (Mha)
 p35_min_other(t,j)      minimum other land stock in npi and ndc policies (Mha)
;

equations
 q35_land_secdforest(j)       		   secdforest land pool calculation
 q35_land_other(j)       		       other land pool calculation
 q35_carbon_primforest(j,c_pools)      primforest carbon stock calculation
 q35_carbon_secdforest(j,c_pools)      secdforest carbon stock calculation
 q35_carbon_other(j,c_pools)      	   other land carbon stock calculation
 q35_landdiff              			   difference in natveg land
 q35_other_expansion(j,land35)		   other land expansion
 q35_other_reduction(j,land35)		   other land reduction
 q35_secdforest_reduction(j,land35)   secdforest reduction
 q35_primforest_reduction(j)   	   primforest reduction
 q35_min_forest(j)					   minimum forest land constraint
 q35_min_other(j)              minimum other land constraint
;

positive variables
  v35_secdforest(j,land35) detailed stock of secdforest (mio. ha)
  v35_other(j,land35)      detailed stock of other land (mio. ha)
  vm_landdiff_natveg       aggregated difference in natveg land compared to previous timestep (mio. ha)
  v35_other_expansion(j,land35) other land expansion compared to previous timestep (mio. ha)
  v35_other_reduction(j,land35) other land reduction compared to previous timestep (mio. ha)
  v35_secdforest_reduction(j,land35) secdforest reduction compared to previous timestep (mio. ha)
  v35_primforest_reduction(j) primforest reduction compared to previous timestep (mio. ha)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov35_secdforest(t,j,land35,type)           detailed stock of secdforest (mio. ha)
 ov35_other(t,j,land35,type)                detailed stock of other land (mio. ha)
 ov_landdiff_natveg(t,type)                 aggregated difference in natveg land compared to previous timestep (mio. ha)
 ov35_other_expansion(t,j,land35,type)      other land expansion compared to previous timestep (mio. ha)
 ov35_other_reduction(t,j,land35,type)      other land reduction compared to previous timestep (mio. ha)
 ov35_secdforest_reduction(t,j,land35,type) secdforest reduction compared to previous timestep (mio. ha)
 ov35_primforest_reduction(t,j,type)        primforest reduction compared to previous timestep (mio. ha)
 oq35_land_secdforest(t,j,type)             secdforest land pool calculation
 oq35_land_other(t,j,type)                  other land pool calculation
 oq35_carbon_primforest(t,j,c_pools,type)   primforest carbon stock calculation
 oq35_carbon_secdforest(t,j,c_pools,type)   secdforest carbon stock calculation
 oq35_carbon_other(t,j,c_pools,type)        other land carbon stock calculation
 oq35_landdiff(t,type)                      difference in natveg land
 oq35_other_expansion(t,j,land35,type)      other land expansion
 oq35_other_reduction(t,j,land35,type)      other land reduction
 oq35_secdforest_reduction(t,j,land35,type) secdforest reduction
 oq35_primforest_reduction(t,j,type)        primforest reduction
 oq35_min_forest(t,j,type)                  minimum forest land constraint
 oq35_min_other(t,j,type)                   minimum other land constraint
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
