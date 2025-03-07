*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

scalars
  s58_cost_rewet_recur           Recurring costs for rewetted peatland (USD17MER per ha) / 37 /
  s58_cost_rewet_onetime         One-time costs for peatland rewetting (USD17MER per ha) / 1230 /
  s58_cost_drain_recur           Recurring costs for drained and managed peatlands (USD17MER per ha) / 0 /
  s58_cost_drain_intact_onetime  One-time costs for drainage of intact peatland (USD17MER per ha) / 1230 /
  s58_cost_drain_rewet_onetime   One-time costs for drainage of rewetted peatland (USD17MER per ha) / 0 /
  s58_rewetting_switch           Peatland rewetting on (Inf) or off (0) / Inf /
  s58_fix_peatland               Year indicating until when peatland area should be fixed (year) / 2020 /
  s58_balance_penalty            Penalty for technical peatland balance term (USD17MER) / 1e+06 /
  s58_rewetting_exo              Switch for exogenous peatland rewetting for selected countries (1) / 0 /
  s58_rewetting_exo_noselect     Switch for exogenous peatland rewetting for all other countries (1) / 0 /
  s58_rewet_exo_start_year       Start year for exogenous peatland rewetting (1) / 2030 /
  s58_rewet_exo_target_year      Target year for exogenous peatland rewetting (1) / 2050 /
  s58_rewet_exo_start_value      Start value for exogenous peatland rewetting as share of drained peatland in reference period (1) / 0.3 /
  s58_rewet_exo_target_value     Target value for exogenous peatland rewetting as share of drained peatland in reference period (1) / 0.5 /
  s58_intact_prot_exo            Switch for exogenous protection of intact peatland for selected countries (1) / 0 /
  s58_intact_prot_exo_noselect   Switch for exogenous protection of intact peatland for all other countries (1) / 0 /
  s58_annual_rewetting_limit     Share of drained peatland that can be rewetted per year (1) / 0.02 /
;

* Set-switch for countries affected by certain policies
* Default: all iso countries selected
sets
  policy_countries58(iso) countries to be affected by exogenous peatland rewetting 
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

*Peatland area based on Global Peatland Map 2.0 and Global Peatland Database
table f58_peatland_area(j,land58) Peatland area (mio. ha)
$ondelim
$include "./modules/58_peatland/input/f58_peatland_area.cs3"
$offdelim
;

*Peatland area based on Global Peatland Map 2.0 and Global Peatland Database
table f58_peatland_area_iso(iso,land58) Peatland area (mio. ha)
$ondelim
$include "./modules/58_peatland/input/f58_peatland_area_iso.cs3"
$offdelim
;

*Wetland GHG emission factors based on IPCC Wetlands 2014 and Tiemeyer et al. 2020 
table f58_ipcc_wetland_ef(clcl58,land58,emis58) Wetland emission factors (Tg per yr)
$ondelim
$include "./modules/58_peatland/input/f58_ipcc_wetland_ef2.cs3"
$offdelim
;
