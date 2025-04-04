*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

vm_dem_bioen.fx(i,kap) = 0;
v60_2ndgen_bioenergy_dem_dedicated.fx(i,kall) = 0;
v60_2ndgen_bioenergy_dem_dedicated.up(i,kbe60) = Inf;
v60_2ndgen_bioenergy_dem_residues.fx(i,kall) = 0;
v60_2ndgen_bioenergy_dem_residues.up(i,kres) = Inf;

if(m_year(t) <= sm_fix_SSP2,
  i60_1stgen_bioenergy_dem(t,i,kall) = 
    f60_1stgen_bioenergy_dem(t,i,"const2020",kall);
  i60_res_2ndgenBE_dem(t,i) =
    f60_res_2ndgenBE_dem(t,i,"ssp2");
  i60_1stgen_bioenergy_subsidy(t) =
    s60_bioenergy_1st_subsidy;
  i60_2ndgen_bioenergy_subsidy(t) = 0;
else
  i60_1stgen_bioenergy_dem(t,i,kall) =
    f60_1stgen_bioenergy_dem(t,i,"%c60_1stgen_biodem%",kall);
  i60_res_2ndgenBE_dem(t,i) =
    f60_res_2ndgenBE_dem(t,i,"%c60_res_2ndgenBE_dem%");
);

$ifthen "%c60_price_implementation%" == "exp"
  if(m_year(t) > sm_fix_SSP2,
    i60_1stgen_bioenergy_subsidy(t) = 
      (s60_bioenergy_1st_price / 8) * (8 ** (1 / (2100 - sm_fix_SSP2))) ** (m_year(t) - sm_fix_SSP2);
    i60_2ndgen_bioenergy_subsidy(t) =
      (s60_bioenergy_2nd_price / 8) * (8 ** (1 / (2100 - sm_fix_SSP2))) ** (m_year(t) - sm_fix_SSP2);
  );
$elseif "%c60_price_implementation%" == "const"
  if(m_year(t) > sm_fix_SSP2,
    i60_1stgen_bioenergy_subsidy(t) = 
      s60_bioenergy_1st_price;
    i60_2ndgen_bioenergy_subsidy(t) =
      s60_bioenergy_2nd_price;
  );
$else
  if(m_year(t) > sm_fix_SSP2,
    i60_1stgen_bioenergy_subsidy(t) = 
      s60_bioenergy_1st_price / (2100 - sm_fix_SSP2) * (m_year(t) - sm_fix_SSP2);
    i60_2ndgen_bioenergy_subsidy(t) =
      s60_bioenergy_2nd_price / (2100 - sm_fix_SSP2) * (m_year(t) - sm_fix_SSP2);
  );
$endif

* Enforce floor for first generation bioenergy subsidy
i60_1stgen_bioenergy_subsidy(t)$(i60_1stgen_bioenergy_subsidy(t) < s60_bioenergy_1st_subsidy) 
  = s60_bioenergy_1st_subsidy;

* Add minimal bioenergy demand in case of zero demand or very small demand to avoid zero prices
i60_bioenergy_dem(t,i)$(i60_bioenergy_dem(t,i) < s60_2ndgen_bioenergy_dem_min) = s60_2ndgen_bioenergy_dem_min;
