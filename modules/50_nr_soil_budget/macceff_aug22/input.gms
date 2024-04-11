*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

* Scenario for nr efficiency on croplands or pastures for selected (and
* respectively non-selected) countries in cropneff_countries and pastneff_countries

$setglobal c50_scen_neff  baseeff_add3_add5_add10_max65
$setglobal c50_scen_neff_noselect  baseeff_add3_add5_add10_max65
* constant, baseeff_add3_add15_add25_max75,
* baseeff_add3_add15_add25_max65, baseeff_add3_add10_add20_max75,
* baseeff_add3_add5_add10_max65, baseeff_add3_add0_add0_max55,
* baseeff_add3_add10_add15_max75, baseeff_add3_add5_add15_max75,
* maxeff_add3_glo75_glo85, maxeff_add3_glo75_glo80,
* maxeff_add3_glo60_glo65, maxeff_add3_glo65_glo75,
* maxeff_ZhangBy2030, maxeff_ZhangBy2050 /

$setglobal c50_scen_neff_pasture  constant_min55_min60_min65
$setglobal c50_scen_neff_pasture_noselect  constant_min55_min60_min65
* constant, constant_min55_min60_min65

$setglobal c50_dep_scen  history
*   options:   history

scalar
      s50_fertilizer_costs Costs of fertilizer (USD05MER per tN)            / 600 /
      s50_maccs_global_ef Do maccs assume global emission factor (binary)    /1/
      s50_maccs_implicit_nue_glo Global nitrogen use efficiency implicit to MACCs /0.5/
;

* Set-switch for countries affected by country-specific neff scenarios
* Default: all iso countries selected
sets
  cropneff_countries(iso)   countries to be affected by chosen crop neff scenario / ABW,AFG,AGO,AIA,ALA,ALB,AND,ARE,ARG,ARM,
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
  pastneff_countries(iso)   countries to be affected by chosen pasture neff scenario / ABW,AFG,AGO,AIA,ALA,ALB,AND,ARE,ARG,ARM,
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

parameter f50_snupe_base(t_all,i,scen_neff_cropland50)  selected scenario values for soil nitrogen uptake efficiency (1)
/
$ondelim
$include "./modules/50_nr_soil_budget/input/f50_snupe_base.cs4"
$offdelim
/;

parameter f50_nue_base_pasture(t_all,i,scen_neff_pasture50)  selected scenario values for soil nitrogen uptake efficiency (1)
/
$ondelim
$include "./modules/50_nr_soil_budget/input/f50_nue_base_pasture.cs4"
$offdelim
/;


parameter f50_nr_fix_ndfa(t_all,i,kcr) Nr fixation rates per Nr in plant biomass (tNr per tNr)
/
$ondelim
$include "./modules/50_nr_soil_budget/input/f50_ndfa.cs4"
$offdelim
/;

parameter f50_nitrogen_balanceflow(t_all,i) Balancelfow to account for unrealistically high SNUpEs on croplands (mio. tNr per yr)
/
$ondelim
$include "./modules/50_nr_soil_budget/input/f50_nitrogen_balanceflow.cs4"
$offdelim
/;

parameter f50_nitrogen_balanceflow_pasture(t_all,i) Balancelfow to account for unrealistically high NUE on pastures (mio. tNr per yr)
/
$ondelim
$include "./modules/50_nr_soil_budget/input/f50_nitrogen_balanceflow_pasture.cs4"
$offdelim
/;


parameter f50_nr_fix_area(kcr) Nr fixation rates per area (tNr per ha)
/
$ondelim
$include "./modules/50_nr_soil_budget/input/f50_fixation_freeliving.cs4"
$offdelim
/;

parameter f50_nr_fixation_rates_pasture(t_all,i) Nr fixation rates per pasture area (tNr per ha)
/
$ondelim
$include "./modules/50_nr_soil_budget/input/f50_nitrogen_fixation_rates_pasture.cs4"
$offdelim
/;

table f50_atmospheric_deposition_rates(t_all,j,land,dep_scen50) Nr deposition rates per area (tNr per ha)
$ondelim
$include "./modules/50_nr_soil_budget/input/f50_AtmosphericDepositionRates.cs3"
$offdelim
;
