*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*************************BASIC SETS (INDICES)***********************************

*###############################################################################
*######################## R SECTION START (SETS) ###############################
*THIS CODE IS CREATED AUTOMATICALLY, DO NOT MODIFY THESE LINES DIRECTLY
*ANY DIRECT MODIFICATION WILL BE LOST AFTER NEXT INPUT DOWNLOAD
*CHANGES CAN BE DONE USING THE INPUT DOWNLOADER UNDER SCRIPTS/DOWNLOAD
*THERE YOU CAN ALSO FIND ADDITIONAL INFORMATION

sets

   i all economic regions /ANZ,CHN,EUR,FSU,IND,MEN,OAS,OSA,SEA,SSA,USA,XAS,XEA,XEE,XLV,XNA,XPR,XSA/

   iso list of iso countries /
       ABW,AFG,AGO,AIA,ALA,ALB,AND,ARE,ARG,ARM,
       ASM,ATA,ATF,ATG,AUS,AUT,AZE,BDI,BEL,BEN,
       BES,BFA,BGD,BGR,BHR,BHS,BIH,BLM,BLR,BLZ,
       BMU,BOL,BRA,BRB,BRN,BTN,BVT,BWA,CAF,CAN,
       CCK,CHE,CHL,CHN,CIV,CMR,COD,COG,COK,COL,
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

   j number of LPJ cells /
       ANZ_1*ANZ_21,
       CHN_22*CHN_42,
       EUR_43*EUR_52,
       FSU_53*FSU_58,
       IND_59*IND_65,
       MEN_66*MEN_78,
       OAS_79*OAS_89,
       OSA_90*OSA_130,
       SEA_131*SEA_140,
       SSA_141*SSA_151,
       USA_152*USA_160,
       XAS_161*XAS_165,
       XEA_166*XEA_172,
       XEE_173*XEE_173,
       XLV_174*XLV_176,
       XNA_177*XNA_182,
       XPR_183*XPR_197,
       XSA_198*XSA_200/

   cell(i,j) number of LPJ cells per region i
      /
       ANZ . ANZ_1*ANZ_21
       CHN . CHN_22*CHN_42
       EUR . EUR_43*EUR_52
       FSU . FSU_53*FSU_58
       IND . IND_59*IND_65
       MEN . MEN_66*MEN_78
       OAS . OAS_79*OAS_89
       OSA . OSA_90*OSA_130
       SEA . SEA_131*SEA_140
       SSA . SSA_141*SSA_151
       USA . USA_152*USA_160
       XAS . XAS_161*XAS_165
       XEA . XEA_166*XEA_172
       XEE . XEE_173*XEE_173
       XLV . XLV_174*XLV_176
       XNA . XNA_177*XNA_182
       XPR . XPR_183*XPR_197
       XSA . XSA_198*XSA_200
      /

   i_to_iso(i,iso) mapping regions to iso countries
      /
       ANZ . (ASM,AUS,NFK,NZL)
       CHN . (CHN,HKG,MAC)
       EUR . (ALA,ALB,AND,AUT,BEL,BGR,BIH,CHE,CYP,CZE)
       EUR . (DEU,DNK,EST,FIN,FRO,GBR,GGY,GIB,GRC,GRL)
       EUR . (HRV,HUN,IMN,IRL,ISL,ITA,JEY,LIE,LTU,LUX)
       EUR . (LVA,MCO,MKD,MLT,MNE,NLD,NOR,POL,ROU,SJM)
       EUR . (SMR,SPM,SRB,SVK,SVN,SWE,UMI,VAT)
       FSU . (ARM,AZE,BLR,GEO,KAZ,KGZ,RUS,TJK,TKM,UZB)
       IND . (IND)
       MEN . (ARE,BHR,DZA,EGY,ESH,IRN,IRQ,ISR,JOR,KWT)
       MEN . (LBN,LBY,MAR,OMN,PSE,QAT,SAU,SYR,TUN,TUR)
       MEN . (YEM)
       OAS . (AFG,BTN,COK,FJI,FSM,IOT,KIR,MDV,MHL,MNG)
       OAS . (NCL,NIU,NRU,PAK,PLW,PNG,PYF,SLB,TKL,TON)
       OAS . (TUV,VUT,WLF,WSM)
       OSA . (ABW,AIA,ATA,ATG,BES,BHS,BLM,BLZ,BMU,BRB)
       OSA . (CHL,COL,CRI,CUB,CUW,CYM,DMA,DOM,ECU,FLK)
       OSA . (GLP,GRD,GTM,GUF,GUY,HND,HTI,JAM,KNA,LCA)
       OSA . (MAF,MEX,MSR,MTQ,NIC,PAN,PER,PRI,SGS,SLV)
       OSA . (SUR,SXM,TCA,TTO,VCT,VEN,VGB,VIR)
       SEA . (BRN,CCK,CXR,GUM,IDN,KHM,LAO,MMR,MNP,MYS)
       SEA . (PCN,PRK,SGP,THA,TLS,VNM)
       SSA . (AGO,ATF,BEN,BFA,BVT,BWA,CAF,CIV,CMR,COD)
       SSA . (COG,COM,CPV,DJI,ERI,ETH,GAB,GHA,GIN,GMB)
       SSA . (GNB,GNQ,HMD,LBR,LSO,MDG,MLI,MOZ,MRT,MUS)
       SSA . (MWI,MYT,NAM,NER,NGA,REU,SDN,SEN,SHN,SLE)
       SSA . (SOM,SSD,STP,SWZ,SYC,TCD,TGO,ZAF,ZMB,ZWE)
       USA . (USA)
       XAS . (ESP,FRA,PRT)
       XEA . (JPN,KOR,PHL,TWN)
       XEE . (MDA,UKR)
       XLV . (BDI,KEN,RWA,TZA,UGA)
       XNA . (CAN)
       XPR . (ARG,BOL,BRA,PRY,URY)
       XSA . (BGD,LKA,NPL)
      /
;
*######################### R SECTION END (SETS) ################################
*###############################################################################

sets
        i2(i) World regions (dynamic set)
        j2(j) Spatial Clusters (dynamic set)
;
i2(i) = yes;
j2(j) = yes;

sets
        c_title defined to include c_title in GDX
        / %c_title% /
;

***TIME STEPS***
* ATTENTION: check macros m_year and m_yeardiff if you change something
*            here as they need to make some assumption about these settings,
*            especially having 1965 as start year, having t2 as alias of t and
*            having ct as current time step
sets time_annual Annual extended time steps
    / y1965*y2150 /

    t_ext 5-year time periods
    /
    y1965, y1970, y1975, y1980, y1985, y1990,
    y1995, y2000, y2005, y2010, y2015, y2020, y2025, y2030, y2035, y2040,
    y2045, y2050, y2055, y2060, y2065, y2070, y2075, y2080, y2085, y2090,
    y2095, y2100, y2105, y2110, y2115, y2120, y2125, y2130, y2135, y2140,
    y2145, y2150, y2155, y2160, y2165, y2170, y2175, y2180, y2185, y2190,
    y2195, y2200, y2205, y2210, y2215, y2220, y2225, y2230, y2235, y2240,
    y2245, y2250
    /

    t_all(t_ext) 5-year time periods
    / y1965, y1970, y1975, y1980, y1985, y1990,
      y1995, y2000, y2005, y2010, y2015, y2020, y2025, y2030, y2035, y2040,
      y2045, y2050, y2055, y2060, y2065, y2070, y2075, y2080, y2085, y2090,
      y2095, y2100, y2105, y2110, y2115, y2120, y2125, y2130, y2135, y2140,
      y2145, y2150 /

    t_historical(t_all) Historical period
    /   y1965, y1970, y1975, y1980, y1985, y1990 /

    t_future(t_all) 5-year time periods
    / y2105, y2110, y2115, y2120, y2125, y2130, y2135, y2140,
      y2145, y2150 /

    t_past_forestry(t_all) Forestry Timesteps with observed data
    / y1965, y1970, y1975,
     y1980, y1985, y1990,
     y1995, y2000, y2005, y2010, y2015
    /
;

set t_past(t_all) Timesteps with observed data
$If "%c_past%"== "till_2010" /y1965, y1970, y1975, y1980, y1985, y1990,y1995, y2000, y2005, y2010/;
$If "%c_past%"== "till_1965" /y1965/;
$If "%c_past%"== "till_1975" /y1965, y1970, y1975/;
$If "%c_past%"== "till_1995" /y1965, y1970, y1975, y1980, y1985, y1990, y1995/;


set t(t_all) Simulated time periods
$If "%c_timesteps%"== "less_TS" /y1995,y2000,y2005,y2010,y2015,y2020,y2025,y2030,y2035,y2040,y2045,y2050,y2055,y2060,y2070,y2080,y2090,y2100,y2110,y2130,y2150/;
$If "%c_timesteps%"== "coup2100" /y1995,y2000,y2005,y2010,y2015,y2020,y2025,y2030,y2035,y2040,y2045,y2050,y2055,y2060,y2070,y2080,y2090,y2100/;
$If "%c_timesteps%"== "test_TS" /y1995,y2000,y2005,y2010,y2020,y2030,y2040,y2050,y2070,y2090,y2110,y2130,y2150/;
$If "%c_timesteps%"== "TS_benni" /y1995,y2000,y2005,y2010,y2020,y2030,y2040,y2050/;
$If "%c_timesteps%"== "TS_WB" /y1995,y2000,y2005,y2010,y2020,y2030,y2040,y2050,y2060,y2070,y2080/;
$If "%c_timesteps%"== "5year" /y1995,y2000,y2005,y2010,y2015,y2020,y2025,y2030,y2035,y2040,y2045,y2050,y2055,y2060,y2065,y2070,y2075,y2080,y2085,y2090,y2095,y2100/;
$If "%c_timesteps%"== "5year2050" /y1995,y2000,y2005,y2010,y2015,y2020,y2025,y2030,y2035,y2040,y2045,y2050/;
$If "%c_timesteps%"== "5year2070" /y1995,y2000,y2005,y2010,y2015,y2020,y2025,y2030,y2035,y2040,y2045,y2050,y2055,y2060,y2065,y2070/;
$If "%c_timesteps%"== "quicktest" /y1995,y2010,y2025/;
$If "%c_timesteps%"== "quicktest2" /y1995,y2020,y2050,y2100/;
$If "%c_timesteps%"== "1" /y1995/;
$If "%c_timesteps%"== "2" /y1995,y2000/;
$If "%c_timesteps%"== "3" /y1995,y2000,y2010/;
$If "%c_timesteps%"== "4" /y1995,y2000,y2010,y2020/;
$If "%c_timesteps%"== "5" /y1995,y2000,y2010,y2020,y2030/;
$If "%c_timesteps%"== "6" /y1995,y2000,y2010,y2020,y2030,y2040/;
$If "%c_timesteps%"== "7" /y1995,y2000,y2010,y2020,y2030,y2040,y2050/;
$If "%c_timesteps%"== "8" /y1995,y2000,y2010,y2020,y2030,y2040,y2050,y2060/;
$If "%c_timesteps%"== "9" /y1995,y2000,y2010,y2020,y2030,y2040,y2050,y2060,y2070/;
$If "%c_timesteps%"=="10" /y1995,y2000,y2010,y2020,y2030,y2040,y2050,y2060,y2070,y2080/;
$If "%c_timesteps%"=="11" /y1995,y2000,y2010,y2020,y2030,y2040,y2050,y2060,y2070,y2080,y2090/;
$If "%c_timesteps%"=="12" /y1995,y2000,y2010,y2020,y2030,y2040,y2050,y2060,y2070,y2080,y2090,y2100/;
$If "%c_timesteps%"=="13" /y1995,y2000,y2010,y2020,y2030,y2040,y2050,y2060,y2070,y2080,y2090,y2100,y2110/;
$If "%c_timesteps%"=="14" /y1995,y2000,y2010,y2020,y2030,y2040,y2050,y2060,y2070,y2080,y2090,y2100,y2110,y2120/;
$If "%c_timesteps%"=="15" /y1995,y2000,y2010,y2020,y2030,y2040,y2050,y2060,y2070,y2080,y2090,y2100,y2110,y2120,y2130/;
$If "%c_timesteps%"=="16" /y1995,y2000,y2010,y2020,y2030,y2040,y2050,y2060,y2070,y2080,y2090,y2100,y2110,y2120,y2130,y2140/;
$If "%c_timesteps%"=="17" /y1995,y2000,y2010,y2020,y2030,y2040,y2050,y2060,y2070,y2080,y2090,y2100,y2110,y2120,y2130,y2140,y2150/;
$If "%c_timesteps%"=="past" /y1965,y1970,y1975,y1980,y1985,y1990,y1995,y2000,y2005,y2010/;
$If "%c_timesteps%"=="pastandfuture" /y1965,y1970,y1975,y1980,y1985,y1990,y1995,y2000,y2005,y2010,y2015,y2020,y2025,y2030,y2035,y2040,y2045,y2050,y2055,y2060,y2065,y2070,y2075,y2080,y2085,y2090,y2095,y2100/;
set ct(t) Current time period;
set ct_all(t_all) Current time period for loops over t_all;

alias(t,t2);

sets

***Products***

   kall All products in the sectoral version
   /
   tece,maiz,trce,rice_pro,soybean,rapeseed,groundnut,sunflower,oilpalm,puls_pro,
   potato,cassav_sp,sugr_cane,sugr_beet,others,cottn_pro,foddr, pasture, begr, betr,
   oils,oilcakes,sugar,molasses,alcohol,ethanol,distillers_grain,brans,scp,fibres,
   livst_rum, livst_pig,livst_chick, livst_egg, livst_milk, fish,
   res_cereals, res_fibrous, res_nonfibrous, wood, woodfuel
   /

  dev Economic development status
       / lic, mic, hic /

***TYPE OF WATER SUPPLY***
   w Water supply type / rainfed, irrigated /

***WATER SOURCES***
   wat_src Type of water source / surface, ground, technical, ren_ground /

***WATER DEMAND sectors***
   wat_dem Water demand sectors / agriculture, industry, electricity, domestic, ecosystem /

***LAND POOLS***
   land Land pools
        / crop, past, forestry, primforest, secdforest, urban, other /

  land_ag(land) Agricultural land pools
                  / crop, past /

  forest_land(land) land from which timber can be taken away
  / forestry, primforest, secdforest,other /

  land_natveg(forest_land) Natural vegetation land pools
        / primforest, secdforest, other /

  forest_type forest type
         / plantations, natveg /

   si Suitability classes
        / si0, nsi0 /

***Forestry**
   ac Age classes  / ac0,ac5,ac10,ac15,ac20,ac25,ac30,ac35,ac40,ac45,ac50,
                    ac55,ac60,ac65,ac70,ac75,ac80,ac85,ac90,ac95,ac100,
                    ac105,ac110,ac115,ac120,ac125,ac130,ac135,ac140,ac145,
                    ac150,ac155,acx /

  ac_est(ac) Dynamic subset of age classes for establishment

  ac_sub(ac) Dynamic subset of age classes excluding establishment

   chap_par Chapman-richards parameters / k,m /

*** Nutrients
   attributes Product attributes characterizing a product (such as weight or energy content)
   /dm,ge,nr,p,k,wm,c/
* dry matter, gross energy, reactive nitrogen, phosphorus, potash, wet matters

   nutrients(attributes) Nutrient related product attributes
   /dm,ge,nr,p,k/

  dm_ge_nr(nutrients) Attribtues relevant for nutrition
       / dm,ge,nr /

  npk(nutrients) Plant nutrients
   /nr,p,k/

  cgf Residue production functions
   /slope, intercept, bg_to_ag/

***Emissions ***

   emis_source Emission sources
   / inorg_fert, man_crop, awms, resid, man_past, som,
     rice, ent_ferm,
     resid_burn,
     crop_vegc, crop_litc, crop_soilc,
     past_vegc, past_litc, past_soilc,
     forestry_vegc, forestry_litc, forestry_soilc,
     primforest_vegc, primforest_litc, primforest_soilc,
secdforest_vegc, secdforest_litc, secdforest_soilc,     urban_vegc, urban_litc, urban_soilc,
     other_vegc, other_litc, other_soilc,
     beccs/

   emis_source_reg(emis_source) Regional emission sources
   / inorg_fert, man_crop, awms, resid, man_past, som,
     rice, ent_ferm, beccs /

   emis_source_cell(emis_source) Cellular emission sources
   / crop_vegc, crop_litc, crop_soilc,
     past_vegc, past_litc, past_soilc,
     forestry_vegc, forestry_litc, forestry_soilc,
     primforest_vegc, primforest_litc, primforest_soilc,
secdforest_vegc, secdforest_litc, secdforest_soilc,     urban_vegc, urban_litc, urban_soilc,
     other_vegc, other_litc, other_soilc /

   emis_co2(emis_source_cell) Land pool CO2 emission sources
   / crop_vegc, crop_litc, crop_soilc,
     past_vegc, past_litc, past_soilc,
     forestry_vegc, forestry_litc, forestry_soilc,
     primforest_vegc, primforest_litc, primforest_soilc,
secdforest_vegc, secdforest_litc, secdforest_soilc,     urban_vegc, urban_litc, urban_soilc,
     other_vegc, other_litc, other_soilc /

   co2_forestry(emis_source_cell) Sources of forestry land CO2 emissions
   /forestry_vegc, forestry_litc, forestry_soilc/

   c_pools Carbon pools
   /vegc,litc,soilc/

***TECHNICAL STUFF***
   type GAMS variable attribute used for the output / level, marginal, upper, lower /

***RELATIONSHIPS BETWEEN DIFFERENT SETS***

  emis_land(emis_co2,land,c_pools) Mapping between land and carbon pools
  /crop_vegc        . (crop) . (vegc)
   crop_litc        . (crop) . (litc)
   crop_soilc       . (crop) . (soilc)
   past_vegc        . (past) . (vegc)
   past_litc        . (past) . (litc)
   past_soilc       . (past) . (soilc)
   forestry_vegc    . (forestry) . (vegc)
   forestry_litc    . (forestry) . (litc)
   forestry_soilc   . (forestry) . (soilc)
   primforest_vegc  . (primforest) . (vegc)
   primforest_litc  . (primforest) . (litc)
   primforest_soilc . (primforest) . (soilc)
   secdforest_vegc  . (secdforest) . (vegc)
   secdforest_litc  . (secdforest) . (litc)
   secdforest_soilc . (secdforest) . (soilc)
   urban_vegc       . (urban) . (vegc)
   urban_litc       . (urban) . (litc)
   urban_soilc      . (urban) . (soilc)
   other_vegc       . (other) . (vegc)
   other_litc       . (other) . (litc)
   other_soilc      . (other) . (soilc)
   /

   emis_co2_to_forestry(co2_forestry,c_pools) Mapping between forestry land and carbon pools
  /forestry_vegc    . (vegc)
   forestry_litc    . (litc)
   forestry_soilc   . (soilc)
   /

;

alias(ac,ac2);
alias(ac_sub,ac_sub2);
alias(ac_est,ac_est2);

*** EOF sets.gms ***
