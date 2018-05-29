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
