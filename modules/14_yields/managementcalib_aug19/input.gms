*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

$setglobal c14_yields_scenario  cc
*   options:  cc        (climate change)
*             nocc      (no climate change)
*             nocc_hist (no climate change after year defined by sm_fix_cc)


scalars
s14_limit_calib                    Relative managament calibration switch (1=limited 0=pure relative) / 1 /
s14_calib_ir2rf                    Switch to calibrate rainfed to irrigated yield ratios (1=calib 0=not calib) / 1 /
s14_degradation                    Switch to include yield impacts of land degradation(0=no degradation 1=with degradation) / 0 /
s14_use_yield_calib                Switch for using or not using yield calibration factors from the preprocessing (1=use facs 0=not use facs) / 0 /
c14_croparea_consv                 Switch for crop area conservation either in conservation priority areas or in a given share of the total croparea (0=no 1=yes) / 1 /
c14_croparea_consv_tau_increase    Switch for tau increase on crop area conservation (0=no 1=yes) / 1 /
s14_croparea_consv_tau_factor      Tau factor for crop area conservation / 0.8 /
s14_croparea_consv_shr             Share of crop area in which no endogeneous yield changes are allowed due to conservation (1) / 0 /
s14_croparea_consv_shr_noselect    Share of crop area in which no endogeneous yield changes are allowed due to conservation (1) / 0 /
s14_croparea_consv_start           Croparea conservation start year        / 2025 /
s14_croparea_consv_target          Croparea conservation target year       / 2030 /
s14_minimum_wood_yield             Minimum wood yield for timber harvest in natural vegetation (tDM per ha per yr) / 10 /
s14_yld_past_switch                Spillover parameter for translating technological change in the crop sector into pasture yieldincreases  (1)     / 0.25 /
s14_yld_reduction_soil_loss        Decline of land productivity in areas with severe soil loss (1)     / 0.08 /
s14_carbon_fraction                Carbon fraction for conversion of biomass to dry matter (1) / 0.5/
;

sets
  croparea_consv_countries14(iso) countries to be affected by croparea conservation policy
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

******* Calibration factor
$onEmpty
table f14_yld_calib(i,ltype14) Calibration factor for the LPJmL yields (1)
$ondelim
$if exist "./modules/14_yields/input/f14_yld_calib.csv" $include "./modules/14_yields/input/f14_yld_calib.csv"
$offdelim
;
$offEmpty

table f14_yields(t_all,j,kve,w) LPJmL potential yields per cell (rainfed and irrigated) (tDM per ha per yr)
$ondelim
$include "./modules/14_yields/input/lpj_yields.cs3"
$offdelim
;
* set values to 1995 if nocc scenario is used, or to sm_fix_cc after sm_fix_cc if nocc_hist is used
$if "%c14_yields_scenario%" == "nocc" f14_yields(t_all,j,kve,w) = f14_yields("y1995",j,kve,w);
$if "%c14_yields_scenario%" == "nocc_hist" f14_yields(t_all,j,kve,w)$(m_year(t_all) > sm_fix_cc) = f14_yields(t_all,j,kve,w)$(m_year(t_all) = sm_fix_cc);
m_fillmissingyears(f14_yields,"j,kve,w");

table f14_pyld_hist(t_all,i) Modelled regional pasture yields in the past (tDM per ha per yr)
$ondelim
$include "./modules/14_yields/input/f14_pasture_yields_hist.csv"
$offdelim;


table f14_fao_yields_hist(t_all,i,kcr) FAO yields per region (tDM per ha per yr)
$ondelim
$include "./modules/14_yields/managementcalib_aug19/input/f14_region_yields.cs3"
$offdelim
;
m_fillmissingyears(f14_fao_yields_hist,"i,kcr");

parameter f14_ir2rf_ratio(i) AQUASTAT ratio of irrigated to rainfed yields per region (1)
/
$ondelim
$include "./modules/14_yields/managementcalib_aug19/input/f14_ir2rf_ratio.cs4"
$offdelim
/
;

table f14_ipcc_bce(clcl,forest_type) IPCC Biomass Conversion and Expansion factors (1)
$ondelim
$include "./modules/14_yields/input/f14_ipcc_bce.cs3"
$offdelim
;

parameter f14_aboveground_fraction(land_timber) Root to shoot ratio (1)
/
$ondelim
$include "./modules/14_yields/input/f14_aboveground_fraction.csv"
$offdelim
/
;

$onEmpty
table f14_yld_ncp_report(t_all,j,ncp_type14) Share of land with intact natures contributions to people (NCP) (1)
$ondelim
$if exist "./modules/14_yields/input/f14_yld_ncp_report.cs3" $include "./modules/14_yields/input/f14_yld_ncp_report.cs3"
$offdelim
;
$offEmpty

parameter f14_kcr_pollinator_dependence(kcr) Share of total yield dependent on biotic pollination (1)
/
$ondelim
$include "./modules/14_yields/input/f14_kcr_pollinator_dependence.csv"
$offdelim
/
;
