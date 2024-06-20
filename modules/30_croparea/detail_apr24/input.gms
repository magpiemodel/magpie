*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

$setglobal c30_bioen_type  all
* options: begr, betr, all

$setglobal c30_bioen_water  rainfed
* options: rainfed, irrigated, all

$setglobal c30_rotation_rules  default
*options: min, default, good, good_20div, setaside, legumes, sixfoldrotation, agroecology, FSEC

$setglobal c30_rotation_incentives  none
*options: none, default, legumes, agroecology


scalars
 s30_rotation_scenario_start     Rotation scenario start year      / 2025 /
 s30_rotation_scenario_target    Rotation scenario target year     / 2050 /
 s30_implementation              Switch for rule-based (1) or penalty-based (0) implementation of rotation scenarios / 1 /
 s30_betr_scenario_start         Bioenergy land scenario start year       / 2025 /
 s30_betr_scenario_target        Bioenergy land scenario target year      / 2050 /
 s30_betr_start                  Share of bioenergy land on total cropland in start year (1) / 0 /
 s30_betr_start_noselect         Share of bioenergy land on total cropland in start year (1) / 0 /
 s30_betr_target                 Share of bioenergy land on total cropland in target year (1) / 0 /
 s30_betr_target_noselect        Share of bioenergy land on total cropland in target year (1) / 0 /
 s30_betr_penalty                Penalty for violation of betr target (USD05MER per ha) / 2000 /
 s30_annual_max_growth Max annual cropland growth as share of previous cropland (1) / Inf /
;

* Set-switch for countries affected by certain policies
* Default: all iso countries selected
sets
  policy_countries30(iso) countries to be affected by SNV policy 
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

$ifthen "%c30_bioen_type%" == "all" bioen_type_30(kbe30) = yes;
$else bioen_type_30("%c30_bioen_type%") = yes;
$endif

$ifthen "%c30_bioen_water%" == "all" bioen_water_30(w) = yes;
$else bioen_water_30("%c30_bioen_water%") = yes;
$endif

********* CROPAREA INITIALISATION **********************************************

table fm_croparea(t_all,j,w,kcr) Different croparea type areas (mio. ha)
$ondelim
$include "./modules/30_croparea/detail_apr24/input/f30_croparea_w_initialisation.cs3"
$offdelim
;
m_fillmissingyears(fm_croparea,"j,w,kcr");

********* CROP-ROTATIONAL CONSTRAINT *******************************************

table f30_rotation_incentives(rota30,incentscen30) penalties for violating rotation rules (USD05MER)
$ondelim
$include "./modules/30_croparea/detail_apr24/input/f30_rotation_incentives.csv"
$offdelim
;

table f30_rotation_rules(rota30,rotascen30) Rotation min or max shares (1)
$ondelim
$include "./modules/30_croparea/detail_apr24/input/f30_rotation_rules.csv"
$offdelim
;

