*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

scalars

s42_watdem_nonagr_scenario         Scenario for non agricultural water demand from WATERGAP     (1)             / 1 /
*                                                                                1: SSP 2
*                                                                                2: A2
*                                                                                3: B1

s42_irrig_eff_scenario     Scenario for irrigation efficiency      (1)      / 2 /
*                                      1: global static value
*                                      2: regional static values from CS
*                                      3: gdp driven increase

s42_irrigation_efficiency              Value of irrigation efficiency.         (1)      / 0.66 /
*                                      Only if global static value is requested

s42_env_flow_scenario              Environmental flow protection scenario.         (1)      / 2 /
*                                  0: don't consider environmental flows.
*                                                                          s42_env_flow_base_fraction and
*                                                                          s42_env_flow_fraction have no effect.
*                                  1: Reserve a certain fraction of available water
*                                     specified by s42_env_flow_fraction for
*                                     environmental flows.
*                                  2: Each grid cell receives its own value for
*                                     environmental flow protection based on LPJ
*                                     results and a calculation algorithm by Smakhtin 2004.
*                                                                          s42_env_flow_fraction has no effect.

s42_env_flow_base_fraction         Fraction of available water that is reserved for the environment if no EFR protection policy is implemented (1)           / 0.05 /
*                                                                    (determined in the file
*                                                                   EFR_protection_policy.csv)
s42_env_flow_fraction              Fraction of available water that is reserved for under protection policies (1) / 0.2 /
;

$setglobal c42_watdem_scenario  nocc
*   options:   cc  (climate change)
*             nocc (no climate change)

* Set-switch for countries affected by EFP
* Default: all iso countries selected
sets
  EFP_countries(iso) countries to be affected by EFP / ABW,AFG,AGO,AIA,ALA,ALB,AND,ARE,ARG,ARM,
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

table f42_wat_req_kve(t_all,j,kve) LPJ annual water demand for irrigation per ha (m^3 per yr)
$ondelim
$include "./modules/42_water_demand/input/lpj_airrig.cs2"
$offdelim
;
$if "%c42_watdem_scenario%" == "nocc" f42_wat_req_kve(t_all,j,kve) = f42_wat_req_kve("y1995",j,kve);
m_fillmissingyears(f42_wat_req_kve,"j,kve");

parameter f42_wat_req_kli(kli) Average water requirements of livestock commodities per region per tDM per year (m^3 per yr)
/
$ondelim
$include "./modules/42_water_demand/input/f42_wat_req_fao.csv"
$offdelim
/;

table f42_watdem_ineldo(t_all,j,scen_watdem_nonagr,watdem_ineldo) Industry electricity and domestic water demand under our socioeconomic scenarios (mio. m^3)
$ondelim
$include "./modules/42_water_demand/input/watdem_nonagr_grper.cs3"
$offdelim
;
m_fillmissingyears(f42_watdem_ineldo,"j,scen_watdem_nonagr,watdem_ineldo");

parameter
f42_env_flows(t_all,j) Environmental flow requirements from LPJ and Smakhtin algorithm (mio. m^3)
/
$ondelim
$include "./modules/42_water_demand/input/lpj_envflow_grper.cs2"
$offdelim
/
;
$if "%c42_watdem_scenario%" == "nocc" f42_env_flows(t_all,j) = f42_env_flows("y1995",j);
m_fillmissingyears(f42_env_flows,"j");

$setglobal c42_env_flow_policy  off

table f42_env_flow_policy(t_all,scen42) EFP policies (1)
$ondelim
$include "./modules/42_water_demand/input/f42_env_flow_policy.cs3"
$offdelim
;
