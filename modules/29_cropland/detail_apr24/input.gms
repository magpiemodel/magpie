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
 s29_cost_treecover_est          Tree cover establishment cost (USD05MER per ha) / 2000 /
 s29_cost_treecover_recur        Tree cover recurring cost (USD05MER per ha) / 500 /
 s29_treecover_plantation        Growth curve switch for tree cover on cropland 0=natveg 1=plantations (1) / 0 /
 s29_treecover_bii_coeff         BII coefficent to be used for tree cover on cropland 0=secondary vegetation 1=timber plantations (1) / 0 /
 s29_treecover_scenario_start    Cropland treecover scenario start year       / 2025 /
 s29_treecover_scenario_target   Cropland treecover scenario target year      / 2050 /
 s29_treecover_target            Minimum share of treecover on total cropland in target year (1) / 0 /
 s29_treecover_target_noselect   Minimum share of treecover on total cropland in target year (1) / 0 /
 s29_treecover_keep              Avoid loss of existing treecover (1=yes 0=no) / 0 /
 s29_treecover_max               Maximum share of treecover on total cropland (1) / 0.4 /
 s29_treecover_penalty_before    Penalty for violation of treecover target before scenario start (USD05MER per ha) / 0 /
 s29_treecover_penalty           Penalty for violation of treecover target after sceanrio start (USD05MER per ha) / 5000 /
 s29_fallow_scenario_start       Fallow land scenario start year       / 2025 /
 s29_fallow_scenario_target      Fallow land scenario target year      / 2050 /
 s29_fallow_target               Minimum share of fallow land on total cropland in target year (1) / 0 /
 s29_fallow_max                  Maximum share of fallow land on total cropland (1) / 0.4 /
 s29_fallow_penalty              Penalty for violation of fallow target (USD05MER per ha) / 500 /
 s29_treecover_map               Treecover map for initialization (binary) / 0 /
 s29_fader_functional_form       Switch for functional form of faders (1) / 2 /
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

********* Cropland tree cover *******************************************

parameter f29_treecover(j) Tree cover on cropland in 2015 (mio. ha)
/
$ondelim
$include "./modules/29_cropland/input/CroplandTreecover.cs2"
$offdelim
/
;
