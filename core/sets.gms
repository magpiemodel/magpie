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

   i all economic regions /CAZ,CHA,EUR,IND,JPN,LAM,MEA,NEU,OAS,REF,SSA,USA/

   iso list of iso countries /
       ABW,AFG,AGO,AIA,ALA,ALB,AND,ARE,ARG,ARM,
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

   j number of LPJ cells /
       CAZ_1*CAZ_28,
       CHA_29*CHA_52,
       EUR_53*EUR_62,
       IND_63*IND_69,
       JPN_70*JPN_72,
       LAM_73*LAM_125,
       MEA_126*MEA_142,
       NEU_143*NEU_150,
       OAS_151*OAS_172,
       REF_173*REF_179,
       SSA_180*SSA_190,
       USA_191*USA_200/

   cell(i,j) number of LPJ cells per region i
      /
       CAZ . CAZ_1*CAZ_28
       CHA . CHA_29*CHA_52
       EUR . EUR_53*EUR_62
       IND . IND_63*IND_69
       JPN . JPN_70*JPN_72
       LAM . LAM_73*LAM_125
       MEA . MEA_126*MEA_142
       NEU . NEU_143*NEU_150
       OAS . OAS_151*OAS_172
       REF . REF_173*REF_179
       SSA . SSA_180*SSA_190
       USA . USA_191*USA_200
      /

   i_to_iso(i,iso) mapping regions to iso countries
      /
       CAZ . (AUS,CAN,HMD,NZL,SPM)
       CHA . (CHN,HKG,MAC,TWN)
       EUR . (ALA,AUT,BEL,BGR,CYP,CZE,DEU,DNK,ESP,EST)
       EUR . (FIN,FRA,FRO,GBR,GGY,GIB,GRC,HRV,HUN,IMN)
       EUR . (IRL,ITA,JEY,LTU,LUX,LVA,MLT,NLD,POL,PRT)
       EUR . (ROU,SVK,SVN,SWE)
       IND . (IND)
       JPN . (JPN)
       LAM . (ABW,AIA,ARG,ATA,ATG,BES,BHS,BLM,BLZ,BMU)
       LAM . (BOL,BRA,BRB,BVT,CHL,COL,CRI,CUB,CUW,CYM)
       LAM . (DMA,DOM,ECU,FLK,GLP,GRD,GTM,GUF,GUY,HND)
       LAM . (HTI,JAM,KNA,LCA,MAF,MEX,MSR,MTQ,NIC,PAN)
       LAM . (PER,PRI,PRY,SGS,SLV,SUR,SXM,TCA,TTO,URY)
       LAM . (VCT,VEN,VGB,VIR)
       MEA . (ARE,BHR,DZA,EGY,ESH,IRN,IRQ,ISR,JOR,KWT)
       MEA . (LBN,LBY,MAR,OMN,PSE,QAT,SAU,SDN,SYR,TUN)
       MEA . (YEM)
       NEU . (ALB,AND,BIH,CHE,GRL,ISL,LIE,MCO,MKD,MNE)
       NEU . (NOR,SJM,SMR,SRB,TUR,VAT)
       OAS . (AFG,ASM,ATF,BGD,BRN,BTN,CCK,COK,CXR,FJI)
       OAS . (FSM,GUM,IDN,IOT,KHM,KIR,KOR,LAO,LKA,MDV)
       OAS . (MHL,MMR,MNG,MNP,MYS,NCL,NFK,NIU,NPL,NRU)
       OAS . (PAK,PCN,PHL,PLW,PNG,PRK,PYF,SGP,SLB,THA)
       OAS . (TKL,TLS,TON,TUV,UMI,VNM,VUT,WLF,WSM)
       REF . (ARM,AZE,BLR,GEO,KAZ,KGZ,MDA,RUS,TJK,TKM)
       REF . (UKR,UZB)
       SSA . (AGO,BDI,BEN,BFA,BWA,CAF,CIV,CMR,COD,COG)
       SSA . (COM,CPV,DJI,ERI,ETH,GAB,GHA,GIN,GMB,GNB)
       SSA . (GNQ,KEN,LBR,LSO,MDG,MLI,MOZ,MRT,MUS,MWI)
       SSA . (MYT,NAM,NER,NGA,REU,RWA,SEN,SHN,SLE,SOM)
       SSA . (SSD,STP,SWZ,SYC,TCD,TGO,TZA,UGA,ZAF,ZMB)
       SSA . (ZWE)
       USA . (USA)
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
$If "%c_timesteps%"== "5year2150" /y1995,y2000,y2005,y2010,y2015,y2020,y2025,y2030,y2035,y2040,y2045,y2050,y2055,y2060,y2065,y2070,y2075,y2080,y2085,y2090,y2095,y2100,y2105,y2110,y2115,y2120,y2125,y2130,y2135,y2140,y2145,y2150/;
$If "%c_timesteps%"== "quicktest" /y1995,y2010,y2025/;
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
                    ac105,ac110,ac115,ac120,ac125,ac130,ac135,ac140,ac145,acx /

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
