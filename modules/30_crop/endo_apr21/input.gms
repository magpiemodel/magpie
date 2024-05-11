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

$setglobal c30_marginal_land  q33_marginal
* options: all_marginal, q33_marginal, no_marginal

$setglobal c30_snv_target  none
* options: none, by2030, by2020

$setglobal c30_rotation_constraints  on
*options: on, off

scalars
s30_snv_shr                     Share of available cropland that is witheld for other land cover types (1) / 0 /
s30_snv_shr_noselect            Share of available cropland that is witheld for other land cover types (1) / 0 /
s30_snv_scenario_start          SNV scenario start year       / 2020 /
s30_snv_scenario_target         SNV scenario target year      / 2030 /
s30_snv_relocation_data_x1      First reference value in SNV target cropland data (1) / 0.2 /
s30_snv_relocation_data_x2      Second reference value in SNV target cropland data (1) / 0.5 /
s30_rotation_scenario_start     Rotation scenario start year      / 2020 /
s30_rotation_scenario_target    Rotation scenario target year     / 2050 /
;

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

land_snv(land) land types allowed in the SNV policy / secdforest, forestry, past, other /
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
$include "./modules/30_crop/endo_apr21/input/f30_croparea_w_initialisation.cs3"
$offdelim
;
m_fillmissingyears(fm_croparea,"j,w,kcr");

********* CROP-ROTATIONAL CONSTRAINT *******************************************

parameter f30_rotation_max_shr(crp30) Maximum allowed area shares for each crop type (1)
/
$ondelim
$include "./modules/30_crop/endo_apr21/input/f30_rotation_max.csv"
$offdelim
/;
$if "%c30_rotation_constraints%" == "off" f30_rotation_max_shr(crp30) = 1;


parameter f30_rotation_min_shr(crp30) Minimum allowed area shares for each crop type (1)
/
$ondelim
$include "./modules/30_crop/endo_apr21/input/f30_rotation_min.csv"
$offdelim
/;
$if "%c30_rotation_constraints%" == "off" f30_rotation_min_shr(crp30) = 0;


********* AVAILABLE CROPLAND *******************************************


table f30_avl_cropland(j,marginal_land30) Available land area for cropland (mio. ha)
$ondelim
$include "./modules/30_crop/endo_apr21/input/avl_cropland.cs3"
$offdelim
;

table f30_avl_cropland_iso(iso,marginal_land30) Available land area for cropland at ISO level (mio. ha)
$ondelim
$include "./modules/30_crop/endo_apr21/input/avl_cropland_iso.cs3"
$offdelim
;

********* SNV TARGET CROPLAND *******************************************

table f30_snv_target_cropland(j,relocation_target30) Cropland in 2019 requiring relocation due to SNV policy (mio. ha)
$ondelim
$include "./modules/30_crop/endo_apr21/input/SNVTargetCropland.cs3"
$offdelim
;
