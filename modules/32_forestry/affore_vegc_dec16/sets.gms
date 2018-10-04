*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de
sets
***FORESTRY COST TYPES***
   fcosts32 Forestry factor cost types
           / recur,mon /

  land32 Forestry land pools
    / new, new_ndc, prot, grow, old/

  pol32 Afforestation policy
    / none, npi, ndc/

   ac_land32(ac,land32) Mapping between age class and forestry land type

   kforestry(kall) Forestry products
   / wood, woodfuel /
;
*** EOF sets.gms ***
