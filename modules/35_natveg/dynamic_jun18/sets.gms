*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

sets
  land35 natveg land pools
    / new, grow, old /

   pol35 afforestation policy type
    / none, npi, ndc/

   ac_land35(ac,land35) mapping between age classes and aggregated land types

   prot_type conservation priority areas
   / BH, CPD, FF, LW, WDPA /

   ac_new(ac) new / ac0 / 
   ac_grow(ac) grow  / ac5,ac10,ac15,ac20,ac25,ac30,ac35,ac40,ac45,ac50,ac55,ac60,ac65,ac70,ac75,ac80,ac85,ac90,ac95,ac100,
                    ac105,ac110,ac115,ac120,ac125,ac130,ac135,ac140,ac145,ac150,
                    ac155,ac160,ac165,ac170,ac175,ac180,ac185,ac190,ac195,ac200,
                    ac205,ac210,ac215,ac220,ac225,ac230,ac235,ac240,ac245,ac250,
                    ac255,ac260,ac265,ac270,ac275,ac280,ac285,ac290,ac295 /
   ac_old(ac) old / acx / 

	ac_poulter forest age classes in poulter data set
	/ class1, class2, class3, class4, class5, class6, class7, class8, class9, class10, 
	class11, class12, class13, class14, class15 /
	
	ac_to_ac_poulter(ac,ac_poulter) mapping between ac and ac_poulter
     / ac10 . (class1)
       ac20 . (class2)
       ac30 . (class3)
       ac40 . (class4)
       ac50 . (class5)
       ac60 . (class6)
       ac70 . (class7)
       ac80 . (class8)
       ac90 . (class9)
       ac100 . (class10)
       ac110 . (class11)
       ac120 . (class12)
       ac130 . (class13)
       ac140 . (class14)
       acx   . (class15) /
;

alias(ac,ac2);
