*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

$setglobal c35_protect_scenario  WDPA
$setglobal c35_protect_scenario_noselect  WDPA
$setglobal c35_protect_fadein  by2030
$setglobal c35_ad_policy  npi
$setglobal c35_aolc_policy  npi
$setglobal c35_forest_damage_end  by2050

scalars
s35_hvarea Flag for harvested area (0=zero 1=exognous 2=endogneous)	/ 0 /
s35_hvarea_secdforest annual secdforest harvest rate for s35_hvarea equals 1 (percent per year) / 0.005 /
s35_hvarea_primforest annual primforest harvest rate for s35_hvarea equals 1 (percent per year) / 0.0001 /
s35_hvarea_other annual other land harvest rate for s35_hvarea equals 1 (percent per year) / 0 /
s35_timber_harvest_cost_secdforest   Cost for harvesting from secondary forest (USD per ha) / 2000/
s35_timber_harvest_cost_other        Cost for harvesting from other land (USD per ha) / 1500 /
s35_timber_harvest_cost_primforest   Cost for harvesting from primary forest (USD per ha) / 3000/
s35_natveg_harvest_shr Constrains the allowed wood harvest from natural vegetation (1=unconstrained) (1) /1/
s35_secdf_distribution Flag for secdf initialization (0=all secondary forest in highest age class 1=Equal distribution among all age classes 2=Poulter distribution from MODIS satellite data) (1) / 0 /
s35_forest_damage Damage simulation in forests (0=none 1=shifting agriculture 2= Damage from shifting agriculture is faded out by c35_forest_damage_end) / 2 /
;

* Set-switch for countries affected by regional land protection policy
* Default: all iso countries selected
sets
  policy_countries35(iso) countries to be affected by land protection policy / ABW,AFG,AGO,AIA,ALA,ALB,AND,ARE,ARG,ARM,
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


table f35_protection_fader(t_all, prot_target35) Protection scenario fader (1)
$ondelim
$include "./modules/35_natveg/input/f35_protection_fader.csv"
$offdelim
;

table f35_protect_area(j,prot_type) Conservation priority areas (mio. ha)
$ondelim
$include "./modules/35_natveg/input/protect_area.cs3"
$offdelim
;

table f35_min_land_stock(t_all,j,pol35,pol_stock35) Land protection policies [minimum land stock] (Mha)
$ondelim
$include "./modules/35_natveg/input/npi_ndc_ad_aolc_pol.cs3"
$offdelim
;

table f35_forest_lost_share(i,driver_source) Share of area damanged by forest fires (1)
$ondelim
$include "./modules/35_natveg/input/f35_forest_lost_share.cs3"
$offdelim
;

table f35_land_iso(t_ini10,iso,land) Land area for different land pools at ISO level (mio. ha)
$ondelim
$include "./modules/35_natveg/input/avl_land_t_iso.cs3"
$offdelim;

parameter f35_forest_disturbance_share(i) Share of area damanged by forest disturbances (1)
/
$ondelim
$include "./modules/35_natveg/input/f35_forest_disturbance_share.cs4"
$offdelim
/;

parameter f35_gs_relativetarget(i) Relative growing stock target in each region (m3 per ha)
/
$ondelim
$include "./modules/35_natveg/input/f35_gs_relativetarget.cs4"
$offdelim
/;
