*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

sets
   kli_rum(kli) Ruminant livestock
   /
   livst_rum, livst_milk
   /

   kli_mon(kli) Monogastric livestock
   /
   livst_pig, livst_chick, livst_egg
   /
   
   kforage(k) Forage feed categories
   /
	pasture, foddr
   / 
; 

alias(j,j3);
alias(cell,cell2);
alias(kforage,kforage2);
