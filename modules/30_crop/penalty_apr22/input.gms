*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

$setglobal c30_bioen_type  all
* options: begr, betr, all

$setglobal c30_bioen_water  rainfed
* options: rainfed, irrigated, all

$setglobal c30_marginal_land  all_marginal
* options: all_marginal, q33_marginal, no_marginal

$setglobal c30_snv_target  none
* options: none, by2030, by2020

$setglobal c30_rotation_constraints  on
*options: on, off

$setglobal c30_rotation_scenario  default
*options: none,	default,	fallow,	legumes,	agroforestry,	agroecology

$setglobal c30_rotation_scenario_speed  by2050
* options: none, by2030, by2020

* Set-switch for countries affected by regional SNV policy
* Default: all iso countries selected
sets
  policy_countries30(iso) countries to be affected by SNV policy / ABW,AFG,AGO,AIA,ALA,ALB,AND,ARE,ARG,ARM,
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

********* CROPAREA INITIALISATION **********************************************

table fm_croparea(t_all,j,w,kcr) Different croparea type areas (mio. ha)
$ondelim
$include "./modules/30_crop/penalty_apr22/input/f30_croparea_w_initialisation.cs3"
$offdelim
;
m_fillmissingyears(fm_croparea,"j,w,kcr");

********* CROP-ROTATIONAL CONSTRAINT *******************************************

table f30_rotation_incentives(rota30,rotascen30) penalties for violating rotation rules (USD05MER)
$ondelim
$include "./modules/30_crop/penalty_apr22/input/f30_rotation_incentives.csv"
$offdelim
;

parameter f30_rotation_rules(rota30) Rotation min or max shares (1)
/
$ondelim
$include "./modules/30_crop/penalty_apr22/input/f30_rotation_rules.csv"
$offdelim
/
;


********* AVAILABLE CROPLAND *******************************************

scalar
s30_snv_shr   		Share of available cropland that is witheld for other land cover types (1) / 0 /
s30_snv_shr_noselect 	Share of available cropland that is witheld for other land cover types (1) / 0 /
;

table f30_avl_cropland(j,marginal_land30) Available land area for cropland (mio. ha)
$ondelim
$include "./modules/30_crop/penalty_apr22/input/avl_cropland.cs3"
$offdelim
;

table f30_avl_cropland_iso(iso,marginal_land30) Available land area for cropland at ISO level (mio. ha)
$ondelim
$include "./modules/30_crop/penalty_apr22/input/avl_cropland_iso.cs3"
$offdelim
;

table f30_scenario_fader(t_all,policy_target30) Fader for scenario implementation speed (unitless)
$ondelim
$include "./modules/30_crop/penalty_apr22/input/f30_scenario_fader.csv"
$offdelim
;
