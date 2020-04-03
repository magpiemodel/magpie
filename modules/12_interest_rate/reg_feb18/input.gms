*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

$setglobal c12_interest_rate  medium

* Set-switch for countries affected by country-specific interest rate scenario
* Default: all iso countries selected
sets
  gdp_countries12(iso) countries to be affected by chosen interest rate scenario / ABW,AFG,AGO,AIA,ALA,ALB,AND,ARE,ARG,ARM,ASM,ATA,ATF,ATG,AUS,AZE,
BDI,BEN,BES,BFA,BGD,BHR,BHS,BIH,BLM,BLR,BLZ,BMU,BOL,BRA,BRB,BRN,BTN,BVT,BWA,CAF,CAN,
CCK,CHN,CHE,CHL,CIV,CMR,COD,COG,COK,COL,COM,CPV,CRI,CUB,CUW,CXR,CYM,DJI,DMA,DOM,DZA,
ECU,EGY,ERI,ESH,ETH,FJI,FLK,FRO,FSM,GAB,GEO,GGY,GHA,GIB,GIN,GLP,GMB,GNB,GNQ,GRD,GRL,
GTM,GUF,GUM,GUY,HKG,HMD,HND,HTI,IDN,IMN,IND,IOT,IRN,IRQ,ISL,ISR,JAM,JEY,JOR,JPN,KAZ,
KEN,KGZ,KHM,KIR,KNA,KOR,KWT,LAO,LBN,LBR,LBY,LCA,LIE,LKA,LSO,MAC,MAF,MAR,MCO,MDA,MDG,
MDV,MEX,MHL,MKD,MLI,MMR,MNE,MNG,MNP,MOZ,MRT,MSR,MTQ,MUS,MWI,MYS,MYT,NAM,NCL,NER,NFK,
NGA,NIC,NIU,NOR,NPL,NRU,NZL,OMN,PAK,PAN,PCN,PER,PHL,PLW,PNG,PRI,PRK,PRY,PSE,PYF,QAT,
REU,RUS,RWA,SAU,SDN,SEN,SGP,SGS,SHN,SJM,SLB,SLE,SLV,SMR,SOM,SPM,SRB,SSD,STP,SUR,SWZ,
SXM,SYC,SYR,TCA,TCD,TGO,THA,TJK,TKL,TKM,TLS,TON,TTO,TUN,TUR,TUV,TWN,TZA,UGA,UKR,UMI,
URY,USA,UZB,VAT,VCT,VEN,VGB,VIR,VNM,VUT,WLF,WSM,YEM,ZAF,ZMB,ZWE /
;

table f12_interest_bound(t,bound12) Lower and higher bounds of interest rates (% per yr)
$ondelim
$include "./modules/12_interest_rate/input/f12_interest_rate_bound.cs3"
$offdelim
;

table f12_interest(t_all,scen12)  Interest rate scenarios (% per yr)
$ondelim
$include "./modules/12_interest_rate/input/f12_interest_rate.cs3"
$offdelim
;

scalars
  s12_interest_noselect   Interest rate scenario chosen for regional interest rate scenario switch (1) / 0.02 /
;

$if "%c12_interest_rate%" == "coupling" parameter f12_interest_coupling(t_all) Interest rate (% per yr)
$if "%c12_interest_rate%" == "coupling" /
$if "%c12_interest_rate%" == "coupling" $ondelim
$if "%c12_interest_rate%" == "coupling" $include "./modules/12_interest_rate/input/f12_interest_rate_coupling.csv"
$if "%c12_interest_rate%" == "coupling" $offdelim
$if "%c12_interest_rate%" == "coupling" /
$if "%c12_interest_rate%" == "coupling" ;
