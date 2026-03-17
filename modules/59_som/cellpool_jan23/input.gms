*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

scalars
  s59_nitrogen_uptake  Maximum plant available nitrogen from soil organic matter loss (tN per ha)        / 0.2 /
  s59_fader_functional_form       Switch for functional form of faders (1) / 1 / 
  s59_scm_target                  Share of soil carbon management on total cropland in target year (1) / 0 /
  s59_scm_target_noselect         Share of soil carbon management on total cropland in target year (1) / 0 /
  s59_scm_scenario_start          Soil carbon management scenario start year / 2025 /
  s59_scm_scenario_target         Soil carbon management scenario target year / 2050 /
  s59_cost_scm_recur              Soil carbon management recurring cost (USD17MER per ha) / 65 /
;

*' @code 

*' The implementation of soil carbon management on cropland refers to a diverse set of  
*' practices. According to IPCC guidelines 2006, they represent "significantly greater  
*' crop residue inputs over medium C input cropping systems due to additional practices,  
*' such as production of high residue yielding crops, use of green manures, cover crops,  
*' improved vegetated fallows, irrigation, frequent use of perennial grasses in annual  
*' crop rotations, but without manure applied."  

*' Literature estimates for the costs of these agronomic practices vary widely. Whereas  
*' Smith et al. 2008 estimates the costs of various agronomic practices at around 20  
*' USD06MER (= ~25 USD17MER) per ha, Uludere Aragon et al. 2024 found much higher costs  
*' for the individual practice of cover cropping, around 90-115 USD21MER (= ~80-105  
*' USD17MER) per ha. Uludere Aragon et al. 2024 highlights that changes in production  
*' costs—due to reduced fertilizer use or increased herbicide costs—as well as yield  
*' impacts can either raise or lower net overall farm costs. Given these uncertainties,  
*' we adopt an estimated cost of 65 USD17MER per ha, representing the midpoint between  
*' 25 and 105 USD17MER. Due to the lack of comprehensive cost data across all regions  
*' and the potential for cost changes over time in response to general economic trends,  
*' we apply a uniform cost assumption to avoid introducing large initial biases. Costs  
*' can be changed in the configuration file via `s59_cost_scm_recur` for using other 
*' assumptions.

*' @stop

table f59_cratio_landuse(i,climate59_2019,kcr) Ratio of soil carbon relative to potential natural vegetation soil carbon for different landuse (1)
$ondelim
$include "./modules/59_som/cellpool_jan23/input/f59_ch5_F_LU_2019reg.cs3"
$offdelim
;

table f59_cratio_tillage(climate59,tillage59) Ratio of soil carbon relative to potential natural vegetation soil carbon for different soil management (1)
$ondelim
$include "./modules/59_som/cellpool_jan23/input/f59_ch5_F_MG.csv"
$offdelim
;

table f59_cratio_inputs(climate59,inputs59) Ratio of soil carbon relative to potential natural vegetation soil carbon for different input intensity  (1)
$ondelim
$include "./modules/59_som/cellpool_jan23/input/f59_ch5_F_I.csv"
$offdelim
;

$setglobal c59_irrigation_scenario  on
*   options:   on  (higher carbon sequestration under irrigation)
*              off (no carbon sequestration under irrigation)

table f59_cratio_irrigation(climate59,w,kcr) Ratio of soil carbon relative to potential natural vegetation soil carbon for different irrigation schemes  (1)
$ondelim
$include "./modules/59_som/cellpool_jan23/input/f59_ch5_F_IRR.cs3"
$offdelim
;
$if "%c59_irrigation_scenario%" == "off" f59_cratio_irrigation(climate59,w,kcr) = 1;

$setglobal c59_som_scenario  cc
*   options:  cc        (climate change)
*             nocc      (no climate change)
*             nocc_hist (no climate change after year defined by sm_fix_cc)

parameters f59_topsoilc_density(t_all,j) LPJ topsoil carbon density for natural vegetation (tC per ha)
/
$ondelim
$include "./modules/59_som/input/lpj_carbon_topsoil.cs2b"
$offdelim
/
;
$if "%c59_som_scenario%" == "nocc" f59_topsoilc_density(t_all,j) = f59_topsoilc_density("y1995",j);
$if "%c59_som_scenario%" == "nocc_hist" f59_topsoilc_density(t_all,j)$(m_year(t_all) > sm_fix_cc) = f59_topsoilc_density(t_all,j)$(m_year(t_all) = sm_fix_cc);
m_fillmissingyears(f59_topsoilc_density,"j");

* Set-switch for countries affected by certain policies
* Default: all iso countries selected
sets
  policy_countries59(iso) countries to be affected by SNV policy 
                    / ABW,AFG,AGO,AIA,ALA,ALB,AND,ARE,ARG,ARM,
                      ASM,ATA,ATF,ATG,AUS,AUT,AZE,BDI,BEL,BEN,
                      BES,BFA,BGD,BGR,BHR,BHS,BIH,BLM,BLR,BLZ,
                      BMU,BOL,BRA,BRB,BRN,BTN,BVT,BWA,CAF,CAN,
                      CCK,CHN,CHE,CHL,CIV,CMR,COD,COG,COK,COL,
                      COM,CPV,CRI,CUB,CUW,CXR,CYM,CYP,CZE,DEU,
                      DJI,DMA,DNK,DOM,DZA,ECU,EGY,ERI,ESH,ESP,
                      EST,ETH,FIN,FJI,FLK,FRA,FRO,FSM,GAB,GBR,
                      GEO,GGY,GHA,GIB,GIN,GLP,GMB,GNB,GNQ,GRC,
                      GRD,GRL,GTM,GUF,GUM,GUY,HKG,HMD,HND,HRV,
                      HTI,HUN,IDN,IMN,IND,IOT,IRL,IRN,IRQ,ISL,
                      ISR,ITA,JAM,JEY,JOR,JPN,KAZ,KEN,KGZ,KHM,
                      KIR,KNA,KOR,KWT,LAO,LBN,LBR,LBY,LCA,LIE,
                      LKA,LSO,LTU,LUX,LVA,MAC,MAF,MAR,MCO,MDA,
                      MDG,MDV,MEX,MHL,MKD,MLI,MLT,MMR,MNE,MNG,
                      MNP,MOZ,MRT,MSR,MTQ,MUS,MWI,MYS,MYT,NAM,
                      NCL,NER,NFK,NGA,NIC,NIU,NLD,NOR,NPL,NRU,
                      NZL,OMN,PAK,PAN,PCN,PER,PHL,PLW,PNG,POL,
                      PRI,PRK,PRT,PRY,PSE,PYF,QAT,REU,ROU,RUS,
                      RWA,SAU,SDN,SEN,SGP,SGS,SHN,SJM,SLB,SLE,
                      SLV,SMR,SOM,SPM,SRB,SSD,STP,SUR,SVK,SVN,
                      SWE,SWZ,SXM,SYC,SYR,TCA,TCD,TGO,THA,TJK,
                      TKL,TKM,TLS,TON,TTO,TUN,TUR,TUV,TWN,TZA,
                      UGA,UKR,UMI,URY,USA,UZB,VAT,VCT,VEN,VGB,
                      VIR,VNM,VUT,WLF,WSM,YEM,ZAF,ZMB,ZWE /
;
