*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*** EOF presolve.gms ***

* calculate carbon density

*** YIELDS

*` `pm_carbon_density_plantation_ac` for vegetation Carbon is above- and belowground
*' carbon density. We convert Carbon density in tC/ha to tDM/ha by using carbon
*' fraction of `s14_carbon_fraction` in tC/tDM. For assessing wood harvesting
*' we need only aboveground biomass information, therefore we multiply with
*' aboveground `f14_aboveground_fraction`. Additionally, we divide aboveground
*' tree biomass by biomass conversion and expansion (BCE) factor to get stem
*' biomass in tDM/ha.

*` @code

pm_timber_yield(t,j,ac,"forestry") =
    (
     pm_carbon_density_plantation_ac(t,j,ac,"vegc")
     / s14_carbon_fraction
     * f14_aboveground_fraction("forestry")
     / sum(clcl, pm_climate_class(j,clcl) * f14_ipcc_bce(clcl,"plantations"))
    )
    ;

pm_timber_yield(t,j,ac,"primforest") =
    (
     fm_carbon_density(t,j,"primforest","vegc")
     / s14_carbon_fraction
     * f14_aboveground_fraction("primforest")
     / sum(clcl, pm_climate_class(j,clcl) * f14_ipcc_bce(clcl,"natveg"))
    )
    ;

pm_timber_yield(t,j,ac,"secdforest") =
    (
     pm_carbon_density_secdforest_ac(t,j,ac,"vegc")
     / s14_carbon_fraction
     * f14_aboveground_fraction("secdforest")
     / sum(clcl, pm_climate_class(j,clcl) * f14_ipcc_bce(clcl,"natveg"))
    )
    ;

pm_timber_yield(t,j,ac,"other") =
    (
     pm_carbon_density_other_ac(t,j,ac,"vegc")
     / s14_carbon_fraction
     * f14_aboveground_fraction("other")
     / sum(clcl, pm_climate_class(j,clcl) * f14_ipcc_bce(clcl,"natveg"))
    )
    ;

*` @stop

** Hard constraint to always have a positive number in pm_timber_yield
pm_timber_yield(t,j,ac,land_timber) = pm_timber_yield(t,j,ac,land_timber)$(pm_timber_yield(t,j,ac,land_timber) > 0) + 0.0001$(pm_timber_yield(t,j,ac,land_timber) = 0);
** Put yields to 0 where they dont exceed a minimum yield for harvest
pm_timber_yield(t,j,ac,land_natveg)$(pm_timber_yield(t,j,ac,land_natveg) < s14_minimum_wood_yield) = 0;


* Calculate growing period adaption factor based on previous croppping pattern
if (ord(t)>1,
  p14_yields_gsadapt_ratio(t,i) =
    sum((cell(i,j),w,kcr), i14_yields_calib_combined(t,j,"gsadapt",kcr,w) * pcm_area(j,w,kcr)) /
    sum((cell(i,j),w,kcr), i14_yields_calib_combined(t,j,"nogsadapt",kcr,w) * pcm_area(j,w,kcr));

  p14_yields_gsadapt_ratio_previous(t,i) =
    sum((cell(i,j),w,kcr), i14_yields_calib_combined(t-1,j,"gsadapt",kcr,w) * pcm_area(j,w,kcr)) /
    sum((cell(i,j),w,kcr), i14_yields_calib_combined(t-1,j,"nogsadapt",kcr,w) * pcm_area(j,w,kcr));

  pm_yields_gsadapt_ratio_increment(t,i) = p14_yields_gsadapt_ratio(t,i) / p14_yields_gsadapt_ratio_previous(t,i);
  p14_yields_gsadapt_ratio_cummulative(t,i) = max(1,pm_yields_gsadapt_ratio_increment(t,i)) * pm_yields_gsadapt_ratio_increment(t-1,i); 
  
else

 p14_yields_gsadapt_ratio(t,i) = 1;
 p14_yields_gsadapt_ratio_previous(t,i) = 1; 
 pm_yields_gsadapt_ratio_increment(t,i) = 1;
 p14_yields_gsadapt_ratio_cummulative(t,i) = 1;
 
);

if(s14_gsadapt2tau = 0 OR s14_use_gsadapt = 0,
  pm_yields_gsadapt_ratio_increment(t,i) = 1;
  p14_yields_gsadapt_ratio_cummulative(t,i) = 1;
);

i14_yields_calib(t,j,kcr,w) = i14_yields_calib(t,j,kcr,w)/sum(cell(i,j), p14_yields_gsadapt_ratio_cummulative(t,i));
