*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

$setglobal c29_marginal_land  q33_marginal
* options: all_marginal, q33_marginal, no_marginal

scalars
 s29_snv_shr                     Share of available cropland that is witheld for other land cover types (1) / 0 /
 s29_snv_shr_noselect            Share of available cropland that is witheld for other land cover types (1) / 0 /
 s29_snv_scenario_start          SNV scenario start year       / 2025 /
 s29_snv_scenario_target         SNV scenario target year      / 2050 /
 s29_snv_relocation_data_x1      First reference value in SNV target cropland data (1) / 0.2 /
 s29_snv_relocation_data_x2      Second reference value in SNV target cropland data (1) / 0.5 /
;

* Set-switch for countries affected by certain policies
* Default: all iso countries selected
sets
  policy_countries29(iso) countries to be affected by SNV policy 
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

land_snv(land) land types allowed in the SNV policy / secdforest, forestry, past, other /
;

********* AVAILABLE CROPLAND *******************************************

table f29_avl_cropland(j,marginal_land29) Available land area for cropland (mio. ha)
$ondelim
$include "./modules/29_cropland/input/avl_cropland.cs3"
$offdelim
;

table f29_avl_cropland_iso(iso,marginal_land29) Available land area for cropland at ISO level (mio. ha)
$ondelim
$include "./modules/29_cropland/input/avl_cropland_iso.cs3"
$offdelim
;

********* SNV TARGET CROPLAND *******************************************

table f29_snv_target_cropland(j,relocation_target29) Cropland in 2019 requiring relocation due to SNV policy (mio. ha)
$ondelim
$include "./modules/29_cropland/input/SNVTargetCropland.cs3"
$offdelim
;
