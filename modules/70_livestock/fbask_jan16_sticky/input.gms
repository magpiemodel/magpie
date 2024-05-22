*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

$setglobal c70_feed_scen  ssp2
*   options:    SSP: ssp1, ssp2, ssp3, ssp4, ssp5
*               SDP: SDP, SDP_EI, SDP_MC, SDP_RC
*               other: constant

* Feed substitution scenarios including functional forms, targets and transition periods
*   options:   constant,
*              lin_zero_10_50, lin_zero_20_50, lin_zero_20_30, lin_50pc_20_50, lin_50pc_20_50_extend65, lin_50pc_20_50_extend80,
*              lin_50pc_10_50_extend90, lin_75pc_10_50_extend90, lin_80pc_20_50, lin_80pc_20_50_extend95, lin_90pc_20_50_extend95,
*              lin_99-98-90pc_20_50-60-100, sigmoid_20pc_20_50, sigmoid_50pc_20_50, sigmoid_80pc_20_50
$setglobal c70_cereal_scp_scen  constant
$setglobal c70_foddr_scp_scen  constant

$setglobal c70_fac_req_regr  glo
* options: glo, reg

scalars
  s70_pyld_intercept     Intercept of linear relationship determining pasture intensification (1)        / 0.24 /
  s70_past_mngmnt_factor_fix  Year until the pasture management factor is fixed to 1    / 2005 /  
  s70_subst_functional_form                  Switch for functional form of feed substitution scenario fader (1) / 1 /
  s70_feed_substitution_start                Feed substitution start year        / 2025 /
  s70_feed_substitution_target               Feed substitution target year       / 2050 /
  s70_cereal_scp_substitution                Cereal feed substitution with SCP share (1) / 0 /
  s70_foddr_scp_substitution                 Fodder substitution with SCP share (1) / 0 /
  s70_depreciation_rate                      Yearly depreciation rate for capital stocks  / 0.05 /
  s70_multiplicator_capital_need             Multiplicator for capital need in livestock production  / 1 /
;

table f70_feed_baskets(t_all,i,kap,kall,feed_scen70) Feed baskets in tDM per tDM livestock product (1)
$ondelim
$include "./modules/70_livestock/fbask_jan16_sticky/input/f70_feed_baskets.cs3"
$offdelim;

table fm_feed_balanceflow(t_all,i,kap,kall) Balanceflow balance difference between estimated feed baskets and FAO (mio. tDM)
$ondelim
$include "./modules/70_livestock/fbask_jan16_sticky/input/f70_feed_balanceflow.cs3"
$offdelim;

table f70_livestock_productivity(t_all,i,sys,feed_scen70) Productivity indicator for livestock production (t FM per animal)
$ondelim
$include "./modules/70_livestock/fbask_jan16_sticky/input/f70_livestock_productivity.cs3"
$offdelim;

table f70_cost_regr(kap,cost_regr) Factor requirements livestock (USD04 per tDM (A) and USD (B))
$ondelim
$include "./modules/70_livestock/fbask_jan16_sticky/input/f70_capit_liv_regr.csv"
$offdelim
;

parameter f70_slaughter_feed_share(t_all,i,kap,attributes,feed_scen70) Share of feed that is incorprated in animal biomass (1)
/
$ondelim
$include "./modules/70_livestock/fbask_jan16_sticky/input/f70_slaughter_feed_share.cs4"
$offdelim
/
;

parameter f70_pyld_slope_reg(i) Regional slope of linear relationship determining pasture intensification (1)
/
$ondelim
$include "./modules/70_livestock/fbask_jan16_sticky/input/f70_pyld_slope_reg.cs4"
$offdelim
/;

parameter f70_cap_share_reg(share_regr) Parameters for regression
/
$ondelim
$include "./modules/70_livestock/fbask_jan16_sticky/input/f70_cap_share_reg.csv"
$offdelim
/
;

table f70_hist_cap_share(t_all,i) Historical capital share
$ondelim
$include "./modules/70_livestock/fbask_jan16_sticky/input/f70_hist_cap_share.csv"
$offdelim
;

table f70_hist_factor_costs_livst(t_all,i,kli) Historical factor costs in livestock production (mio. USD05MER)
$ondelim
$include "./modules/70_livestock/fbask_jan16_sticky/input/f70_hist_factor_costs_livst.cs3"
$offdelim
;

table f70_hist_prod_livst(t_all,i,kli,attributes) Historical production quantity of livestock products (mio. t)
$ondelim
$include "./modules/70_livestock/fbask_jan16_sticky/input/f70_hist_prod_livst.cs3"
$offdelim
;

* Set-switch for countries affected by country-specific exogenous diet scenario
* Default: all iso countries selected
sets
  scen_countries70(iso) countries to be affected by selected feed sceanrio / 
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
;
