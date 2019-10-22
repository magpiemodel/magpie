*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
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

   i all economic regions /EAS,EEU,FSU,MEN,NAO,NEU,SAS,SCA,SEU,SSA,WEU,XEU/

   iso list of iso countries /
       ASM,AUS,NFK,NZL,BRA,CAN,SPM,CHN,HKG,MAC,
       ALA,ALB,AND,AUT,BEL,BGR,BIH,CHE,CYP,CZE,
       DEU,DNK,ESP,EST,FIN,FRA,FRO,GBR,GGY,GIB,
       GRC,GRL,HRV,HUN,IMN,IRL,ISL,ITA,JEY,LIE,
       LTU,LUX,LVA,MCO,MKD,MLT,MNE,NLD,NOR,POL,
       PRT,ROU,SJM,SMR,SRB,SVK,SVN,SWE,VAT,ARM,
       AZE,BLR,GEO,KAZ,KGZ,MDA,RUS,TJK,TKM,UKR,
       UZB,IND,IOT,ARE,BHR,DZA,EGY,ESH,IRN,IRQ,
       ISR,JOR,KWT,LBN,LBY,MAR,OMN,PSE,QAT,SAU,
       SYR,TUN,TUR,YEM,AFG,BGD,BTN,COK,FJI,FSM,
       KIR,LKA,MDV,MHL,MNG,NCL,NIU,NPL,NRU,PAK,
       PLW,PNG,PYF,SLB,TKL,TON,TUV,VUT,WLF,WSM,
       ABW,AIA,ARG,ATA,ATG,BES,BHS,BLM,BLZ,BMU,
       BOL,BRB,CHL,COL,CRI,CUB,CUW,CYM,DMA,DOM,
       ECU,FLK,GLP,GRD,GTM,GUF,GUY,HND,HTI,JAM,
       KNA,LCA,MAF,MEX,MSR,MTQ,NIC,PAN,PER,PRI,
       PRY,SGS,SLV,SUR,SXM,TCA,TTO,URY,VCT,VEN,
       VGB,VIR,BRN,CCK,CXR,GUM,IDN,JPN,KHM,KOR,
       LAO,MMR,MNP,MYS,PCN,PHL,PRK,SGP,THA,TLS,
       TWN,VNM,AGO,ATF,BDI,BEN,BFA,BVT,BWA,CAF,
       CIV,CMR,COD,COG,COM,CPV,DJI,ERI,ETH,GAB,
       GHA,GIN,GMB,GNB,GNQ,HMD,KEN,LBR,LSO,MDG,
       MLI,MOZ,MRT,MUS,MWI,MYT,NAM,NER,NGA,REU,
       RWA,SDN,SEN,SHN,SLE,SOM,SSD,STP,SWZ,SYC,
       TCD,TGO,TZA,UGA,ZAF,ZMB,ZWE,UMI,USA /

   j number of LPJ cells /
       EAS_1*EAS_46,
       EEU_47*EEU_50,
       FSU_51*FSU_63,
       MEN_64*MEN_95,
       NAO_96*NAO_167,
       NEU_168*NEU_175,
       SAS_176*SAS_204,
       SCA_205*SCA_285,
       SEU_286*SEU_294,
       SSA_295*SSA_390,
       WEU_391*WEU_396,
       XEU_397*XEU_400/

   cell(i,j) number of LPJ cells per region i
      /
       EAS . EAS_1*EAS_46
       EEU . EEU_47*EEU_50
       FSU . FSU_51*FSU_63
       MEN . MEN_64*MEN_95
       NAO . NAO_96*NAO_167
       NEU . NEU_168*NEU_175
       SAS . SAS_176*SAS_204
       SCA . SCA_205*SCA_285
       SEU . SEU_286*SEU_294
       SSA . SSA_295*SSA_390
       WEU . WEU_391*WEU_396
       XEU . XEU_397*XEU_400
      /

   i_to_iso(i,iso) mapping regions to iso countries
      /
       EAS . (CHN,HKG,MAC,MNG,JPN,KOR,PRK,TWN)
       EEU . (BGR,CZE,HRV,HUN,POL,ROU,SVK,SVN)
       FSU . (ARM,AZE,BLR,GEO,KAZ,KGZ,MDA,RUS,TJK,TKM)
       FSU . (UKR,UZB)
       MEN . (ARE,BHR,DZA,EGY,ESH,IRN,IRQ,ISR,JOR,KWT)
       MEN . (LBN,LBY,MAR,OMN,PSE,QAT,SAU,SYR,TUN,TUR)
       MEN . (YEM)
       NAO . (ASM,AUS,NFK,NZL,CAN,SPM,COK,FJI,FSM,KIR)
       NAO . (MHL,NCL,NIU,NRU,PLW,PYF,SLB,TKL,TON,TUV)
       NAO . (VUT,WSM,UMI,USA)
       NEU . (ALA,DNK,EST,FIN,FRO,GBR,GGY,GRL,IMN,IRL)
       NEU . (JEY,LTU,LVA,SWE)
       SAS . (IND,IOT,AFG,BGD,BTN,LKA,MDV,NPL,PAK,PNG)
       SAS . (WLF,BRN,CCK,CXR,GUM,IDN,KHM,LAO,MMR,MNP)
       SAS . (MYS,PCN,PHL,SGP,THA,TLS,VNM)
       SCA . (BRA,ABW,AIA,ARG,ATA,ATG,BES,BHS,BLM,BLZ)
       SCA . (BMU,BOL,BRB,CHL,COL,CRI,CUB,CUW,CYM,DMA)
       SCA . (DOM,ECU,FLK,GLP,GRD,GTM,GUF,GUY,HND,HTI)
       SCA . (JAM,KNA,LCA,MAF,MEX,MSR,MTQ,NIC,PAN,PER)
       SCA . (PRI,PRY,SGS,SLV,SUR,SXM,TCA,TTO,URY,VCT)
       SCA . (VEN,VGB,VIR)
       SEU . (AND,CYP,ESP,GIB,GRC,ITA,MCO,MLT,PRT,SMR)
       SEU . (VAT)
       SSA . (AGO,ATF,BDI,BEN,BFA,BVT,BWA,CAF,CIV,CMR)
       SSA . (COD,COG,COM,CPV,DJI,ERI,ETH,GAB,GHA,GIN)
       SSA . (GMB,GNB,GNQ,HMD,KEN,LBR,LSO,MDG,MLI,MOZ)
       SSA . (MRT,MUS,MWI,MYT,NAM,NER,NGA,REU,RWA,SDN)
       SSA . (SEN,SHN,SLE,SOM,SSD,STP,SWZ,SYC,TCD,TGO)
       SSA . (TZA,UGA,ZAF,ZMB,ZWE)
       WEU . (AUT,BEL,DEU,FRA,LUX,NLD)
       XEU . (ALB,BIH,CHE,ISL,LIE,MKD,MNE,NOR,SJM,SRB)
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

    t_future(t_all) 5-year time periods
    / y2105, y2110, y2115, y2120, y2125, y2130, y2135, y2140,
      y2145, y2150 /

    t_past(t_all) Timesteps with observed data
        / y1965, y1970, y1975,
         y1980, y1985, y1990,
         y1995, y2000, y2005, y2010
        /
    t_past_ff(t_past) Time stamps before 1995
    / y1965, y1970, y1975,
     y1980, y1985, y1990 /

    t_past_forestry(t_all) Forestry Timesteps with observed data
    / y1965, y1970, y1975,
     y1980, y1985, y1990,
     y1995, y2000, y2005, y2010, y2015
    /
;

set t(t_all) Simulated time periods
$If "%c_timesteps%"== "less_TS" /y1995,y2000,y2005,y2010,y2015,y2020,y2025,y2030,y2035,y2040,y2045,y2050,y2055,y2060,y2070,y2080,y2090,y2100,y2110,y2130,y2150/;
$If "%c_timesteps%"== "coup2100" /y1995,y2000,y2005,y2010,y2015,y2020,y2025,y2030,y2035,y2040,y2045,y2050,y2055,y2060,y2070,y2080,y2090,y2100/;
$If "%c_timesteps%"== "test_TS" /y1995,y2000,y2005,y2010,y2020,y2030,y2040,y2050,y2070,y2090,y2110,y2130,y2150/;
$If "%c_timesteps%"== "TS_benni" /y1995,y2000,y2005,y2010,y2020,y2030,y2040,y2050/;
$If "%c_timesteps%"== "TS_WB" /y1995,y2000,y2005,y2010,y2020,y2030,y2040,y2050,y2060,y2070,y2080/;
$If "%c_timesteps%"== "5year" /y1995,y2000,y2005,y2010,y2015,y2020,y2025,y2030,y2035,y2040,y2045,y2050,y2055,y2060,y2065,y2070,y2075,y2080,y2085,y2090,y2095,y2100/;
$If "%c_timesteps%"== "10y" /y1995,y2000,y2005,y2010,y2015,y2020,y2025,y2030,y2035,y2040,y2050,y2060,y2070,y2080,y2090,y2100/;
$If "%c_timesteps%"== "20y" /y1995,y2000,y2005,y2010,y2015,y2020,y2025,y2030,y2035,y2040,y2060,y2080,y2095,y2100/;
$If "%c_timesteps%"== "30y" /y1995,y2000,y2005,y2010,y2015,y2020,y2025,y2030,y2035,y2040,y2070,y2100/;
$If "%c_timesteps%"== "50y" /y1995,y2000,y2005,y2010,y2015,y2020,y2050,y2100/;
$If "%c_timesteps%"== "5year2050" /y1995,y2000,y2005,y2010,y2015,y2020,y2025,y2030,y2035,y2040,y2045,y2050/;
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

  hvarea_timber(land) land from which timber can be taken away
  / forestry, primforest, secdforest,other /

  land_natveg(land) Natural vegetation land pools
        / primforest, secdforest, other /

   si Suitability classes
        / si0, nsi0 /

***Forestry**
   ac Age classes  / ac0,ac5,ac10,ac15,ac20,ac25,ac30,ac35,ac40,ac45,ac50,
                    ac55,ac60,ac65,ac70,ac75,ac80,ac85,ac90,ac95,ac100,
                    ac105,ac110,ac115,ac120,ac125,ac130,ac135,ac140,ac145,ac150,
                    ac155,ac160,ac165,ac170,ac175,ac180,ac185,ac190,ac195,ac200,
                    ac205,ac210,ac215,ac220,ac225,ac230,ac235,ac240,ac245,ac250,
                    ac255,ac260,ac265,ac270,ac275,ac280,ac285,ac290,ac295,acx /

  ac_sub(ac) age classes
  / ac5,ac10,ac15,ac20,ac25,ac30,ac35,ac40,ac45,ac50,
  ac55,ac60,ac65,ac70,ac75,ac80,ac85,ac90,ac95,ac100,
  ac105,ac110,ac115,ac120,ac125,ac130,ac135,ac140,ac145,ac150,
  ac155,ac160,ac165,ac170,ac175,ac180,ac185,ac190,ac195,ac200,
  ac205,ac210,ac215,ac220,ac225,ac230,ac235,ac240,ac245,ac250,
  ac255,ac260,ac265,ac270,ac275,ac280,ac285,ac290,ac295,acx /

   when Temporal location relative to optimization / before, after /

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

*** EOF sets.gms ***
