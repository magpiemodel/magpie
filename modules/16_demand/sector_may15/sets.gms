*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

sets

   ksd(kall) Secondary products
   /oils,oilcakes,sugar,molasses,alcohol,ethanol,distillers_grain,brans,scp,fibres/

   kres(kall) Residues
   / res_cereals, res_fibrous, res_nonfibrous /

   kap(k) Animal products
   /
   livst_rum,livst_pig,livst_chick, livst_egg, livst_milk, fish
   /

   kli(kap) Livestock products
   / livst_rum, livst_pig, livst_chick, livst_egg, livst_milk  /

   kforestry(k) forestry products
          / wood, woodfuel /
 ;

alias(kap,kap4);
