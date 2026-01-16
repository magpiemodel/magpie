*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


scalars
 c13_croparea_consv                      Switch for crop area conservation either in conservation priority areas or in a given share of the total croparea (0=no 1=yes) / 0 /
 c13_croparea_consv_tau_increase         Switch for tau increase on crop area conservation (0=no 1=yes) / 1 /
 s13_croparea_consv_tau_factor           Tau factor for crop area conservation / 0.8 /
 s13_croparea_consv_tau_factor_noselect  Tau factor for crop area conservation in unselected countries / 0.8 /
 s13_croparea_consv_shr                  Share of crop area in which no endogeneous yield changes are allowed due to  conservation (1) / 0 /
 s13_croparea_consv_shr_noselect         Share of crop area in which no endogeneous yield changes are allowed due to  conservation (1) / 0 /
 s13_croparea_consv_start                Croparea conservation start year        / 2025 /
 s13_croparea_consv_target               Croparea conservation target year       / 2030 /
;

sets
  croparea_consv_countries13(iso) countries to be affected by croparea conservation policy
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

parameter fm_tau1995(h) Agricultural land use intensity tau in 1995 (1)
/
$ondelim
$include "./modules/13_tc/input/fm_tau1995.cs4"
$offdelim
/;

$setglobal c13_tccost  medium

table f13_tc_factor(t_all,scen13) Regression factor (USD17MER per ha)
$ondelim
$include "./modules/13_tc/input/f13_tc_factor.cs3"
$offdelim
;

table f13_tc_exponent(t_all,scen13) Regression exponent (1)
$ondelim
$include "./modules/13_tc/input/f13_tc_exponent.cs3"
$offdelim
;


table f13_tau_scenario(t_all,h,tautype) tau scenario (1)
$ondelim
$include "./modules/13_tc/input/f13_tau_scenario.csv"
$offdelim
;

table f13_pastr_tau_hist(t_all,h) Historical managed pasture tau (1)
$ondelim
$include "./modules/13_tc/input/f13_pastr_tau_hist.csv"
$offdelim
;
